(define-module (tassos-guix closure)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages haskell-xyz)
  #:use-module (gnu packages haskell-apps)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gnupg)
  #:use-module (guix gexp)
  #:use-module (guix modules)
  #:use-module (guix profiles)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system trivial)
  #:use-module (guix build-system haskell)
  #:use-module ((guix licenses) #:prefix license:)

  #:export (package-manifest-closure))

(define (package-manifest-closure target others)
  (define target-name
    (package-name target))

  (define wrapper-name
    (string-append target-name "-wrapper.scm"))

  (define backing-manifest
    (packages->manifest
     (cons target others)))

  (define backing-profile
    (profile
     (name "backing-profile")
     (content backing-manifest)))

  (define env-closure-wrapper-script
    (program-file wrapper-name
                  (with-extensions (list guile-gcrypt)
                    (with-imported-modules (source-module-closure
                                            '((guix profiles)))
                      #~(begin
                          (use-modules (guix profiles))

                          (let ((raw-args (cdr (command-line))))
                            (load-profile #$backing-profile)
                            (apply execl `(#$(file-append target "/bin/" target-name) #$target-name ,@raw-args))))))))


  (package
    (inherit target)
    (name (string-append target-name "-closure"))
    (source env-closure-wrapper-script)
    (build-system copy-build-system)
    (arguments
     `(#:install-plan
       '((,wrapper-name ,(string-append "bin/" target-name)))
       #:phases
       (modify-phases %standard-phases
         (add-after 'install 'chmod
           (lambda* (#:key outputs #:allow-other-keys)
             (let* ((out (assoc-ref outputs "out"))
                    (result (string-append out "/bin/" ,target-name)))
               (chmod result #o555)))))))))

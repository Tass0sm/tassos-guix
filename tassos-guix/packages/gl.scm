(define-module (tassos-guix packages gl)
  #:use-module (gnu packages)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages vim)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system cmake)
  #:use-module ((guix licenses) #:prefix license:))

(define-public libfond
  (let ((commit "02577826694d1f2cf865b0d408aedc5bc2d9623a")
        (revision "1"))
    (package
      (name "libfond")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/Shirakumo/libfond")
               (commit commit)))
         (file-name (git-file-name "libfond" version))
         (sha256
          (base32 "0lcrx5q8av8rrv1wd6myqxijihn9h9dkjraddmz1pw953jp54n1m"))))
      (build-system cmake-build-system)
      (arguments
       (list #:phases
             #~(modify-phases %standard-phases
                 (add-after 'unpack 'fix-install-destination
                   (lambda* (#:key inputs #:allow-other-keys)
                     (substitute* "CMakeLists.txt"
                       (("/usr/local" _) #$output))
                     #t))
                 (delete 'check))))
      (inputs
       (list mesa glew glfw xxd))
      (home-page "https://github.com/Shirakumo/libfond")
      (synopsis "")
      (description "")
      (license license:expat))))

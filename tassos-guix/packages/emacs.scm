(define-module (tassos-guix packages emacs)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages text-editors)
  #:use-module (gnu packages tree-sitter)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:))

(define-public emacs-next-pgtk-treesitter
  (let ((commit "c8eeaa4ae4aea05ccf66f415be20842d8447bad7")
        (revision "1"))
    (package
      (inherit emacs-next-pgtk)
      (name "emacs-next-pgtk-treesitter")
      (version (git-version "29.0.50" revision commit))
      (source
       (origin
         (inherit (package-source emacs-next-pgtk))
         (uri (git-reference
               (url "https://git.savannah.gnu.org/git/emacs.git/")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32
           "0qnw2v6rps142xpppgbdb0crrxq598dcisbaqm2c8hsncdcfk0i7"))))
      (native-inputs
       (modify-inputs (package-native-inputs emacs-next-pgtk)
                      (prepend tree-sitter)))
      (synopsis "Emacs text editor with @code{pgtk}, @code{xwidgets}, and @code{tree sitter} support.")
      (description "This Emacs build implements graphical UI purely in terms of
GTK, enables xwidgets, and includes a tree sitter API."))))

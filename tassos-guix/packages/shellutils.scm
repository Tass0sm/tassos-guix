(define-module (tassos-guix packages shellutils)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:))

(define-public zsh-pure
  (package
    (name "zsh-pure")
    (version "1.20.1")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/sindresorhus/pure")
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "1bxg5i3a0dm5ifj67ari684p89bcr1kjjh6d5gm46yxyiz9f5qla"))))
   (build-system copy-build-system)
   (arguments
    `(#:install-plan
      '(("." "/share/zsh/plugins/pure/"))))
    (home-page "https://github.com/sindresorhus/pure")
    (synopsis "Prompt for zsh")
    (description
     "Prompt for zsh")
    (license license:x11)))

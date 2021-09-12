(define-module (tassos-guix packages xorg)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix utils)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system copy))

(define-public xcursor-nordzy
  (package
   (name "xcursor-nordzy")
   (version "0.1.1")
   (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/alvatip/Nordzy-cursors")
                  (commit "7603b2a8dd75ef6c4afdc0e2ab4759ab7cc769c4")))
	    (file-name (git-file-name name version))
            (sha256
             (base32
	      "0h2zrf7s87kkzw8azmac4k79pcj7z8ml1bk5xfz3yazza0xsnx7v"))))
   (build-system copy-build-system)
   (arguments
    `(#:install-plan
      '(("Nordzy-cursors/" "share/icons/Nordzy-cursors")
	("Nordzy-cursors-white/" "share/icons/Nordzy-cursors-white"))))
   (home-page "https://github.com/alvatip/Nordzy-cursors")
   (synopsis "Cursor theme using the Nord color palette and based on Vimix and
cz-Viator.")
   (description "Cursor theme using the Nord color palette and based on Vimix
and cz-Viator.")
   (license license:gpl3)))

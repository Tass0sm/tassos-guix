(define-module (tassos-guix packages mail)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages ninja)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages webkit)
  #:use-module (gnu packages autotools)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build utils)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module ((guix licenses) #:prefix license:))

(define-public libmspack
  (package
    (name "libmspack")
    (version "v0.10.1alpha")
    (source (origin
              (method url-fetch)
              (uri "https://www.cabextract.org.uk/libmspack/libmspack-0.10.1alpha.tar.gz")
              (sha256
               (base32 "13janaqsvm7aqc4agjgd4819pbgqv50j88bh5kci1z70wvg65j5s"))))
    (build-system gnu-build-system)
    (native-inputs
     (list autoconf))
    (home-page "https://www.cabextract.org.uk/libmspack/")
    (synopsis "A library for Microsoft compression formats")
    (description "Libmspack is a library for dealing with Microsoft compression formats.")
    (license license:gpl2+)))

(define-public evolution-ews
  (package
    (name "evolution-ews")
    (version "3.46.4")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://gitlab.gnome.org/GNOME/evolution-ews.git")
             (commit version)))
       (sha256
        (base32 "12w1gwkhrcn5viwggc5h0wpxk9zsbfhzsm535h93cg1gq6b7qf2p"))))
    (build-system cmake-build-system)
    (native-inputs
     (append
      (list
       `(,glib "bin")
       json-glib
       libmspack
       ninja
       evolution)
      (map cadr (package-inputs evolution))
      (map cadr (package-native-inputs evolution))))
    (arguments
     (list
      #:configure-flags
      #~(list
         (string-append "-DLIBEXEC_INSTALL_DIR=" #$output "/lib")
         (string-append "-DSYSCONF_INSTALL_DIR=" #$output "/etc")
         "-DFORCE_INSTALL_PREFIX=ON")))
    (native-search-paths
     (list
      (search-path-specification
       (variable "EDS_EXTRA_PREFIXES")
       (files (list "")))))
    (home-page "https://gitlab.gnome.org/GNOME/evolution-ews")
    (synopsis "MS Exchange integration through Exchange Web Services")
    (description
     "MS Exchange integration for the Evolution mail client using Exchange Web
Services.")
    (license license:lgpl2.1)))

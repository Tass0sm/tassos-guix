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
  #:use-module (guix build-system trivial)
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
    (version "3.46.0")
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
    (home-page "https://gitlab.gnome.org/GNOME/evolution-ews")
    (synopsis "MS Exchange integration through Exchange Web Services")
    (description
     "MS Exchange integration for the Evolution mail client using Exchange Web
Services.")
    (license license:lgpl2.1)))

(define-public evolution-with-plugins
  #f
  ;; derivation that is the directory union of evolution data server + a list of plugins
  ;; after building:
  ;; wrap everyprogram in bin and libexec with these settings:

  ;; LD_LIBRARY_PATH "$out/lib" \
  ;; EDS_ADDRESS_BOOK_MODULES "$out/lib/evolution-data-server/addressbook-backends/" \
  ;; EDS_CALENDAR_MODULES "$out/lib/evolution-data-server/calendar-backends/" \
  ;; EDS_CAMEL_PROVIDER_DIR "$out/lib/evolution-data-server/camel-providers/" \
  ;; EDS_REGISTRY_MODULES "$out/lib/evolution-data-server/registry-modules/" \
  ;; EVOLUTION_MODULEDIR "$out/lib/evolution/modules"

  ;; then fix some symlinks (clarification needed)
  ;; https://github.com/symphorien/nixpkgs/blob/f45f22d51901eb85a6bd4628681bcbf2732655af/pkgs/applications/networking/mailreaders/evolution/evolution/wrapper.nix
  )

;; then
;; install evolution-with-plugins with evolution and evolution-ews as plugins.




;; (define-public evolution-with-ews
;;   (package
;;     (inherit evolution)
;;     (name "evolution-with-ews")
;;     (inputs
;;      `(,@(package-inputs evolution)
;;        ("evolution-ews" ,evolution-ews)))
;;     (arguments
;;      `(#:imported-modules (,@%cmake-build-system-modules
;;                            (guix build glib-or-gtk-build-system))
;;        #:modules ((guix build cmake-build-system)
;;                   ((guix build glib-or-gtk-build-system) #:prefix glib-or-gtk:)
;;                   (guix build utils))
;;        #:configure-flags
;;        (list "-DENABLE_PST_IMPORT=OFF"    ; libpst is not packaged
;;              "-DENABLE_LIBCRYPTUI=OFF")   ; libcryptui hasn't seen a release
;;                                           ; in four years and cannot be built.
;;        #:phases
;;        (modify-phases %standard-phases
;;          ;; The build system attempts to install user interface modules to the
;;          ;; output directory of the "evolution-data-server" package.  This
;;          ;; change redirects that change.
;;          (add-after 'unpack 'patch-ui-module-dir
;;            (lambda* (#:key outputs #:allow-other-keys)
;;              (substitute* "src/modules/alarm-notify/CMakeLists.txt"
;;                (("\\$\\{edsuimoduledir\\}")
;;                 (string-append (assoc-ref outputs "out")
;;                                "/lib/evolution-data-server/ui-modules")))))
;;          (add-after 'install 'install-evolution-ews
;;            (lambda _
;;              (copy-recursively (assoc-ref %build-inputs "evolution-ews") %output)))
;;          (add-after 'install 'glib-or-gtk-compile-schemas
;;            (assoc-ref glib-or-gtk:%standard-phases 'glib-or-gtk-compile-schemas))
;;          (add-after 'install 'glib-or-gtk-wrap
;;            (assoc-ref glib-or-gtk:%standard-phases 'glib-or-gtk-wrap)))))))

;; (define-public evolution-with-ews
;;   (package
;;     (name "evolution-with-ews")
;;     (version "3.42.1")
;;     (source evolution)
;;     (build-system trivial-build-system)
;;     (inputs
;;      `(("evolution-ews" ,evolution-ews)))
;;     (arguments
;;      `(#:modules ((guix build utils))
;;        #:builder
;;        (begin
;;          (use-modules (guix build utils)
;;                       (ice-9 match))
;;          (mkdir-p %output)
;;          (copy-recursively (assoc-ref %build-inputs "source") %output)
;;          )))
;;     (home-page "")
;;     (synopsis "")
;;     (description "")
;;     (license license:gpl3+)))

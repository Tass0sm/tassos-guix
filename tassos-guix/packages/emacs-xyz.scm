(define-module (tassos-guix packages emacs-xyz)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages crates-graphics)
  #:use-module (gnu packages emacs-xyz)

  #:use-module (tassos-guix packages crates-io)

  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module (guix build-system cargo)
  #:use-module ((guix licenses) #:prefix license:))

(define-public emacs-tsc-dyn
  (package
    (name "emacs-tsc-dyn")
    (version "0.15.2")
    (source
     (origin
       (method url-fetch)
       (uri
	"file:///home/tassos/software/emacs-tsc-dyn")
       (sha256
	(base32
	 "08lmfr7n2yvfmwrr7ifp6pp9c9vd16zkf1wvyl3f13dj849j8qzm"))))
    (build-system cargo-build-system)
    (native-inputs
     `(("clang" ,clang)))
    (arguments
     `(#:cargo-inputs
       (("rust-emacs" ,rust-emacs-0.17)
	("rust-libloading" ,rust-libloading-0.7)
	("rust-tree-sitter" ,rust-tree-sitter-0.19)
	("rust-once-cell" ,rust-once-cell-1))))
    (home-page
     "https://github.com/emacs-tree-sitter/elisp-tree-sitter/tree/master/core")
    (synopsis "Emacs Tree-Sitter Dynamic Module")
    (description
     "This is the core APIs of the Emacs binding for Tree-sitter, an incremental
parsing system.")
    (license #f)))

;; (define-public emacs-vterm
;;   (let ((version "0.0.1")
;;         (revision "0")
;;         (commit "a670b786539d3c8865d8f68fe0c67a2d4afbf1aa"))
;;     (package
;;       (name "emacs-vterm")
;;       (version (git-version version revision commit))
;;       (source (origin
;;                 (method git-fetch)
;;                 (uri (git-reference
;;                       (url "https://github.com/akermu/emacs-libvterm")
;;                       (commit commit)))
;;                 (file-name (git-file-name name version))
;;                 (sha256
;;                  (base32
;;                   "0s244crjkbzl2jhp9m4sm1xdhbpxwph0m3jg18livirgajvdz6hn"))))
;;       (build-system emacs-build-system)
;;       (arguments
;;        `(#:modules ((guix build emacs-build-system)
;;                     ((guix build cmake-build-system) #:prefix cmake:)
;;                     (guix build emacs-utils)
;;                     (guix build utils))
;; 		   #:imported-modules (,@%emacs-build-system-modules
;; 				       (guix build cmake-build-system))
;; 		   #:phases
;; 		   (modify-phases %standard-phases
;; 		     (add-after 'unpack 'substitute-vterm-module-path
;; 		       (lambda* (#:key outputs #:allow-other-keys)
;; 			 (chmod "vterm.el" #o644)
;; 			 (emacs-substitute-sexps "vterm.el"
;; 			   ("(require 'vterm-module nil t)"
;; 			    `(module-load
;; 			      ,(string-append (assoc-ref outputs "out")
;; 					      "/lib/vterm-module.so"))))
;; 			 #t))
;; 		     (add-after 'build 'configure
;; 		       ;; Run cmake.
;; 		       (lambda* (#:key outputs #:allow-other-keys)
;; 			 ((assoc-ref cmake:%standard-phases 'configure)
;; 			  #:outputs outputs
;; 			  #:out-of-source? #f
;; 			  #:configure-flags '("-DUSE_SYSTEM_LIBVTERM=ON"))
;; 			 #t))
;; 		     (add-after 'configure 'make
;; 		       ;; Run make.
;; 		       (lambda* (#:key (make-flags '()) outputs #:allow-other-keys)
;; 			 ;; Compile the shared object file.
;; 			 (apply invoke "make" "all" make-flags)
;; 			 ;; Move the file into /lib.
;; 			 (install-file
;; 			  "vterm-module.so"
;; 			  (string-append (assoc-ref outputs "out") "/lib"))
;; 			 #t)))
;; 		   #:tests? #f))
;;       (native-inputs
;;        `(("cmake" ,cmake-minimal)
;;          ("libtool" ,libtool)
;;          ("libvterm" ,libvterm)))
;;       (home-page "https://github.com/akermu/emacs-libvterm")
;;       (synopsis "Emacs libvterm integration")
;;       (description "This package implements a bridge to @code{libvterm} to
;; display a terminal in an Emacs buffer.")
;;       (license license:gpl3+))))

(define-public emacs-tsc
  (package
    (name "emacs-tsc")
    (version "20210912.1211")
    (source
     (origin
       (method url-fetch)
       (uri
	"file:///home/tassos/software/emacs-tsc")
       (sha256
	(base32
	 "08lmfr7n2yvfmwrr7ifp6pp9c9vd16zkf1wvyl3f13dj849j8qzm"))))
    (build-system emacs-build-system)
    (home-page
     "https://github.com/emacs-tree-sitter/elisp-tree-sitter")
    (synopsis "Core Tree-sitter APIs")
    (description
     "This is the core APIs of the Emacs binding for Tree-sitter, an incremental
parsing system.")
    (license #f)))

(define-public emacs-tree-sitter
  (package
    (name "emacs-tree-sitter")
    (version "20210912.1211")
    (source
     (origin
       (method git-fetch)
       (uri
	(git-reference
	 (url "file:///home/tassos/software/elisp-tree-sitter")
	 (commit "d694fbeaa5a0dcc9be8fc61603a4ddae78dec65d")))
       (sha256
	(base32
	 "082797y5h0n4kdyxy32gxwmc7s5s2cqrrlsp1q03hqrgvvm3xasz"))))
    (build-system emacs-build-system)
    (propagated-inputs `(("emacs-tsc" ,emacs-tsc)))
    (home-page
     "https://github.com/emacs-tree-sitter/elisp-tree-sitter")
    (synopsis "Incremental parsing system")
    (description
     "This is the base framework of the Emacs binding for Tree-sitter, an
incremental parsing system. It includes a minor mode that provides a
buffer-local syntax tree that is updated on every text change. This minor
mode is the base for other libraries to build on. An example is the included
code-highlighting minor mode.")
    (license #f)))

emacs-tsc-dyn

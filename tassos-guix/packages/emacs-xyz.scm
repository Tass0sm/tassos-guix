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

;; (define-public emacs-tsc-dyn
;;   (package
;;     (name "emacs-tsc-dyn")
;;     (version "0.15.2")
;;     (source
;;      (origin
;;        (method url-fetch)
;;        (uri
;; 	"file:///home/tassos/software/emacs-tsc-dyn")
;;        (sha256
;; 	(base32
;; 	 "08lmfr7n2yvfmwrr7ifp6pp9c9vd16zkf1wvyl3f13dj849j8qzm"))))
;;     (build-system cargo-build-system)
;;     (native-inputs
;;      `(("clang" ,clang)))
;;     (arguments
;;      `(#:cargo-inputs
;;        (("rust-emacs" ,rust-emacs-0.17)
;; 	("rust-libloading" ,rust-libloading-0.7)
;; 	("rust-tree-sitter" ,rust-tree-sitter-0.19)
;; 	("rust-once-cell" ,rust-once-cell-1))))
;;     (home-page
;;      "https://github.com/emacs-tree-sitter/elisp-tree-sitter/tree/master/core")
;;     (synopsis "Emacs Tree-Sitter Dynamic Module")
;;     (description
;;      "This is the core APIs of the Emacs binding for Tree-sitter, an incremental
;; parsing system.")
;;     (license #f)))

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

;; (define-public emacs-tsc
;;   (package
;;    (name "emacs-tsc")
;;    (version "20210912.1211")
;;    (source
;;     (origin
;;      (method url-fetch)
;;      (uri
;;       "file:///home/tassos/software/emacs-tsc")
;;      (sha256
;;       (base32
;;        "08lmfr7n2yvfmwrr7ifp6pp9c9vd16zkf1wvyl3f13dj849j8qzm"))))
;;    (build-system emacs-build-system)
;;    (home-page
;;     "https://github.com/emacs-tree-sitter/elisp-tree-sitter")
;;    (synopsis "Core Tree-sitter APIs")
;;    (description
;;     "This is the core APIs of the Emacs binding for Tree-sitter, an incremental
;; parsing system.")
;;    (license #f)))

;; (define-public emacs-tree-sitter
;;   (package
;;    (name "emacs-tree-sitter")
;;    (version "20210912.1211")
;;    (source
;;     (origin
;;      (method git-fetch)
;;      (uri
;;       (git-reference
;;        (url "file:///home/tassos/software/elisp-tree-sitter")
;;        (commit "d694fbeaa5a0dcc9be8fc61603a4ddae78dec65d")))
;;      (sha256
;;       (base32
;;        "082797y5h0n4kdyxy32gxwmc7s5s2cqrrlsp1q03hqrgvvm3xasz"))))
;;    (build-system emacs-build-system)
;;    (propagated-inputs `(("emacs-tsc" ,emacs-tsc)))
;;    (home-page
;;     "https://github.com/emacs-tree-sitter/elisp-tree-sitter")
;;    (synopsis "Incremental parsing system")
;;    (description
;;     "This is the base framework of the Emacs binding for Tree-sitter, an
;; incremental parsing system. It includes a minor mode that provides a
;; buffer-local syntax tree that is updated on every text change. This minor
;; mode is the base for other libraries to build on. An example is the included
;; code-highlighting minor mode.")
;;    (license #f)))

(define-public emacs-popper
  (package
   (name "emacs-popper")
   (version "20211011.113")
   (source
    (origin
     (method url-fetch)
     (uri (string-append "https://melpa.org/packages/popper-" version ".tar"))
     (sha256
      (base32 "05i3fqdacdg41h0h3j7lvndljjiya2r8g1dkcxs00fq5xy5rcklq"))))
   (build-system emacs-build-system)
   (home-page "https://github.com/karthink/popper")
   (synopsis "Summon and dismiss buffers as popups")
   (description
    "Popper is a minor-mode to tame the flood of ephemeral windows Emacs
produces, while still keeping them within arm's reach. Designate any
buffer to \"popup\" status, and it will stay out of your way. Disimss
or summon it easily with one key. Cycle through all your \"popups\" or
just the ones relevant to your current buffer. Useful for many
things, including toggling display of REPLs, documentation,
compilation or shell output, etc.

For a demo describing usage and customization see
https://www.youtube.com/watch?v=E-xUNlZi3rI

COMMANDS:

popper-mode          : Turn on popup management
popper-toggle-latest : Toggle latest popup
popper-cycle         : Cycle through all popups, or close all open popups
popper-toggle-type   : Turn a regular window into a popup or vice-versa
popper-kill-latest-popup : Kill latest open popup

CUSTOMIZATION:

`popper-reference-buffers': A list of major modes or regexps whose
corresponding buffer major-modes or regexps (respectively) should be
treated as popups.

`popper-mode-line': String or sexp to show in the mode-line of
popper. Setting this to nil removes the mode-line entirely from
popper.

`popper-group-function': Function that returns the context a popup
should be shown in. The context is a string or symbol used to group
together a set of buffers and their associated popups, such as the
project root. Customize for available options.

`popper-display-control': This package summons windows defined by the
user as popups by simply calling `display-buffer'. By default,
it will display your popups in a non-obtrusive way. If you want
Popper to display popups according to window rules you specify in
`display-buffer-alist' (or through a package like Shackle), set this
variable to nil.

There are other customization options, such as the ability to suppress
certain popups and keep them from showing. Please customize the popper group
for details.
")
   (license #f)))

(define-public emacs-consult-dir
  (package
   (name "emacs-consult-dir")
   (version "20211007.2352")
   (source
    (origin
     (method url-fetch)
     (uri (string-append
           "https://melpa.org/packages/consult-dir-"
           version
           ".el"))
     (sha256
      (base32 "1gszscjk4gp7qadqyz8vi584h9kz59rk69lhi0zrnvszs8znzgpa"))))
   (build-system emacs-build-system)
   (propagated-inputs
    `(("emacs-consult" ,emacs-consult)
      ("emacs-project" ,emacs-project)))
   (home-page "https://github.com/karthink/consult-dir")
   (synopsis "Insert paths into the minibuffer prompt")
   (description
    "Consult-dir implements commands to easily switch between \"active\"
directories. The directory candidates are collected from user bookmarks,
projectile project roots (if available), project.el project roots and recentf
file locations. The `default-directory' variable not changed in the process.

Call `consult-dir' from the minibuffer to choose a directory with completion
and insert it into the minibuffer prompt, shadowing or deleting any existing
directory. The file name input is retained. This lets the user switch to
distant directories very quickly when finding files, for instance.

Call `consult-dir' from a regular buffer to choose a directory with
completion and then interactively find a file in that directory. The command
run with this directory is configurable via `consult-dir-default-command' and
defaults to `find-file'.

Call `consult-dir-jump-file' from the minibuffer to asynchronously find a
file anywhere under the directory that is currently in the prompt. This can
be used with `consult-dir' to quickly switch directories and find files at an
arbitrary depth under them. `consult-dir-jump-file' uses `consult-find' under
the hood.

To use this package, bind `consult-dir' and `consult-dir-jump-file' under the\n`minibuffer-local-completion-map' or equivalent, and `consult-dir' to the global map.

(define-key minibuffer-local-completion-map (kbd \"C-x C-d\") #'consult-dir)
(define-key minibuffer-local-completion-map (kbd \"C-x C-j\") #'consult-dir-jump-file)
(define-key global-map (kbd \"C-x C-d\") #'consult-dir)

Directory sources configuration:
- To make recent directories available, turn on `recentf-mode'.

- To make projectile projects available, turn on projectile-mode and
configure `consult-dir-project-list-function'. Note that Projectile is NOT
required to install this package.

- To make project.el projects available, configure
`consult-dir-project-list-function'.

To change directory sources or their ordering, customize
`consult-dir-sources'.
")
   (license #f)))

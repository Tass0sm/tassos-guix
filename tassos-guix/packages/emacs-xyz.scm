(define-module (tassos-guix packages emacs-xyz)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages rust)
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

(define-public emacs-tsc-module
  (package
    (name "emacs-tsc-module")
    (version "20220212.1632")
    (source
     (origin
      (method url-fetch)
      (uri (string-append "https://melpa.org/packages/tsc-" version ".tar"))
      (sha256
       (base32 "0x44ar4dkp0f2bkd5ha232gplj8wbmaf788myfk8471vn9xcmvb4"))))
    (build-system cargo-build-system)
    (arguments
     `(#:phases (modify-phases %standard-phases
                  (add-after 'unpack-rust-crates 'remove-patch-section
                    (lambda _
                      ;; Remove the patch section from Cargo.toml
                      (substitute* "Cargo.toml"
                        (("\\[patch.crates-io.tree-sitter]") "")
                        (("git = \"https://github.com/tree-sitter/tree-sitter\"")
                         "")) #t))
                  (replace 'install
                    (lambda* (#:key outputs #:allow-other-keys)
                      ;; Copy the dynamic module result to the output.
                      (install-file "target/release/libtsc_dyn.so"
                                    (assoc-ref outputs "out")) #t)))
       #:cargo-development-inputs
       (("rust-emacs" ,rust-emacs-0.18)
        ("rust-libloading" ,rust-libloading-0.7)
        ("rust-tree-sitter" ,rust-tree-sitter-0.20)
        ;; ("rust-once-cell" ,rust-once-cell-1.7)
        )))
    (home-page "https://github.com/emacs-tree-sitter/elisp-tree-sitter")
    (synopsis "Core Tree-sitter APIs")
    (description
     "This is the core APIs of the Emacs binding for Tree-sitter, an incremental
parsing system.
")
    (license #f)))

(define-public emacs-tsc
  (package
   (name "emacs-tsc")
   (version "20220212.1632")
   (source
     (origin
       (method url-fetch)
       (uri (string-append "https://melpa.org/packages/tsc-" version ".tar"))
       (sha256
        (base32 "1aa24krayk7f6rzhi1vgs8vixa7i5q9j9xlbv7sma854w9ssswnc"))))
   (build-system emacs-build-system)
   (arguments
    `(#:include
      '("^[^/]*\\.el$" "^tsc-dyn.so$" "^DYN-VERSION$" "^[^/]*\\.info$" "^doc/.*\\.info$")
      #:phases
      (modify-phases %standard-phases
                     (add-after 'unpack 'add-local-dynamic-module
                                (lambda* (#:key inputs #:allow-other-keys)
                                  (copy-recursively
                                   (assoc-ref inputs "emacs-tsc-module") ".")
                                  (rename-file "./libtsc_dyn.so" "./tsc-dyn.so")
                                  (let ((port (open-output-file "DYN-VERSION")))
                                    (display "LOCAL" port)
                                    (close-port port))
                                  #t)))))
   (native-inputs
    (list emacs-tsc-module))
   (home-page "https://github.com/emacs-tree-sitter/elisp-tree-sitter")
   (synopsis "Core Tree-sitter APIs")
   (description
    "This is the core APIs of the Emacs binding for Tree-sitter, an incremental
parsing system.")
   (license #f)))

(define-public emacs-tree-sitter
  (package
   (name "emacs-tree-sitter")
   (version "20220212.1632")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/emacs-tree-sitter/elisp-tree-sitter.git")
           (commit "3cfab8a0e945db9b3df84437f27945746a43cc71")))
     (sha256
      (base32 "0flqsf3nly7s261vss56havss13psgbw98612yj2xkfk9sydia28"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-tsc))
   (arguments
    '(#:include
      '("^lisp/[^/]+.el$")
      #:exclude
      '("^lisp/tree-sitter-tests.el$")))
   (home-page "https://github.com/emacs-tree-sitter/elisp-tree-sitter")
   (synopsis "Incremental parsing system")
   (description
    "This is the base framework of the Emacs binding for Tree-sitter, an incremental
parsing system.  It includes a minor mode that provides a buffer-local syntax
tree that is updated on every text change.  This minor mode is the base for
other libraries to build on.  An example is the included code-highlighting minor
mode.")
   (license #f)))

(define-public emacs-reazon
  (package
   (name "emacs-reazon")
   (version "20210831.1208")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/nickdrozd/reazon.git")
           (commit "d697c0dfe38ac7483e453e8ce8056acf95c89ba2")))
     (sha256
      (base32 "12s2h4wd7cz9x078698wwjjpy874rk8cm2d17p6ksb10y3cmrqsn"))))
   (build-system emacs-build-system)
   (home-page "https://github.com/nickdrozd/reazon")
   (synopsis "miniKanren for Emacs")
   (description
    "Reazon is an implmentation of the miniKanren language for Emacs. It
provides an interface for writing and running relational programs.
That interface consists of the following macros:

* reazon-defrel
* reazon-run*
* reazon-run
* reazon-fresh
* reazon-conde
* reazon-conj
* reazon-disj
* reazon-project

Besides these, there is a single primitive goal, reazon-==.
")
   (license #f)))

(define-public emacs-tree-edit
  (package
   (name "emacs-tree-edit")
   (version "20211209.2258")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/ethan-leba/tree-edit.git")
           (commit "6f544be43e24a3b2f9aca7cba1bd960bb824605d")))
     (sha256
      (base32 "14k39ngsxv35k4lvl2qgxrr6pjinz3r618f9b4lrw07rr46p0637"))))
   (build-system emacs-build-system)
   (propagated-inputs
    `(("emacs-tree-sitter" ,emacs-tree-sitter)
      ("emacs-tsc" ,emacs-tsc)
      ;; ("emacs-tree-sitter-langs" ,emacs-tree-sitter-langs)
      ("emacs-dash" ,emacs-dash)
      ("emacs-reazon" ,emacs-reazon)
      ("emacs-s" ,emacs-s)))
   (arguments
    '(#:include
      '("^[^/]+.el$"
        "^[^/]+.el.in$"
        "^dir$"
        "^[^/]+.info$"
        "^[^/]+.texi$"
        "^[^/]+.texinfo$"
        "^doc/dir$"
        "^doc/[^/]+.info$"
        "^doc/[^/]+.texi$"
        "^doc/[^/]+.texinfo$")
      #:exclude
      '("^.dir-locals.el$"
        "^test.el$"
        "^tests.el$"
        "^[^/]+-test.el$"
        "^[^/]+-tests.el$"
        "^evil-tree-edit.el$")))
   (home-page "https://github.com/ethan-leba/tree-edit")
   (synopsis "A library for structural refactoring and editing")
   (description
    "
Provides a set of functions for structural editing or refactoring in any
language supported by tree-sitter.

The interface for this package is currently unstable, developing against it is
unadvised!

See `evil-tree-edit' if you're looking for a complete editing package.
")
   (license #f)))

(define-public emacs-beacon
  (package
   (name "emacs-beacon")
   (version "20190104.1931")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/Malabarba/beacon.git")
           (commit "bde78180c678b233c94321394f46a81dc6dce1da")))
     (sha256
      (base32 "19m90jjbsjzhzf7phlg79l8d2kxgrqnrrg1ipa3sf7vzxxkmsdld"))))
   (build-system emacs-build-system)
   (home-page "https://github.com/Malabarba/beacon")
   (synopsis "Highlight the cursor whenever the window scrolls")
   (description
    "This is a global minor-mode. Turn it on everywhere with:
┌────
│ (beacon-mode 1)
└────

Whenever the window scrolls a light will shine on top of your cursor so
you know where it is.

That’s it.

See the accompanying Readme.org for configuration details.
")
   (license #f)))

(define-public emacs-ox-haunt
  (package
    (name "emacs-ox-haunt")
    (version "0.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://git.sr.ht/~jakob/ox-haunt")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1rs1n228c2fmpvirc57bqgf2616ijpphkgf4w9ln5j46snmkam25"))))
    (build-system emacs-build-system)
    (home-page "https://git.sr.ht/~jakob/ox-haunt")
    (synopsis "Export Org files to HTML appropriate for Haunt")
    (description
     "This library implements an HTML back-end for the Org generic exporter,
producing output appropriate for Haunt's @code{html-reader}.")
    (license license:gpl3+)))

(define-public emacs-magit-section
  (package
    (name "emacs-magit-section")
    (version "20220326.1956")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/magit/magit.git")
             (commit "29f5be3576ce031f90eb9637dd3bd8ec627d53f4")))
       (sha256
        (base32 "00260hm786j4xwqaqjclys287523ypzfj7vvd53pi5mlg0jgkiyp"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-dash))
    (arguments
     '(#:include
       '("^lisp/magit-section.el$"
         "^lisp/magit-section-pkg.el$"
         "^docs/magit-section.texi$"
         "^Documentation/magit-section.texi$")
       #:exclude
       '()))
    (home-page "https://github.com/magit/magit")
    (synopsis "Sections for read-only buffers")
    (description
     "This package implements the main user interface of Magit — the collapsible
sections that make up its buffers.  This package used to be distributed as part
of Magit but now it can also be used by other packages that have nothing to do
with Magit or Git.")
    (license #f)))

(define-public emacs-bufler
  (package
   (name "emacs-bufler")
   (version "20210907.1145")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/alphapapa/bufler.el.git")
           (commit "a68e0eb2719c67ab8a3ad56c4036364061d06004")))
     (sha256
      (base32 "155g4p2yw88cpc8ydfzybc4r6ab2qwcmzdwkrrhnra4psimahjq6"))))
   (build-system emacs-build-system)
   (propagated-inputs
    (list emacs-dash emacs-f emacs-pretty-hydra emacs-magit-section emacs-map))
   (arguments
    '(#:include
      '("^[^/]+.el$"
        "^[^/]+.el.in$"
        "^dir$"
        "^[^/]+.info$"
        "^[^/]+.texi$"
        "^[^/]+.texinfo$"
        "^doc/dir$"
        "^doc/[^/]+.info$"
        "^doc/[^/]+.texi$"
        "^doc/[^/]+.texinfo$")
      #:exclude
      '("^.dir-locals.el$"
        "^test.el$"
        "^tests.el$"
        "^[^/]+-test.el$"
        "^[^/]+-tests.el$"
        "^helm-bufler.el$")
      ;; #:phases
      ;; (modify-phases %standard-phases
      ;;   ;; Compilation doesn't work.
      ;;   (delete 'build))
      ))
   (home-page "https://github.com/alphapapa/bufler.el")
   (synopsis "Group buffers into workspaces with programmable rules")
   (description
    "Bufler is like a butler for your buffers, presenting them to you in an organized
way based on your instructions.  The instructions are written as grouping rules
in a simple language, allowing you to customize the way buffers are grouped.
The default rules are designed to be generally useful, so you don't have to
write your own.

It also provides a workspace mode which allows frames to focus on buffers in
certain groups.  Since the groups are created automatically, the workspaces are
created dynamically, rather than requiring you to put buffers in workspaces
manually.")
   (license #f)))

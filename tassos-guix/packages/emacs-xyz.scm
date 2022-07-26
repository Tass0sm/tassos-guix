(define-module (tassos-guix packages emacs-xyz)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages rust)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages crates-graphics)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (tassos-guix packages crates-io)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system emacs)
  #:use-module (guix build-system cargo)
  #:use-module ((guix licenses) #:prefix license:))

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
    (version "20220726.1658")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/alphapapa/bufler.el.git")
                    (commit "5e8f02c3a454d6d43c18851023d6ac6ae470c31f")))
              (sha256
               (base32
                "1m7x5zksjfyh254mvsl9va5jqr76niyf54djjiacnrlpqnn3bf2s"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-dash emacs-f emacs-pretty-hydra
                             emacs-magit emacs-map))
    (arguments
     '(#:include '("^[^/]+.el$" "^[^/]+.el.in$"
                   "^dir$"
                   "^[^/]+.info$"
                   "^[^/]+.texi$"
                   "^[^/]+.texinfo$"
                   "^doc/dir$"
                   "^doc/[^/]+.info$"
                   "^doc/[^/]+.texi$"
                   "^doc/[^/]+.texinfo$")
       #:exclude '("^.dir-locals.el$" "^test.el$" "^tests.el$" "^[^/]+-test.el$"
                   "^[^/]+-tests.el$" "^helm-bufler.el$")))
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

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

(define-public emacs-ox-haunt-latest
  (package
    (inherit emacs-ox-haunt)
    (name "emacs-ox-haunt-latest")
    (version "4d585c5")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://git.sr.ht/~jakob/ox-haunt")
             (commit "d32c4b1ab258dc34ca7e713152a274eab35d2608")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1h5g32kw3dgdp3vdzx34n8pcmg3ssn2bzmx5an7yksymibmayfjs"))))))

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
    (version "0.3-pre")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/alphapapa/bufler.el.git")
                    (commit "bf5fdccbae6bb6dc51e31dc282805e32bb41e412")))
              (sha256
               (base32
                "142ql507mb7w6l3mr1y4914znnikab5vh8sm2q35pfvka383k1r7"))))
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

(define-public emacs-haskell-mode-latest
  (package
    (name "emacs-haskell-mode-latest")
    (version "17.2")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/haskell/haskell-mode")
             (commit "5a9f8072c7b9168f0a8409adf9d62a3e4ad4ea3d")))
       (sha256
        (base32 "0np1wrwdq7b9hpqpl9liampacnkx6diphyk8h2sbz2mfn9qr7pxs"))))
    (propagated-inputs
     (list emacs-dash))
    (native-inputs
     (list emacs-minimal emacs-el-search emacs-stream texinfo))
    (build-system gnu-build-system)
    (arguments
     (list
      #:make-flags #~(list
                      (string-append "EMACS=" #$emacs-minimal "/bin/emacs"))
      #:modules `((ice-9 match)
                  (srfi srfi-26)
                  ((guix build emacs-build-system) #:prefix emacs:)
                  ,@%gnu-build-system-modules)
      #:imported-modules `(,@%gnu-build-system-modules
                           (guix build emacs-build-system)
                           (guix build emacs-utils))
      #:tests? #f
      #:phases
      #~(modify-phases %standard-phases
          (delete 'configure)
          (add-before 'build 'pre-build
            (lambda* (#:key inputs #:allow-other-keys)
              (define (el-dir store-dir)
                (match (find-files store-dir "\\.el$")
                  ((f1 f2 ...) (dirname f1))
                  (_ "")))

              (let ((sh (search-input-file inputs "/bin/sh")))
                (define emacs-prefix? (cut string-prefix? "emacs-" <>))

                (setenv "SHELL" "sh")
                (setenv "EMACSLOADPATH"
                        (string-concatenate
                         (map (match-lambda
                                (((? emacs-prefix? name) . dir)
                                 (string-append (el-dir dir) ":"))
                                (_ ""))
                              inputs)))
                (substitute* (find-files "." "\\.el") (("/bin/sh") sh)))))
          (add-before 'check 'delete-failing-tests
            ;; XXX: these tests require GHC executable, which would be a big
            ;; native input.
            (lambda _
              (with-directory-excursion "tests"
                ;; File `haskell-indent-tests.el' fails with
                ;; `haskell-indent-put-region-in-literate-2'
                ;; on Emacs 27.1+
                ;; XXX: https://github.com/haskell/haskell-mode/issues/1714
                (for-each delete-file
                          '("haskell-indent-tests.el"
                            "haskell-customize-tests.el"
                            "inferior-haskell-tests.el")))))
          (replace 'install
            (lambda* (#:key outputs #:allow-other-keys)
              (let* ((out (assoc-ref outputs "out"))
                     (el-dir (emacs:elpa-directory out))
                     (doc (string-append
                           out "/share/doc/haskell-mode-" #$version))
                     (info (string-append out "/share/info")))
                (define (copy-to-dir dir files)
                  (for-each (lambda (f)
                              (install-file f dir))
                            files))

                (with-directory-excursion "doc"
                  (invoke "makeinfo" "haskell-mode.texi")
                  (install-file "haskell-mode.info" info))
                (copy-to-dir doc '("CONTRIBUTING.md" "NEWS" "README.md"))
                (copy-to-dir el-dir (find-files "." "\\.elc?"))))))))
    (home-page "https://github.com/haskell/haskell-mode")
    (synopsis "Haskell mode for Emacs")
    (description
     "This is an Emacs mode for editing, debugging and developing Haskell
programs.")
    (license license:gpl3+)))

(define-public emacs-org-analyzer
  (package
    (name "emacs-org-analyzer")
    (version "20191001.1717")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/rksm/clj-org-analyzer.git")
                    (commit "19da62aa4dcf1090be8f574f6f2d4c7e116163a8")))
              (sha256
               (base32
                "1zfc93z6w5zvbqiypqvbnyv8ims1wgpcp61z1s152d0nq2y4pf50"))))
    (build-system emacs-build-system)
    (arguments
     '(#:include '("^[^/]+.jar$" "^[^/]+.el$")
       #:exclude '()
       #:phases
       (modify-phases %standard-phases
         (add-before 'install 'enter-lisp-directory
           (lambda _
             (chdir "org-analyzer-el"))))))
    (home-page "https://github.com/rksm/clj-org-analyzer")
    (synopsis
     "org-analyzer is a tool that extracts time tracking data from org files.")
    (description
     "org-analyzer is a tool that extracts time tracking data from org files (time
data recording with `org-clock-in', those lines that start with \"CLOCK:\").  It
then creates an interactive visualization of that data — outside of Emacs(!).

In order to run the visualizer / parser you need to have java installed.

This Emacs package provides a simple way to start the visualizer via
`org-analyzer-start' and feed it the default org files.

See https://github.com/rksm/clj-org-analyzer for more information.")
    (license #f)))

(define-public emacs-jupyter-next
  (package
    (inherit emacs-jupyter)
    (name "emacs-jupyter-next")
    (version "20220419.1852")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nnicandro/emacs-jupyter")
             (commit "2c8a0d060567956065670e1dc32794875154f2e8")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0l0kx27cqmxkjqyv2c6010ci5mml2lmp4xzi5dg0l8rc217hmz1g"))))))

(define-public emacs-ligature
  (package
    (name "emacs-ligature")
    (version "20220808.1225")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/mickeynp/ligature.el.git")
                    (commit "3d1460470736777fd8329e4bb4ac359bf4f1460a")))
              (sha256
               (base32
                "1rnx2mp8y1phnvfirmf4a6lza38dg2554r9igyijl9rgqpjax94d"))))
    (build-system emacs-build-system)
    (home-page "https://www.github.com/mickeynp/ligature.el")
    (synopsis "Display typographical ligatures in major modes")
    (description
     "This package converts graphemes (characters) present in major modes of your
choice to the stylistic ligatures present in your frame's font.")
    (license license:gpl3+)))

(define-public emacs-commenter
  (package
    (name "emacs-commenter")
    (version "20160219.1627")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/yuutayamada/commenter.git")
                    (commit "6d1885419434ba779270c6fda0e30d390bb074bd")))
              (sha256
               (base32
                "1jwd3whag39qhzhbsfivzdlcr6vj37dv5ychkhmilw8v6dfdnpdb"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-let-alist))
    (home-page "https://github.com/yuutayamada/commenter")
    (synopsis "multiline-comment support package")
    (description
     "This package allows you to set both single and multi line comment variables like
‘comment-start’ or ‘comment-end’ etc.")
    (license license:gpl3+)))

(define-public emacs-flycheck-nimsuggest
  (package
    (name "emacs-flycheck-nimsuggest")
    (version "20171027.2208")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url
                     "https://github.com/yuutayamada/flycheck-nimsuggest.git")
                    (commit "dc9a5de1cb3ee05db5794d824610959a1f603bc9")))
              (sha256
               (base32
                "1bf65hrz0s6f180kn2ir8l5qn7in789w8pyy96b9gqn21z50vb9d"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-flycheck))
    (home-page "https://github.com/yuutayamada/flycheck-nimsuggest")
    (synopsis "flycheck backend for Nim using nimsuggest")
    (description
     "This package provides on-the-fly syntax check support using Nimsuggest and
flycheck.el.")
    (license license:gpl3+)))

(define-public emacs-nim-mode
  (package
    (name "emacs-nim-mode")
    (version "20211102.917")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/nim-lang/nim-mode.git")
                    (commit "744e076f0bea1c5ddc49f92397d9aa98ffa7eff8")))
              (sha256
               (base32
                "0jjrjsks3q8qpipxcqdkm8pi3pjnkcxcydspbf0rkvy3x6i5mwkv"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-epc emacs-let-alist emacs-commenter
                             emacs-flycheck-nimsuggest))
    (home-page "https://github.com/nim-lang/nim-mode")
    (synopsis "A major mode for the Nim programming language")
    (description
     "This package provides (and requires Emacs 24.4 or higher version):

@itemize
@item Syntax highlighting for *.nim, *.nims, *.nimble and nim.cfg files
@item nim-compile command (C-c C-c), with error matcher for the compile buffer
@item Nimsuggest
@item Automatic indentation and line breaking (alpha)
@item Outline by procedures (hs-hide-all, hs-show-all etc.)
@end itemize")
    (license license:gpl2+)))

(define-public emacs-topsy
  (package
    (name "emacs-topsy")
    (version "20230414.1738")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/alphapapa/topsy.el.git")
                    (commit "86d4234e4a0e9d2f5bf0f1114ea9893da48e77d1")))
              (sha256 (base32
                       "0lxca6jxkkpkj063mf0m7ack7aaiazv4zz2xkwc2vv0hbrf9nzdx"))))
    (build-system emacs-build-system)
    (home-page "https://github.com/alphapapa/topsy.el")
    (synopsis "Simple sticky header")
    (description
     "This library shows a sticky header at the top of the window.  The header shows
which definition the top line of the window is within.  Intended as a simple
alternative to `semantic-stickyfunc-mode`.  Mode-specific functions may be added
to `topsy-mode-functions'.  NOTE: For Org mode buffers, please use
org-sticky-header: <https://github.com/alphapapa/org-sticky-header>.")
    (license #f)))

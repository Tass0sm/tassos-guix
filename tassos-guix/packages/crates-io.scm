(define-module (tassos-guix packages crates-io)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages crates-graphics)

  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system cargo)
  #:use-module ((guix licenses) #:prefix license:))

(define-public rust-emacs-macros-0.17
  (package
    (name "rust-emacs-macros")
    (version "0.17.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "emacs-macros" version))
       (file-name
	(string-append name "-" version ".tar.gz"))
       (sha256
	(base32
	 "0qg1dcn5acbirq617qq2fgg9adswif2dnr292s3qnq62wzgnyrb9"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs
       (("rust-darling" ,rust-darling-0.10)
	("rust-proc-macro2" ,rust-proc-macro2-1)
	("rust-quote" ,rust-quote-1)
	("rust-syn" ,rust-syn-1))))
    (home-page "https://github.com/ubolonton/emacs-module-rs")
    (synopsis "Proc macros for Emacs modules")
    (description "This package provides proc macros for Emacs modules.")
    (license license:bsd-3)))

(define-public rust-bindgen-0.56
  (package
    (inherit rust-bindgen-0.57)
    (name "rust-bindgen")
    (version "0.56.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "bindgen" version))
       (file-name (string-append name "-" version ".tar.gz"))
       (sha256
	(base32 "0fajmgk2064ca1z9iq1jjkji63qwwz38z3d67kv6xdy0xgdpk8rd"))))
    (arguments
     `(#:cargo-inputs
       (("rust-bitflags" ,rust-bitflags-1)
	("rust-cexpr" ,rust-cexpr-0.4)
	("rust-clang-sys" ,rust-clang-sys-1)
	("rust-clap" ,rust-clap-2)
	("rust-env-logger" ,rust-env-logger-0.8)
	("rust-lazy-static" ,rust-lazy-static-1)
	("rust-lazycell" ,rust-lazycell-1)
	("rust-log" ,rust-log-0.4)
	("rust-peeking-take-while" ,rust-peeking-take-while-0.1)
	("rust-proc-macro2" ,rust-proc-macro2-1)
	("rust-quote" ,rust-quote-1)
	("rust-regex" ,rust-regex-1)
	("rust-rustc-hash" ,rust-rustc-hash-1)
	("rust-shlex" ,rust-shlex-0.1)
	("rust-which" ,rust-which-3))
       #:cargo-development-inputs
       (("rust-clap" ,rust-clap-2)
	("rust-diff" ,rust-diff-0.1)
	("rust-shlex" ,rust-shlex-0.1))
       #:skip-build? #t))))

(define-public rust-emacs-module-0.18
  (package
    (name "rust-emacs-module")
    (version "0.18.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "emacs_module" version))
       (file-name
	(string-append name "-" version ".tar.gz"))
       (sha256
	(base32
	 "1ypjyyv2ca3vza4sia91ckxamgfk63yd8frkvg3d4ph4fk4pn1mk"))))
    (build-system cargo-build-system)
    (inputs
     `(("clang" ,clang)))
    (arguments
     `(#:cargo-inputs
       (("rust-bindgen" ,rust-bindgen-0.56))))
    (home-page "https://github.com/ubolonton/emacs-module-rs")
    (synopsis "Raw FFI for emacs-module")
    (description "This module provides a high-level binding to emacs-module:
Emacs' support for dynamic modules.")
    (license license:bsd-3)))

(define-public rust-emacs-0.18
  (package
    (name "rust-emacs")
    (version "0.18.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "emacs" version))
       (file-name
	(string-append name "-" version ".tar.gz"))
       (sha256
	(base32
	 "0r860i73b2680i2fhdl2l1wwvvmf2zksncpckgkksdcx310ak5v7"))))
    (build-system cargo-build-system)
    (inputs
     `(("clang" ,clang)))
    (arguments
     `(#:cargo-inputs
       (("rust-anyhow" ,rust-anyhow-1)
	("rust-ctor" ,rust-ctor-0.1)
	("rust-emacs-macros" ,rust-emacs-macros-0.17)
	("rust-emacs-module" ,rust-emacs-module-0.18)
	("rust-failure" ,rust-failure-0.1)
	("rust-failure-derive" ,rust-failure-derive-0.1)
	("rust-lazy-static" ,rust-lazy-static-1)
	("rust-thiserror" ,rust-thiserror-1))))
    (home-page "https://github.com/ubolonton/emacs-module-rs")
    (synopsis "Library for creating Emacs's dynamic modules")
    (description
     "This crate provides a high level binding to emacs-module:
Emacs' support for dynamic modules.")
    (license license:bsd-3)))

(define-public rust-spin-0.7
(package
(name "rust-spin")
(version "0.7.1")
(source
(origin
  (method url-fetch)
  (uri (crate-uri "spin" version))
  (file-name
   (string-append name "-" version ".tar.gz"))
  (sha256
   (base32
    "0qjips9f6fsvkyd7wj3a4gzaqknn2q4kkb19957pl86im56pna0k"))))
(build-system cargo-build-system)
(arguments
`(#:cargo-inputs
  (("rust-lock-api" ,rust-lock-api-0.4))))
(home-page
"https://github.com/mvdnes/spin-rs.git")
(synopsis
"Spin-based synchronization primitives")
(description
"Spin-based synchronization primitives")
(license license:expat)))

(define-public rust-html-escape-0.2
  (package
    (name "rust-html-escape")
    (version "0.2.6")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "html_escape" version))
       (file-name
	(string-append name "-" version ".tar.gz"))
       (sha256
	(base32
	 "13lqmbp8bkhnnkfkjabaaks7slasfg9jx4msjm1lgds1x4690j6k"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs
       (("rust-utf8-width" ,rust-utf8-width-0.1))
       #:cargo-development-inputs
       (("rust-bencher" ,rust-bencher-0.1))))
    (home-page "https://magiclen.org/html-escape")
    (synopsis
     "This library is for encoding/escaping special characters in HTML and decoding/unescaping HTML entities as well.")
    (description
     "This library is for encoding/escaping special characters in HTML and decoding/unescaping HTML entities as well.")
    (license license:expat)))

(define-public rust-smallbitvec-2
  (package
    (name "rust-smallbitvec")
    (version "2.5.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "smallbitvec" version))
       (file-name
	(string-append name "-" version ".tar.gz"))
       (sha256
	(base32
	 "1yh9l8xmjm6zlyb4jmyp6qcsfh7rz5v5dm4qjvr9dn4hzfplwykr"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-development-inputs
       (("rust-bit-vec" ,rust-bit-vec-0.4)
	("rust-rand" ,rust-rand-0.4))))
    (home-page
     "https://github.com/servo/smallbitvec")
    (synopsis
     "A bit vector optimized for size and inline storage")
    (description
     "This package provides a bit vector optimized for size and inline storage")
    (license (list license:expat license:asl2.0))))

(define-public rust-chunked-transfer-1
  (package
    (name "rust-chunked-transfer")
    (version "1.4.0")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "chunked-transfer" version))
       (file-name
	(string-append name "-" version ".tar.gz"))
       (sha256
	(base32
	 "0bkdlsrszfcscw3j6yhs7kj6jbp8id47jjk6h9k58px47na5gy7z"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-development-inputs
       (("rust-criterion" ,rust-criterion-0.3))))
    (home-page
     "https://github.com/frewsxcv/rust-chunked-transfer")
    (synopsis
     "Encoder and decoder for HTTP chunked transfer coding (RFC 7230 Â§ 4.1)")
    (description
     "Encoder and decoder for HTTP chunked transfer coding (RFC 7230 Â§ 4.1)")
    (license license:asl2.0)))

(define-public rust-fdlimit-0.1
  (package
    (name "rust-fdlimit")
    (version "0.1.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "fdlimit" version))
       (file-name
	(string-append name "-" version ".tar.gz"))
       (sha256
	(base32
	 "0g30d6gqkrwy8ylwdy7pqm443iq0p5dmnpz4ks41pirl7dclm98d"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs (("rust-libc" ,rust-libc-0.2))))
    (home-page
     "https://github.com/paritytech/fdlimit")
    (synopsis
     "Utility crate for raising file descriptors limit for OSX and Linux")
    (description
     "Utility crate for raising file descriptors limit for OSX and Linux")
    (license license:asl2.0)))

(define-public rust-tiny-http-0.8
  (package
    (name "rust-tiny-http")
    (version "0.8.2")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "tiny-http" version))
       (file-name
	(string-append name "-" version ".tar.gz"))
       (sha256
	(base32
	 "0fcdwpb2ghk671qjjrk6048hs3yp7f681hxpr68gamk00181prcw"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs
       (("rust-ascii" ,rust-ascii-1)
	("rust-chrono" ,rust-chrono-0.4)
	("rust-chunked-transfer"
         ,rust-chunked-transfer-1)
	("rust-log" ,rust-log-0.4)
	("rust-openssl" ,rust-openssl-0.10)
	("rust-url" ,rust-url-2))
       #:cargo-development-inputs
       (("rust-fdlimit" ,rust-fdlimit-0.1)
	("rust-rustc-serialize"
         ,rust-rustc-serialize-0.3)
	("rust-sha1" ,rust-sha1-0.6))))
    (home-page
     "https://github.com/tiny-http/tiny-http")
    (synopsis "Low level HTTP server library")
    (description "Low level HTTP server library")
    (license (list license:expat license:asl2.0))))

(define-public rust-walkdir-2
  (package
    (name "rust-walkdir")
    (version "2.3.1")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "walkdir" version))
       (file-name
	(string-append name "-" version ".tar.gz"))
       (sha256
	(base32
	 "0z9g39f49cycdm9vzjf8hnfh3f1csxgd65kmlphj8r2vffy84wbp"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs
       (("rust-same-file" ,rust-same-file-1)
	("rust-winapi" ,rust-winapi-0.3)
	("rust-winapi-util" ,rust-winapi-util-0.1))
       #:cargo-development-inputs
       (("rust-doc-comment" ,rust-doc-comment-0.3))))
    (home-page
     "https://github.com/BurntSushi/walkdir")
    (synopsis "Recursively walk a directory.")
    (description "Recursively walk a directory.")
    (license (list license:unlicense license:expat))))

(define-public rust-tree-sitter-0.20
  (package
    (name "rust-tree-sitter")
    (version "0.20.4")
    (source
     (origin
       (method url-fetch)
       (uri (crate-uri "tree-sitter" version))
       (file-name
        (string-append name "-" version ".tar.gz"))
       (sha256
        (base32
         "16p3kysfzfgd8nyagfs2l8jpfdhr5cdlg0kk0czmwm5cirzk4d2f"))))
    (build-system cargo-build-system)
    (arguments
     `(#:cargo-inputs
       (("rust-cc" ,rust-cc-1)
        ("rust-lazy-static" ,rust-lazy-static-1)
        ("rust-regex" ,rust-regex-1)
        ("rust-spin" ,rust-spin-0.7))
       #:skip-build? #t))
    (home-page
     "https://github.com/tree-sitter/tree-sitter")
    (synopsis
     "Rust bindings to the Tree-sitter parsing library")
    (description
     "Rust bindings to the Tree-sitter parsing library")
    (license license:expat)))

(define-public rust-once-cell-1.7
  (package
    (name "rust-once-cell")
    (version "1.7.2")
    (source
      (origin
        (method url-fetch)
        (uri (crate-uri "once-cell" version))
        (file-name (string-append name "-" version ".tar.gz"))
        (sha256
          (base32 "18qmpyfigg4ibdhjy5mwcjhzk9adwlgfaqv7nj430ivm86q0i2xg"))))
    (build-system cargo-build-system)
    (arguments
      `(#:cargo-inputs
        (("rust-parking-lot" ,rust-parking-lot-0.11))
        #:cargo-development-inputs
        (("rust-crossbeam-utils" ,rust-crossbeam-utils-0.7)
         ("rust-lazy-static" ,rust-lazy-static-1)
         ("rust-regex" ,rust-regex-1))))
    (home-page "https://github.com/matklad/once_cell")
    (synopsis "Single assignment cells and lazy values.")
    (description "Single assignment cells and lazy values.")
    (license (list license:expat license:asl2.0))))

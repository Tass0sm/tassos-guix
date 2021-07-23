(use-modules (guix packages)
             (guix download)
             (gnu packages ruby)
             (guix build-system ruby))

(package
 (name "ruby-fuzzy-match")
 (version "2.1.0")
 (source
  (origin
   (method url-fetch)
   (uri (rubygems-uri "fuzzy_match" version))
   (sha256
    (base32
     "1z2d41cni66isbm3yc2qd1m3rzxnqw3x0w6rgvvsaj7fxb82azp9"))))
 (build-system ruby-build-system)
 ;; Extra dependency on yard?
 (inputs `(("ruby-yard" ,ruby-yard)))
 (arguments
  `(#:phases
    (modify-phases %standard-phases
                   (delete 'check))))
 (synopsis
  "Find a needle in a haystack using string similarity and (optionally) regexp rules. Replaces loose_tight_dictionary.")
 (description
  "Find a needle in a haystack using string similarity and (optionally) regexp rules.  Replaces loose_tight_dictionary.")
 (home-page
  "https://github.com/seamusabshere/fuzzy_match")
 (license #f))

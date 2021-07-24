(define-module (tassos-guix packages ruby)
  #:use-module (gnu packages ruby)

  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system ruby)
  #:use-module ((guix licenses) #:prefix license:)

  #:export (ruby-fuzzy-match
	    ruby-ntlm
	    ruby-mechanize))

(define ruby-fuzzy-match
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
    (license #f)))

(define ruby-webrick
  (package
    (name "ruby-webrick")
    (version "1.7.0")
    (source
     (origin
       (method url-fetch)
       (uri (rubygems-uri "webrick" version))
       (sha256
        (base32
         "1d4cvgmxhfczxiq5fr534lmizkhigd15bsx5719r5ds7k7ivisc7"))))
    (build-system ruby-build-system)
    (synopsis
     "WEBrick is an HTTP server toolkit that can be configured as an HTTPS server, a proxy server, and a virtual-host server.")
    (description
     "WEBrick is an HTTP server toolkit that can be configured as an HTTPS server, a proxy server, and a virtual-host server.")
    (home-page "https://github.com/ruby/webrick")
    (license (list #f #f))))

(define ruby-console
  (package
    (name "ruby-console")
    (version "1.13.1")
    (source
     (origin
       (method url-fetch)
       (uri (rubygems-uri "console" version))
       (sha256
        (base32
         "04vhg3vnj2ky00fld4v6qywx32z4pjsa7l8i7sl1bl213s8334l9"))))
    (build-system ruby-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (delete 'check))))
    (propagated-inputs
     `(("ruby-fiber-local" ,ruby-fiber-local)))
    (synopsis "Beautiful logging for Ruby.")
    (description "Beautiful logging for Ruby.")
    (home-page "https://github.com/socketry/console")
    (license license:expat)))

(define ruby-fiber-local
  (package
    (name "ruby-fiber-local")
    (version "1.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (rubygems-uri "fiber-local" version))
       (sha256
	(base32
	 "1vrxxb09fc7aicb9zb0pmn5akggjy21dmxkdl3w949y4q05rldr9"))))
    (build-system ruby-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (delete 'check))))
    (synopsis
     "Provides a class-level mixin to make fiber local state easy.")
    (description
     "This package provides a class-level mixin to make fiber local state easy.")
    (home-page
     "https://github.com/socketry/fiber-local")
    (license license:expat)))

(define ruby-timers
  (package
    (name "ruby-timers")
    (version "4.3.3")
    (source
     (origin
       (method url-fetch)
       (uri (rubygems-uri "timers" version))
       (sha256
        (base32
         "00xdi97gm01alfqhjgvv5sff9n1n2l6aym69s9jh8l9clg63b0jc"))))
    (build-system ruby-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (delete 'check))))
    (synopsis
     "Pure Ruby one-shot and periodic timers.")
    (description
     "Pure Ruby one-shot and periodic timers.")
    (home-page "https://github.com/socketry/timers")
    (license license:expat)))

(define ruby-async
  (package
    (name "ruby-async")
    (version "1.30.0")
    (source
     (origin
       (method url-fetch)
       (uri (rubygems-uri "async" version))
       (sha256
        (base32
         "0jz7wyrn9lvq28pqfq2wj8knp8h3g37nqwcq7qhy9a93kfx7i3dj"))))
    (build-system ruby-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (delete 'check))))    
    (propagated-inputs
     `(("ruby-console" ,ruby-console)
       ("ruby-nio4r" ,ruby-nio4r)
       ("ruby-timers" ,ruby-timers)))
    (synopsis "A concurrency framework for Ruby.")
    (description
     "This package provides a concurrency framework for Ruby.")
    (home-page "https://github.com/socketry/async")
    (license license:expat)))

(define ruby-async-http-faraday
  (package
    (name "ruby-async-http-faraday")
    (version "0.11.0")
    (source
     (origin
       (method url-fetch)
       (uri (rubygems-uri "async-http-faraday" version))
       (sha256
        (base32
         "0ndynkfknabv6m9wzcmdnj4r4bhlxqkg9c6rzsjc1pk8q057kslv"))))
    (build-system ruby-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (delete 'check))))
    (propagated-inputs
     `(("ruby-async-http" ,ruby-async-http)
       ("ruby-faraday" ,ruby-faraday)))
    (synopsis
     "Provides an adaptor between async-http and faraday.")
    (description
     "This package provides an adaptor between async-http and faraday.")
    (home-page
     "https://github.com/socketry/async-http")
    (license license:expat)))

(define ruby-faraday-http-cache
  (package
    (name "ruby-faraday-http-cache")
    (version "2.2.0")
    (source
     (origin
       (method url-fetch)
       (uri (rubygems-uri "faraday-http-cache" version))
       (sha256
        (base32
         "0lhfwlk4mhmw9pdlgdsl2bq4x45w7s51jkxjryf18wym8iiw36g7"))))
    (build-system ruby-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (delete 'check))))
    (propagated-inputs
     `(("ruby-faraday" ,ruby-faraday)))
    (synopsis "Middleware to handle HTTP caching")
    (description "Middleware to handle HTTP caching")
    (home-page
     "https://github.com/sourcelevel/faraday-http-cache")
    (license license:asl2.0)))

(define ruby-async-io
  (package
    (name "ruby-async-io")
    (version "1.32.2")
    (source
     (origin
       (method url-fetch)
       (uri (rubygems-uri "async-io" version))
       (sha256
        (base32
         "10l9m0x2ffvsaaxc4mfalrljjx13njkyir9w6yfif8wpszc291h8"))))
    (build-system ruby-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (delete 'check))))
    (propagated-inputs `(("ruby-async" ,ruby-async)))
    (synopsis
     "Provides support for asynchonous TCP, UDP, UNIX and SSL sockets.")
    (description
     "This package provides support for asynchonous TCP, UDP, UNIX and SSL sockets.")
    (home-page
     "https://github.com/socketry/async-io")
    (license license:expat)))

(define ruby-async-pool
  (package
    (name "ruby-async-pool")
    (version "0.3.8")
    (source
     (origin
       (method url-fetch)
       (uri (rubygems-uri "async-pool" version))
       (sha256
        (base32
         "0hdb07fwafc744aw3wqs0958cw483gdn6apw4yryfhg50ljr8h3k"))))
    (build-system ruby-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (delete 'check))))
    (propagated-inputs `(("ruby-async" ,ruby-async)))
    (synopsis
     "A singleplex and multiplex resource pool for implementing robust clients.")
    (description
     "This package provides a singleplex and multiplex resource pool for implementing robust clients.")
    (home-page
     "https://github.com/socketry/async-pool")
    (license license:expat)))

(define ruby-protocol-http
  (package
    (name "ruby-protocol-http")
    (version "0.22.5")
    (source
     (origin
       (method url-fetch)
       (uri (rubygems-uri "protocol-http" version))
       (sha256
        (base32
         "0lhg47b3w1d6pdwdkyha8ijzfhjrh90snwydkhwfnl5r10dd9cg5"))))
    (build-system ruby-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (delete 'check))))
    (synopsis
     "Provides abstractions to handle HTTP protocols.")
    (description
     "This package provides abstractions to handle HTTP protocols.")
    (home-page
     "https://github.com/socketry/protocol-http")
    (license license:expat)))

(define ruby-protocol-http1
  (package
    (name "ruby-protocol-http1")
    (version "0.14.1")
    (source
     (origin
       (method url-fetch)
       (uri (rubygems-uri "protocol-http1" version))
       (sha256
        (base32
         "0wp9pi1qjh1darrqv0r46i4bvax3n64aa0mn7kza4251qmk0dwz5"))))
    (build-system ruby-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (delete 'check))))
    (propagated-inputs
     `(("ruby-protocol-http" ,ruby-protocol-http)))
    (synopsis
     "A low level implementation of the HTTP/1 protocol.")
    (description
     "This package provides a low level implementation of the HTTP/1 protocol.")
    (home-page
     "https://github.com/socketry/protocol-http1")
    (license license:expat)))

(define ruby-protocol-hpack
  (package
    (name "ruby-protocol-hpack")
    (version "1.4.2")
    (source
     (origin
       (method url-fetch)
       (uri (rubygems-uri "protocol-hpack" version))
       (sha256
        (base32
         "0sd85am1hj2w7z5hv19wy1nbisxfr1vqx3wlxjfz9xy7x7s6aczw"))))
    (build-system ruby-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (delete 'check))))
    (synopsis
     "A compresssor and decompressor for HTTP 2.0 HPACK.")
    (description
     "This package provides a compresssor and decompressor for HTTP 2.0 HPACK.")
    (home-page
     "https://github.com/socketry/http-hpack")
    (license license:expat)))

(define ruby-protocol-http2
  (package
    (name "ruby-protocol-http2")
    (version "0.14.2")
    (source
     (origin
       (method url-fetch)
       (uri (rubygems-uri "protocol-http2" version))
       (sha256
        (base32
         "1a9klpfmi7w465zq5xz8y8h1qvj42hkm0qd0nlws9d2idd767q5j"))))
    (build-system ruby-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (delete 'check))))
    (propagated-inputs
     `(("ruby-protocol-hpack" ,ruby-protocol-hpack)
       ("ruby-protocol-http" ,ruby-protocol-http)))
    (synopsis
     "A low level implementation of the HTTP/2 protocol.")
    (description
     "This package provides a low level implementation of the HTTP/2 protocol.")
    (home-page
     "https://github.com/socketry/protocol-http2")
    (license license:expat)))

(define ruby-async-http
  (package
    (name "ruby-async-http")
    (version "0.56.5")
    (source
     (origin
       (method url-fetch)
       (uri (rubygems-uri "async-http" version))
       (sha256
        (base32
         "0v3451bnn7rhgvl6ng0ys0dgm7cmyi3m41kmf5wyrpb83dhds13l"))))
    (build-system ruby-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (delete 'check))))
    (propagated-inputs
     `(("ruby-async" ,ruby-async)
       ("ruby-async-io" ,ruby-async-io)
       ("ruby-async-pool" ,ruby-async-pool)
       ("ruby-protocol-http" ,ruby-protocol-http)
       ("ruby-protocol-http1" ,ruby-protocol-http1)
       ("ruby-protocol-http2" ,ruby-protocol-http2)))
    (synopsis "A HTTP client and server library.")
    (description
     "This package provides a HTTP client and server library.")
    (home-page
     "https://github.com/socketry/async-http")
    (license license:expat)))

(define ruby-github-changelog-generator
  (package
    (name "ruby-github-changelog-generator")
    (version "1.16.4")
    (source
     (origin
       (method url-fetch)
       (uri (rubygems-uri
             "github_changelog_generator"
             version))
       (sha256
        (base32
         "04d6z2ysq3gzvpw91lq8mxmdlqcxkmvp8rw9zrzkmksh3pjdzli1"))))
    (build-system ruby-build-system)
    ;; Bad fix
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (delete 'check))))    
    (native-inputs
     `(("ruby-rubocop" ,ruby-rubocop)
       ("ruby-rspec" ,ruby-rspec)))
    (propagated-inputs
     `(("ruby-activesupport" ,ruby-activesupport)
       ("ruby-async" ,ruby-async)
       ("ruby-async-http-faraday"
	,ruby-async-http-faraday)
       ("ruby-faraday-http-cache"
	,ruby-faraday-http-cache)
       ("ruby-multi-json" ,ruby-multi-json)
       ("ruby-octokit" ,ruby-octokit)
       ("ruby-rainbow" ,ruby-rainbow)
       ("ruby-rake" ,ruby-rake)))
    (synopsis
     "Changelog generation has never been so easy. Fully automate changelog generation - this gem generate changelog file based on tags, issues and merged pull requests from GitHub.")
    (description
     "Changelog generation has never been so easy.  Fully automate changelog generation - this gem generate changelog file based on tags, issues and merged pull requests from GitHub.")
    (home-page
     "https://github.com/github-changelog-generator/Github-Changelog-Generator")
    (license license:expat)))

(define ruby-rubyntlm
  (package
    (name "ruby-rubyntlm")
    (version "0.6.3")
    (source
     (origin
       (method url-fetch)
       (uri (rubygems-uri "rubyntlm" version))
       (sha256
        (base32
         "0b8hczk8hysv53ncsqzx4q6kma5gy5lqc7s5yx8h64x3vdb18cjv"))))
    (build-system ruby-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (delete 'check))))
    (native-inputs
     `(("ruby-github-changelog-generator" ,ruby-github-changelog-generator)
       ("ruby-rspec" ,ruby-rspec)))
    (synopsis
     "Ruby/NTLM provides message creator and parser for the NTLM authentication.")
    (description
     "Ruby/NTLM provides message creator and parser for the NTLM authentication.")
    (home-page "https://github.com/winrb/rubyntlm")
    (license license:expat)))

(define ruby-webrobots
  (package
    (name "ruby-webrobots")
    (version "0.1.2")
    (source
     (origin
       (method url-fetch)
       (uri (rubygems-uri "webrobots" version))
       (sha256
        (base32
         "19ndcbba8s8m62hhxxfwn83nax34rg2k5x066awa23wknhnamg7b"))))
    (build-system ruby-build-system)
    ;; Bad fix
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (delete 'check))))
    (native-inputs
     `(("ruby-simplecov" ,ruby-simplecov)
       ("ruby-coveralls" ,ruby-coveralls)
       ("ruby-term-ansicolor" ,ruby-term-ansicolor)))
    (synopsis
     "This library helps write robots.txt compliant web robots in Ruby.")
    (description
     "This library helps write robots.txt compliant web robots in Ruby.")
    (home-page "https://github.com/knu/webrobots")
    (license #f)))

(define ruby-mechanize
  (package
    (name "ruby-mechanize")
    (version "2.8.1")
    (source
     (origin
       (method url-fetch)
       (uri (rubygems-uri "mechanize" version))
       (sha256
        (base32
         "190nsrjdf1gc6g28ixia5jdzyrzs0ahik7hq5526gx9qhp0d0hya"))))
    (build-system ruby-build-system)
    ;; Bad fix
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (delete 'check))))
    (inputs
     `(("ruby-connection-pool" ,ruby-connection-pool)))
    (propagated-inputs
     `(("ruby-addressable" ,ruby-addressable)
       ("ruby-domain-name" ,ruby-domain-name)
       ("ruby-http-cookie" ,ruby-http-cookie)
       ("ruby-mime-types" ,ruby-mime-types)
       ("ruby-net-http-digest-auth"
	,ruby-net-http-digest-auth)
       ("ruby-net-http-persistent"
	,ruby-net-http-persistent)
       ("ruby-nokogiri" ,ruby-nokogiri)
       ("ruby-rubyntlm" ,ruby-rubyntlm)
       ("ruby-webrick" ,ruby-webrick)
       ("ruby-webrobots" ,ruby-webrobots)))
    (synopsis
     "The Mechanize library is used for automating interaction with websites.
Mechanize automatically stores and sends cookies, follows redirects,
and can follow links and submit forms.  Form fields can be populated and
submitted.  Mechanize also keeps track of the sites that you have visited as
a history.")
    (description
     "The Mechanize library is used for automating interaction with websites.
Mechanize automatically stores and sends cookies, follows redirects,
and can follow links and submit forms.  Form fields can be populated and
submitted.  Mechanize also keeps track of the sites that you have visited as
a history.")
    (home-page
     "https://github.com/sparklemotion/mechanize")
    (license license:expat)))

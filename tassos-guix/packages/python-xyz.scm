(define-module (tassos-guix packages python-xyz)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-web)

  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system python)
  #:use-module ((guix licenses) #:prefix license:)

  #:export (python-aiosocks
	    python-discord.py))

(define python-aiosocks
  (package
    (name "python-aiosocks")
    (version "0.2.6")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/nibrag/aiosocks.git")
             (commit "d4a85e73c9e3beadd7ab4c46b8f3ceb3b57338b2")))
       (sha256
	(base32
	 "168rwvbfvgr9g75szhr4vc0ghsx0pq670am3wr60yrhgqdng2gbh"))))
    (build-system python-build-system)
    (inputs
     `(("python-aiohttp" ,python-aiohttp)))
    (home-page "https://github.com/nibrag/aiosocks")
    (synopsis
     "SOCKS proxy client for asyncio and aiohttp")
    (description
     "SOCKS proxy client for asyncio and aiohttp")
    (license #f)))

(define python-discord.py
  (package
    (name "python-discord.py")
    (version "1.7.2")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "discord.py" version))
       (sha256
	(base32
	 "13i9xs16bkdfi5mfsx7zgjkcjxywvfi03w7pmccvjbrn4z6pckhi"))))
    (build-system python-build-system)
    (propagated-inputs
     `(("python-aiohttp" ,python-aiohttp)))
    (home-page
     "https://github.com/Rapptz/discord.py")
    (synopsis "A Python wrapper for the Discord API")
    (description
     "A Python wrapper for the Discord API")
    (license license:expat)))

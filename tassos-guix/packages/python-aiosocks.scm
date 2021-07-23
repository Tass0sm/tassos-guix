(use-modules (guix packages)
             (guix git-download)
             (gnu packages python)
             (gnu packages python-web)
             (guix build-system python)
             ((guix licenses) #:prefix license:))

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
  (license #f))

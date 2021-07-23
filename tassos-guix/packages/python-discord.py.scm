(use-modules (guix packages)
             (guix download)
             (gnu packages python)
             (gnu packages python-web)
             (guix build-system python)
             ((guix licenses) #:prefix license:))

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
 (license license:expat))

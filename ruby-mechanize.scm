(use-modules (guix packages)
             (guix download)
             ((guix licenses) #:prefix license:)
             (gnu packages ruby)
             (guix build-system ruby))

(package
  (name "ruby-mechanize")
  (version "2.8.1")
  (source
    (origin
      (method url-fetch)
      (uri (rubygems-uri "mechanize" version))
      (sha256
        (base32
          "190nsrjdf1gc6g28ixia5jdzyrzs0ahik7hq5526gx9qhp0d0hiya"))))
  (build-system ruby-build-system)
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
  (license license:expat))

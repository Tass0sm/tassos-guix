(define-module (tassos-guix home-services desktop)
  #:use-module (gnu home services)
  #:use-module (gnu home services utils)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages xfce)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu services configuration)

  #:use-module (srfi srfi-1)

  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix utils)

  #:use-module (tassos-guix home-services wm)

  #:export (home-sx-configuration
            home-sx-service-type))

                                        ; sx

(define-configuration home-sx-configuration
  (package
   (package sx)
   "The sx package to use.")
  (sxrc-head
   (text-config '())
   "List of strings or gexps for the head of the sx config file.")
  (sxrc-tail
   (text-config '())
   "List of strings or gexps for the tail of the sx config file."))

(define (add-sx-package config)
  (list (home-sx-configuration-package config)))

(define (add-sx-files config)
  `((".config/sx/sxrc" ,(mixed-executable-text-file
                         "sxrc"
                         (serialize-configuration
                          config
                          (filter-configuration-fields
                           home-sx-configuration-fields
                           '(sxrc-head
                             sxrc-tail)))))))

(define (add-sxrc-extensions config extensions)
  (home-sx-configuration
   (inherit config)
   (sxrc-head
    (append (home-sx-configuration-sxrc-head config)
            extensions))))

(define home-sx-service-type
  (service-type (name 'home-sx)
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        add-sx-package)
                       (service-extension
                        home-files-service-type
                        add-sx-files)))
                (compose concatenate)
                (extend add-sxrc-extensions)
                (default-value (home-sx-configuration))
                (description "Install and configure sx.")))

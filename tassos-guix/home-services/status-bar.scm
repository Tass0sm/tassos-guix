(define-module (tassos-guix home-services status-bar)
  #:use-module (gnu home-services)
  #:use-module (gnu home-services-utils)
  #:use-module (gnu home-services files)
  #:use-module (gnu home-services shepherd)
  #:use-module (gnu packages image)
  #:use-module (gnu services configuration)

  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix utils)

  #:export (home-polybar-service-type
	    home-polybar-configuration))

					; polybar

(define-configuration/no-serialization home-polybar-configuration
  (package
   (package polybar)
   "The polybar package to use.")
  (config
   (text-config '())
   "List of strings or gexps containing the polybar config file."))

(define (add-polybar-package config)
  (list (home-polybar-configuration-package config)))

(define (add-polybar-files config)
  `(("config/polybar/config" ,(mixed-text-file
 			       "config"
			       (serialize-text-config
				#f
				(home-polybar-configuration-config config))))))	       

(define home-polybar-service-type
  (service-type (name 'home-polybar)
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        add-polybar-package)
                       (service-extension
                        home-files-service-type
                        add-polybar-files)))
                (description "Install and configure polybar.")))

(define-module (tassos-guix home-services notifications)
  #:use-module (gnu home-services)
  #:use-module (gnu home-services-utils)
  #:use-module (gnu home-services shepherd)
  #:use-module (gnu packages dunst)
  #:use-module (gnu services configuration)

  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix utils)

  #:export (home-dunst-configuration
	    home-dunst-service-type))

					; dunst

(define-configuration/no-serialization home-dunst-configuration
  (package
   (package dunst)
   "The dunst package to use.")
  (dunstrc
   (text-config '())
   "List of strings or gexps containing the dunst config file."))

(define (add-dunst-package config)
  (list (home-dunst-configuration-package config)))

(define (add-dunst-files config)
  `(("config/dunst/dunstrc" ,(mixed-text-file
 			       "dunstrc"
			       (serialize-text-config
				#f
				(home-dunst-configuration-dunstrc config))))))	       

(define home-dunst-service-type
  (service-type (name 'home-dunst)
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        add-dunst-package)
                       (service-extension
                        home-files-service-type
                        add-dunst-files)))
                (description "Install and configure dunst.")))

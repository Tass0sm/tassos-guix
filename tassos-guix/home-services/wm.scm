(define-module (tassos-guix home-services wm)
  #:use-module (gnu home services)
  #:use-module (gnu home services utils)
  #:use-module (gnu home services shepherd)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages xfce)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu services configuration)

  #:use-module (srfi srfi-1)

  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix utils)

  #:export (home-polybar-configuration
	    home-polybar-service-type

	    home-bspwm-configuration
	    home-bspwm-service-type

	    home-sxhkd-configuration
	    home-sxhkd-service-type

	    home-xfce-configuration
	    home-xfce-service-type))

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

					; bspwm

(define* (mixed-executable-text-file name #:rest text)
  "Return an object representing an executable store file NAME containing TEXT.
TEXT is a sequence of strings and file-like objects, as in:

  (mixed-text-file \"profile\"
                   \"export PATH=\" coreutils \"/bin:\" grep \"/bin\")

This is the declarative counterpart of 'text-file*'."
  (define build
    (gexp (call-with-output-file (ungexp output "out")
            (lambda (port)
	      (chmod port #o555)
              (display (string-append (ungexp-splicing text)) port)))))

  (computed-file name build))

(define-configuration/no-serialization home-bspwm-configuration
  (package
   (package bspwm)
   "The bspwm package to use.")
  (bspwmrc
   (text-config '())
   "List of strings or gexps containing the bspwmrc file."))

(define (add-bspwm-package config)
  (list (home-bspwm-configuration-package config)))

(define (add-bspwm-files config)
  (let ((bspwmrc (serialize-text-config
		  #f
		  (home-bspwm-configuration-bspwmrc config))))
    `(("config/bspwm/bspwmrc" ,(mixed-executable-text-file
 				"bspwmrc"
				bspwmrc)))))

(define home-bspwm-service-type
  (service-type (name 'home-bspwm)
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        add-bspwm-package)
                       (service-extension
                        home-files-service-type
                        add-bspwm-files)))
                (description "Install and configure the binary space
partitioning window manager.")))

					; sxhkd

(define-configuration/no-serialization home-sxhkd-configuration
  (package
   (package sxhkd)
   "The bspwm package to use.")
  (sxhkdrc
   (text-config '())
   "List of strings or gexps containing the sxhkdrc file."))

(define (add-sxhkd-package config)
  (list (home-sxhkd-configuration-package config)))

(define (add-sxhkd-files config)
  (let ((sxhkdrc (serialize-text-config
		  #f
		  (home-sxhkd-configuration-sxhkdrc config))))
    `(("config/sxhkd/sxhkdrc" ,(mixed-text-file
 				"sxhkdrc"
				sxhkdrc)))))

(define home-sxhkd-service-type
  (service-type (name 'home-sxhkd)
                (extensions
                 (list (service-extension
                        home-profile-service-type
                        add-sxhkd-package)
		       (service-extension
                        home-files-service-type
                        add-sxhkd-files)))
                (description "Install and configure the simple X11 hotkey
daemon.")))

					; xfce

;; (define-configuration/no-serialization home-xfce-configuration
;;   (package
;;    (package flameshot)
;;    "Flameshot package to use.")
;; 
;;   ;; 
;;   
;;   (server-mode?
;;    (boolean #f)
;;    "Create a shepherd service, which starts a flameshot deamon."))
;;  
;; (define (add-xfce-packages config)
;;   (map specification->package
;;        (list
;; 	"xfce"
;; 	"xfce4-session"
;; 	"xfconf"
;; 	"xfce4-battery-plugin"
;; 	"xfce4-volumed-pulse"
;; 	"xfce4-notifyd"
;; 	"pulseaudio"
;; 	"xbacklight"
;; 	"pavucontrol")))
;; 

;;(define xfce-desktop-service-type
;;  (service-type
;;   (name 'xfce-desktop)
;;   (extensions
;;    (list
;;     (service-extension polkit-service-type
;;                        xfce-polkit-settings)
;;     (service-extension profile-service-type
;;                        (compose list xfce-package))
;;     ))
;;   (default-value (xfce-desktop-configuration))
;;   (description "Run the Xfce desktop environment.")))
 
 

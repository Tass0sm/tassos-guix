(define-module (tassos-guix home-services desktop)
  #:use-module (gnu home-services)
  #:use-module (gnu home-services-utils)
  #:use-module (gnu home-services files)
  #:use-module (gnu home-services shepherd)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages xfce)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu services configuration)

  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix utils)

  #:export (home-bspwm-configuration
	    home-bspwm-service-type

	    home-sxhkd-configuration
	    home-sxhkd-service-type

	    home-xfce-configuration
	    home-xfce-service-type))

					; bspwm

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
    `(("config/bspwm/bspwmrc" ,(program-file
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
 
 

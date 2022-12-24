(define-module (tassos-guix home-services shells)
  #:use-module (gnu services configuration)
  #:use-module (gnu home services utils)
  #:use-module (gnu home services)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages bash)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix records)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-26)
  #:use-module (ice-9 match)

  #:export (home-shell-profile-service-type
            home-shell-profile-configuration

            home-zsh-service-type
            home-zsh-configuration
            home-zsh-extension))

;;;
;;; Shell profile.
;;;

(define path? string?)
(define (serialize-path field-name val) val)

(define-configuration home-shell-profile-configuration
  (profile
   (text-config '())
   "\
@code{home-shell-profile} is instantiated automatically by
@code{home-environment}, DO NOT create this service manually, it can
only be extended.

@code{profile} is a list of file-like objects, which will go to
@file{~/.profile}.  By default @file{~/.profile} contains the
initialization code, which have to be evaluated by login shell to make
home-environment's profile available to the user, but other commands
can be added to the file if it is really necessary.

In most cases shell's configuration files are preferred places for
user's customizations.  Extend home-shell-profile service only if you
really know what you do."))

(define (add-shell-profile-file config)
  `((".profile"
     ,(mixed-text-file
       "shell-profile"
       (serialize-configuration
        config
        (filter-configuration-fields
         home-shell-profile-configuration-fields '(profile)))))))

(define (add-profile-extensions config extensions)
  (home-shell-profile-configuration
   (inherit config)
   (profile
    (append (home-shell-profile-configuration-profile config)
            extensions))))

(define home-shell-profile-service-type
  (service-type (name 'home-shell-profile)
                (extensions
                 (list (service-extension
                        home-files-service-type
                        add-shell-profile-file)))
                (compose concatenate)
                (extend add-profile-extensions)
                (default-value (home-shell-profile-configuration))
                (description "Create @file{~/.profile}, which is used
for environment initialization of POSIX compliant login shells.  This
service type can be extended with a list of file-like objects.")))

(define (serialize-boolean field-name val) "")
(define (serialize-posix-env-vars field-name val)
  (environment-variable-shell-definitions val))

;;;
;;; Zsh.
;;;

(define-configuration home-zsh-configuration
  (package
    (package zsh)
    "The Zsh package to use.")
  (xdg-flavor?
   (boolean #t)
   "Place all the configs to @file{$XDG_CONFIG_HOME/zsh}.  Makes
@file{~/.zshenv} to set @env{ZDOTDIR} to @file{$XDG_CONFIG_HOME/zsh}.
Shell startup process will continue with
@file{$XDG_CONFIG_HOME/zsh/.zshenv}.")
  (environment-variables
   (alist '())
   "Association list of environment variables to set for the Zsh session."
   serialize-posix-env-vars)
  (zshenv
   (text-config '())
   "List of file-like objects, which will be added to @file{.zshenv}.
Used for setting user's shell environment variables.  Must not contain
commands assuming the presence of tty or producing output.  Will be
read always.  Will be read before any other file in @env{ZDOTDIR}.")
  (zprofile
   (text-config '())
   "List of file-like objects, which will be added to @file{.zprofile}.
Used for executing user's commands at start of login shell (In most
cases the shell started on tty just after login).  Will be read before
@file{.zlogin}.")
  (include-zprofile-stub?
   (boolean #t)
   "Include lines at the beginning of zprofile which source
@file{/etc/profile} and @file{~/.profile}.")
  (zshrc
   (text-config '())
   "List of file-like objects, which will be added to @file{.zshrc}.
Used for executing user's commands at start of interactive shell (The
shell for interactive usage started by typing @code{zsh} or by
terminal app or any other program).")
  (zlogin
   (text-config '())
   "List of file-like objects, which will be added to @file{.zlogin}.
Used for executing user's commands at the end of starting process of
login shell.")
  (zlogout
   (text-config '())
   "List of file-like objects, which will be added to @file{.zlogout}.
Used for executing user's commands at the exit of login shell.  It
won't be read in some cases (if the shell terminates by exec'ing
another process for example)."))

(define (zsh-filter-fields field)
  (filter-configuration-fields home-zsh-configuration-fields (list field)))

(define (zsh-serialize-field config field)
  (serialize-configuration config (zsh-filter-fields field)))

(define* (zsh-field-not-empty? config field)
  (let ((file-name (symbol->string field))
        (field-obj (car (zsh-filter-fields field))))
    (not (null? ((configuration-field-getter field-obj) config)))))

(define (zsh-file-zshenv config)
  (mixed-text-file
   "zshenv"
   (zsh-serialize-field config 'zshenv)
   (zsh-serialize-field config 'environment-variables)))

(define (zsh-file-by-field config field)
  (match field
    ('zshenv (zsh-file-zshenv config))
    (e (mixed-text-file
        (symbol->string field)
        (zsh-serialize-field config field)))))

(define (zsh-get-configuration-files config)
  `(,@(if (or (zsh-field-not-empty? config 'zshenv)
              (zsh-field-not-empty? config 'environment-variables))
          `((".zshenv" ,(zsh-file-by-field config 'zshenv))) '())
    ,@(if (zsh-field-not-empty? config 'zprofile)
          `((".zprofile" ,(zsh-file-by-field config 'zprofile))) '())    
    ,@(if (zsh-field-not-empty? config 'zshrc)
          `((".zshrc" ,(zsh-file-by-field config 'zshrc))) '())
    ,@(if (zsh-field-not-empty? config 'zlogin)
          `((".zlogin" ,(zsh-file-by-field config 'zlogin))) '())
    ,@(if (zsh-field-not-empty? config 'zlogout)
          `((".zlogout" ,(zsh-file-by-field config 'zlogout))) '())))

(define (add-zsh-dot-configuration config)
  (define zshenv-auxiliary-file
    (mixed-text-file
     "zshenv-auxiliary"
     "export ZDOTDIR=${XDG_CONFIG_HOME:-$HOME/.config}/zsh\n"
     "[[ -f $ZDOTDIR/.zshenv ]] && source $ZDOTDIR/.zshenv\n"))

  (if (home-zsh-configuration-xdg-flavor? config)
      `((".zshenv" ,zshenv-auxiliary-file))
      (zsh-get-configuration-files config)))

(define (add-zsh-xdg-configuration config)
  (if (home-zsh-configuration-xdg-flavor? config)
      (map
       (lambda (lst)
         (cons (string-append "zsh/" (car lst))
               (cdr lst)))
       (zsh-get-configuration-files config))
      '()))

(define (add-zsh-packages config)
  (list (home-zsh-configuration-package config)))

(define-configuration/no-serialization home-zsh-extension
  (environment-variables
   (alist '())
   "Association list of environment variables to set.")
  (zshrc
   (text-config '())
   "List of file-like objects.")
  (zshenv
   (text-config '())
   "List of file-like objects.")
  (zprofile
   (text-config '())
   "List of file-like objects.")
  (zlogin
   (text-config '())
   "List of file-like objects.")
  (zlogout
   (text-config '())
   "List of file-like objects."))

(define (home-zsh-extensions original-config extension-configs)
  (home-zsh-configuration
   (inherit original-config)
   (environment-variables
    (append (home-zsh-configuration-environment-variables original-config)
            (append-map
             home-zsh-extension-environment-variables extension-configs)))
   (zshrc
    (append (home-zsh-configuration-zshrc original-config)
            (append-map
             home-zsh-extension-zshrc extension-configs)))
   (zshenv
    (append (home-zsh-configuration-zshenv original-config)
            (append-map
             home-zsh-extension-zshenv extension-configs)))
   (zprofile
    (append (home-zsh-configuration-zprofile original-config)
            (append-map
             home-zsh-extension-zprofile extension-configs)))
   (zlogin
    (append (home-zsh-configuration-zlogin original-config)
            (append-map
             home-zsh-extension-zlogin extension-configs)))
   (zlogout
    (append (home-zsh-configuration-zlogout original-config)
            (append-map
             home-zsh-extension-zlogout extension-configs)))))

(define home-zsh-service-type
  (service-type (name 'home-zsh)
                (extensions
                 (list (service-extension
                        home-files-service-type
                        add-zsh-dot-configuration)
                       (service-extension
                        home-xdg-configuration-files-service-type
                        add-zsh-xdg-configuration)
                       (service-extension
                        home-profile-service-type
                        add-zsh-packages)))
                (compose identity)
                (extend home-zsh-extensions)
                (default-value (home-zsh-configuration))
                (description "Install and configure Zsh.")))

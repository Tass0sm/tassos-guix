(define-module (tassos-guix packages linux)
  #:use-module (gnu packages)
  #:use-module (guix gexp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix utils)
  #:use-module (guix build-system cmake)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages xorg)
  #:use-module (tassos-guix packages gl)
  #:use-module (srfi srfi-1))

(define-public libthinkpad
  (let ((revision "0")
        (commit "e7b4eca8142b35a1441c54cdeeb2b2b7e7d35649"))
    (package
      (name "libthinkpad")
      (version (git-version "2.6" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/Tass0sm/libthinkpad")
               (commit commit)))
         (file-name (git-file-name "libthinkpad" version))
         (sha256
          (base32 "03qgpvwskr0grs572c0r6xfkdl7yqspd069bfh29blh3sc4piwsw"))))
      (build-system cmake-build-system)
      (arguments
       (list #:phases
             #~(modify-phases %standard-phases
                 (add-after 'unpack 'disable-systemd-build
                   (lambda* (#:key inputs #:allow-other-keys)
                     (substitute* "CMakeLists.txt"
                       (("set\\(SYSTEMD on\\)" _) "unset(SYSTEMD)"))
                     #t))
                 (delete 'check))))
      (inputs
       (list eudev))
      (home-page "https://github.com/Tass0sm/libthinkpad")
      (synopsis "A general purpose userspace ThinkPad library")
      (description "libthinkpad is a userspace general purpose library to change hardware
configuration and manage hardware events in the userspace for Lenovo/IBM
ThinkPad laptops.")
      (license #f))))

(define-public dockd
  (let ((revision "0")
        (commit "495ba3588db5c2a186e12eab863b1e09c7092272"))
    (package
      (name "dockd")
      (version (git-version "0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/Tass0sm/dockd")
               (commit commit)))
         (file-name (git-file-name "dockd" version))
         (sha256
          (base32 "1aw4c5y4npkvwg0mndrrd0fx4bk3rymxn40hzrsdvwxj0by76f8w"))))
      (build-system cmake-build-system)
      (arguments
       (list #:phases
             #~(modify-phases %standard-phases
                 (add-after 'unpack 'disable-file-installation
                   (lambda* (#:key inputs #:allow-other-keys)
                     (substitute* "CMakeLists.txt"
                       (("install\\(FILES .*\\)" _) ""))
                     #t))
                 (delete 'check))))
      (inputs
       (list libxrandr libthinkpad))
      (home-page "https://github.com/Tass0sm/dockd")
      (synopsis "Lenovo ThinkPad Dock Management Daemon.")
      (description "dockd is a program that runs in the background and detects when your ThinkPad is
added or removed from a dock and it automatically switches output mode profiles
that you have configured before.")
      (license #f))))

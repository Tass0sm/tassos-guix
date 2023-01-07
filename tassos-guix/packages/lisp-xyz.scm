(define-module (tassos-guix packages lisp-xyz)
  #:use-module (gnu packages)
  #:use-module (guix gexp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix utils)
  #:use-module (guix build-system asdf)
  #:use-module (gnu packages audio)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (gnu packages graphics)
  #:use-module (gnu packages compression)
  #:use-module (tassos-guix packages gl)
  #:use-module (srfi srfi-1))

(define-public sbcl-qua
  (let ((commit "1e64d867feb152b1c49447639579aa75211b3d48")
        (revision "1"))
    (package
      (name "sbcl-qua")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/hahahahaman/qua")
               (commit commit)))
         (file-name (git-file-name "qua" version))
         (sha256
          (base32 "1jc2w0bmg7ijvhypqibpbifs31n46ch0l8q78b7120mcq23wicai"))))
      (build-system asdf-build-system/sbcl)
      (inputs
       (list sbcl-alexandria sbcl-iterate))
      (home-page "https://github.com/hahahahaman/qua")
      (synopsis "")
      (description "")
      (license license:expat))))

(define-public sbcl-easing
  (let ((commit "1601a5f7413ba92c355d95a7d5200b648ddcdf35")
        (revision "1"))
    (package
      (name "sbcl-easing")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/vydd/easing")
               (commit commit)))
         (file-name (git-file-name "easing" version))
         (sha256
          (base32 "0750cs5kij8hi53960lzih57xrf92fj23i3hxzhqzcyla4wi4jv5"))))
      (build-system asdf-build-system/sbcl)
      (inputs
       (list sbcl-alexandria))
      (home-page "https://github.com/vydd/easing")
      (synopsis "")
      (description "")
      (license license:expat))))

(define-public sbcl-nineveh
  (let ((commit "0a10a84669cd9d1c584f54b9eab062986a5f1c47")
        (revision "1"))
    (package
      (name "sbcl-nineveh")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/cbaggers/nineveh")
               (commit commit)))
         (file-name (git-file-name "nineveh" version))
         (sha256
          (base32 "0bpdgqc9iz37240ypirpi489pnqpb92i94snyhjbh87i50y4br2l"))))
      (build-system asdf-build-system/sbcl)
      (inputs
       (list sbcl-cepl sbcl-cl-soil sbcl-livesupport sbcl-easing
             sbcl-documentation-utils sbcl-dendrite sbcl-real-rtg-math
             sbcl-with-setf))
      (home-page "https://github.com/cbaggers/nineveh")
      (synopsis "")
      (description "")
      (license license:bsd-2))))

(define-public sbcl-real-rtg-math
  (let ((commit "29fc5b3d0028a4a11a82355ecc8cca62662c69e0")
        (revision "1"))
    (package
      (name "sbcl-real-rtg-math")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/cbaggers/rtg-math")
               (commit commit)))
         (file-name (git-file-name "rtg-math" version))
         (sha256
          (base32 "0bhxxnv7ldkkb18zdxyz2rj2a3iawzq2kcp7cn5i91iby7n0082x"))))
      (build-system asdf-build-system/sbcl)
      (arguments
       `(#:asd-systems
         '("rtg-math" "rtg-math.vari")))
      (inputs
       (list sbcl-varjo sbcl-alexandria sbcl-documentation-utils sbcl-glsl-spec))
      (home-page "https://github.com/cbaggers/rtg-math")
      (synopsis "Common Lisp library of game-related math functions")
      (description
       "RTG-MATH provides a selection of the math routines most commonly needed
for making realtime graphics in Lisp.")
      (license license:bsd-2))))

(define-public sbcl-cl-fond
  (package
    (name "sbcl-cl-fond")
    (version "1.1.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/Shirakumo/cl-fond")
             (commit "dac975cbc73f231b400d5b8d8539b16330239a4a")))
       (file-name (git-file-name "cl-fond" version))
       (sha256
        (base32 "03ygcw1azb44bhdsqcq99xi4ci0by76ap5jf5l2d1vfxq04v8grq"))))
    (build-system asdf-build-system/sbcl)
    (arguments
     (list #:phases
           #~(modify-phases %standard-phases
               (add-after 'unpack 'fix-paths
                 (lambda* (#:key inputs #:allow-other-keys)
                   (substitute* "low-level.lisp"
                     (("libfond.so" all)
                      (string-append
                       #$libfond "/lib/" all)))
                   #t)))))
    (inputs
     (list sbcl-alexandria
           sbcl-cffi
           sbcl-trivial-features
           sbcl-trivial-garbage
           sbcl-documentation-utils
           sbcl-cl-opengl))
    (home-page "https://github.com/Shirakumo/cl-fond")
    (synopsis "Bindings to libfond, a simple text rendering engine for OpenGL
A helper library for using cl-fond with CEPL")
    (description "Bindings to libfond, a simple text rendering engine for OpenGL
A helper library for using cl-fond with CEPL")
    (license license:zlib)))

(define-public sbcl-cepl.fond
  (let ((commit "45ed0ef72b65c905a2ee97c6e87da6de6ec424b7")
        (revision "1"))
    (package
      (name "sbcl-cepl.fond")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/cbaggers/cepl.fond")
               (commit commit)))
         (file-name (git-file-name "cepl.fond" version))
         (sha256
          (base32 "1f6abwwa6wpmf70067vwlcgkaaram45ycvdcgbg5yk3hsjypa728"))))
      (build-system asdf-build-system/sbcl)
      (arguments
       (list #:asd-systems
             '(list "cepl.fond" "cepl.fond.example")))
      (inputs
       (list sbcl-cepl
             sbcl-cepl.sdl2
             sbcl-real-rtg-math
             sbcl-cl-fond))
      (home-page "https://github.com/cbaggers/cepl.fond")
      (synopsis "A helper library for using cl-fond with CEPL")
      (description
       "cepl.fond is a simple library for working with cl-fond with CEPL.")
      (license license:bsd-2))))

(define-public sbcl-cepl.sdl2
  (let ((commit "6da5a030db5e3579c5a1c5350b1ffb8fc9950e9a")
        (revision "1"))
    (package
      (name "sbcl-cepl.sdl2")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/cbaggers/cepl.sdl2")
               (commit commit)))
         (file-name (git-file-name "cepl.sdl2" version))
         (sha256
          (base32 "0lz8yxm1g2ch0w779lhrs2xkfciy3iz6viz7cdgyd2824isvinjf"))))
      (build-system asdf-build-system/sbcl)
      (inputs
       (list sbcl-cepl sbcl-sdl2))
      (home-page "https://github.com/cbaggers/cepl.sdl2")
      (synopsis "Package that let's sdl2 host cepl")
      (description
       "Package that let's sdl2 host cepl")
      (license license:bsd-2))))

(define-public sbcl-cepl.glop
  (let ((commit "8ec098010f56dd6e8830ad2041bbea9a949bd9b3")
        (revision "1"))
    (package
      (name "sbcl-cepl.glop")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/cbaggers/cepl.glop")
               (commit commit)))
         (file-name (git-file-name "cepl.glop" version))
         (sha256
          (base32 "1dq727v2s22yna6ycxxs79pg13b0cyh1lfrk6hsb6vizgiks20jw"))))
      (build-system asdf-build-system/sbcl)
      (inputs
       (list sbcl-cepl sbcl-glop))
      (home-page "https://github.com/cbaggers/cepl.glop")
      (synopsis "glop host for cepl.")
      (description
       "This package lets GLOP act as a host for CEPL
What?

CEPL (like GL) relies on other libraries for managing the creation of a GL context, interaction with the Window manager and handling of input sources. The libraries that provide this functionality for CEPL are called hosts.

This is a host for CEPL which uses the GLOP library for creating the context etc.")
      (license license:bsd-2))))

(define-public sbcl-structy-defclass
  (let ((commit "fe2ca1a6fac456fe2f3cee32c47deca80e016edc")
        (revision "1"))
    (package
      (name "sbcl-structy-defclass")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/cbaggers/structy-defclass")
               (commit commit)))
         (file-name (git-file-name "structy-defclass" version))
         (sha256
          (base32 "0fdlj45xzyghmg65dvs7ww7dxji84iid2y6rh9j77aip7v0l5q63"))))
      (build-system asdf-build-system/sbcl)
      (home-page "https://github.com/cbaggers/structy-defclass")
      (synopsis "Make classes like structs.")
      (description
       "Make classes like structs.")
      (license license:bsd-2))))

(define-public sbcl-skitter
  (let ((commit "620772ae6146d510a8d58d07cae055c06e5c8620")
        (revision "1"))
    (package
      (name "sbcl-skitter")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/cbaggers/skitter")
               (commit commit)))
         (file-name (git-file-name "skitter" version))
         (sha256
          (base32 "1rixcav388fnal9v139kvagjfc60sbwd8ikbmd48lppq2nq5anwl"))))
      (build-system asdf-build-system/sbcl)
      (arguments
       `(#:asd-systems
         '("skitter.sdl2" "skitter.glop" "skitter")))
      (inputs
       (list sbcl-structy-defclass sbcl-rtg-math sbcl-alexandria sbcl-glop sbcl-sdl2))
      (home-page "https://github.com/cbaggers/skitter")
      (synopsis "A small event system for games.")
      (description
       "Skitter is a repl friendly event system for games.")
      (license license:bsd-2))))

(define-public sbcl-cepl.skitter.sdl2
  (let ((commit "f52b9240eba6c92d735289b937d2fbf7804d5ed4")
        (revision "1"))
    (package
      (name "sbcl-cepl.skitter.sdl2")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/cbaggers/cepl.skitter")
               (commit commit)))
         (file-name (git-file-name "cepl.skitter" version))
         (sha256
          (base32 "1xz53q8klzrd7cr586jd16pypxgpy68vlvfirqhlv6jc7k99sjvs"))))
      (build-system asdf-build-system/sbcl)
      (arguments
       `(#:asd-systems
         '("cepl.skitter.sdl2")))
      (inputs
       (list sbcl-cepl.sdl2 sbcl-skitter))
      (home-page "https://github.com/cbaggers/cepl.skitter")
      (synopsis "Plumbing to use skitter.sdl2 with cepl.")
      (description
       "Plumbing to use skitter.sdl2 with cepl.

Currently provides only cepl.skitter.sdl2, more systems will be added when more hosts for cepl are added.")
      (license license:bsd-2))))

(define-public sbcl-cl-soil
  (let ((commit "f27087ceb6fa1b6b018e8794755711403ae6e4a3")
        (revision "1"))
    (package
      (name "sbcl-cl-soil")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/cbaggers/cl-soil")
               (commit commit)))
         (file-name (git-file-name "cl-soil" version))
         (sha256
          (base32 "0mnz5yaw3kc14ja9g4j7dxh96kd82ifj25gy0dil7kqjd08lwcq9"))))
      (build-system asdf-build-system/sbcl)
      (inputs
       (list sbcl-cffi sbcl-documentation-utils sbcl-cl-opengl))
      (home-page "https://github.com/cbaggers/cl-soil")
      (synopsis "Common lisp wrapper around the SOIL library.")
      (description
       "Common lisp wrapper around the SOIL library.")
      (license license:bsd-2))))

(define-public sbcl-dirt
  (let ((commit "0d13ebc2e63e7e155d919602139b3f085d575867")
        (revision "1"))
    (package
      (name "sbcl-dirt")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/cbaggers/dirt")
               (commit commit)))
         (file-name (git-file-name "dirt" version))
         (sha256
          (base32 "1lqxfdzn9rh7rzsq97d4hp6fl4g9fs6s0n2pvf460d6ri6p40xna"))))
      (build-system asdf-build-system/sbcl)
      (inputs
       (list sbcl-cepl sbcl-cl-soil))
      (home-page "https://github.com/cbaggers/dirt")
      (synopsis "A front-end for cl-soil which loads images straight to
 cepl:c-arrays and cepl:textures.")
      (description
       "A front-end for cl-soil which loads images straight to cepl:c-arrays and
 cepl:textures.")
      (license license:bsd-2))))

(define-public sbcl-dendrite
  (let ((commit "409b10610ab5b24b28227e57fb0a296746ad116d")
        (revision "1"))
    (package
      (name "sbcl-dendrite")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/cbaggers/dendrite")
               (commit commit)))
         (file-name (git-file-name "dendrite" version))
         (sha256
          (base32 "1fsi77w2yamis2707f1hx09pmyjaxqpzl8s0h182vpz159lkxdy5"))))
      (build-system asdf-build-system/sbcl)
      (inputs
       (list sbcl-rtg-math sbcl-cffi))
      (home-page "https://github.com/cbaggers/dendrite")
      (synopsis "Master package to load all dendrite packages.")
      (description
       "This is the master package that references all dendrite packages

Dendrite will eventually be a collection of procedural generation libraries, for now it's rather empty :)

Each can be loaded on their own or you can load dendrite to load them all.")
      (license license:bsd-2))))

(define-public assimp5.0
  (package
    (inherit assimp)
    (name "assimp")
    (version "5.0.1")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/assimp/assimp")
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "0qwbnw30yw9ddkgdx7f7xx78lsfj6s2nxkb8jp3l73ndaxkcwqkh"))))))

(define-public sbcl-classimp
  (let ((commit "d82a14c59bc733f89a1ea0b3447ebedddce5756e")
        (revision "1"))
    (package
      (name "sbcl-classimp")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/3b/classimp")
               (commit commit)))
         (file-name (git-file-name "classimp" version))
         (sha256
          (base32 "0pbnz6cf1zb2ayk4kbw0gphjb8nflnjns2rwhv86jz0kf0z1hqha"))))
      (build-system asdf-build-system/sbcl)
      (arguments
       (list #:phases
             #~(modify-phases %standard-phases
                 (add-after 'unpack 'fix-paths
                   (lambda* (#:key inputs #:allow-other-keys)
                     (substitute* "library.lisp"
                       (("libassimp.so" all)
                        (string-append
                         #$assimp5.0 "/lib/" all)))
                     #t)))))
      (inputs
       (list sbcl-cffi sbcl-split-sequence assimp5.0))
      (home-page "https://github.com/3b/classimp")
      (synopsis "Common lisp/cffi bindings for Open Asset Import Library.")
      (description
       "common lisp/cffi bindings for Open Asset Import Library (http://assimp.sourceforge.net/)

Should support assimp versions 3.0 to 3.3.x. Version to support is determined by querying c library at compile time (or load if not previously compiled), with errors if versions don't match at load or runtime. (Current assimp from git will be detected as 3.3, but isn't completely binary compatible so might have problems)

Allows (among other things) loading of the following formats:

Collada ( .dae )
Blender 3D ( .blend )
3ds Max 3DS ( .3ds )
3ds Max ASE ( .ase )
Wavefront Object ( .obj )
Industry Foundation Classes (IFC/Step) ( .ifc )
XGL ( .xgl,.zgl )
Stanford Polygon Library ( .ply )
*AutoCAD DXF ( .dxf )
LightWave ( .lwo )
LightWave Scene ( .lws )
Modo ( .lxo )
Stereolithography ( .stl )
DirectX X ( .x )
AC3D ( .ac )
Milkshape 3D ( .ms3d )
* TrueSpace ( .cob,.scn )")
      (license license:expat))))

(define-public sbcl-temporal-functions
  (let ((commit "780d595d43076c7422b34d0b888a6fdfdb72d5a6")
        (revision "1"))
    (package
      (name "sbcl-temporal-functions")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/cbaggers/temporal-functions")
               (commit commit)))
         (file-name (git-file-name "temporal-functions" version))
         (sha256
          (base32 "03cbgw949g68n72nqp0nmjq9nx0kfz5zs6kpk0pwchy3i8bwf22j"))))
      (build-system asdf-build-system/sbcl)
      (inputs
       (list sbcl-fn))
      (home-page "https://github.com/cbaggers/temporal-functions")
      (synopsis "Rewrite of the temporal function code from cepl.")
      (description
       "Temporal-Functions adds tlambda & tdefun along with a small collection of
related funcs and macros. tlambda is a lambda with an internal concept of time.")
      (license license:expat))))

(define-public sbcl-with-setf
  (let ((commit "df3eed9d19249a8559d21d178e1074ad668e5288")
        (revision "1"))
    (package
      (name "sbcl-with-setf")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/cbaggers/with-setf")
               (commit commit)))
         (file-name (git-file-name "with-setf" version))
         (sha256
          (base32 "090v39kdxk4py3axjrjjac2pn1p0109q14hvl818pik479xr4inz"))))
      (build-system asdf-build-system/sbcl)
      (inputs
       (list sbcl-fn))
      (home-page "https://github.com/cbaggers/with-setf")
      (synopsis "Macros for setting a place for the duration of a scope.")
      (description "with-setf provides 2 macros for setf'ing values for the duration of a scope.")
      (license license:expat))))

(define-public sbcl-cl-openal
  (package
    (name "sbcl-cl-openal")
    (version "1.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/zkat/cl-openal")
             (commit "81596fe1898aa6b02be3cf7f592d347f8a981097")))
       (sha256
        (base32 "0jmp81mf23ckcm4knnh0q7zpmyls5220imaqbmnl0xvvra10b1zy"))))
    (build-system asdf-build-system/sbcl)
    (arguments
     (list #:phases
           #~(modify-phases %standard-phases
               (add-after 'unpack 'fix-paths
                 (lambda* (#:key inputs #:allow-other-keys)
                   (for-each
                    (lambda (file)
                      (substitute* file
                        (("libopenal.so" all)
                         (string-append
                          #$openal "/lib/" all))))
                    (list "al/bindings.lisp" "al/al.lisp" "alc/bindings.lisp" "alc/alc.lisp"))
                   (for-each
                    (lambda (file)
                      (substitute* file
                        (("libalut.so" all)
                         (string-append
                          #$freealut "/lib/" all))))
                    (list "alut/bindings.lisp" "alut/alut.lisp"))
                   #t)))
           #:asd-systems
           '(list "cl-openal-examples" "cl-openal" "cl-alc" "cl-alut")))
    (inputs
     (list openal freealut sbcl-alexandria sbcl-cffi))
    (home-page "https://github.com/zkat/cl-openal")
    (synopsis "Semi-lispy public domain bindings to the OpenAL.")
    (description "cl-openal is a series of semi-lispy public domain bindings to the OpenAL
API. It includes direct CFFI bindings, as well as varying levels of lispy
wrappings around AL, ALC, and ALUT.")
    (license license:public-domain)))

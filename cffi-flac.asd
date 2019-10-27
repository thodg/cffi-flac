;;
;;  cffi-flac - libFLAC C bindings
;;  Copyright 2019 Thomas de Grivel <thoxdg@gmail.com> 0614550127
;;

(in-package :common-lisp-user)

(defpackage :cffi-flac.system
  (:use :common-lisp :asdf))

(in-package :cffi-flac.system)

(defsystem "cffi-flac"
  :name "cffi-flac"
  :author "Thomas de Grivel <thoxdg@gmail.com>"
  :version "0.1"
  :description "Common Lisp wrapper for libFLAC C interface"
  :defsystem-depends-on ("cffi-grovel")
  :depends-on ("cffi")
  :components
  ((:file "package")
   (:cffi-grovel-file "grovel-flac" :depends-on ("package"))
   (:file "cffi-flac" :depends-on ("grovel-flac"))))

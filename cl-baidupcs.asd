(defsystem "cl-baidupcs" 
  :version "0.0.0"
  :author "lizqwer scott"
  :license "GPL"
  :depends-on ("uiop"
               ;; json
               "cl-json"
               ;;selenium
               "cl-selenium")
  :components ((:file "package")
               (:file "main" :depends-on ("package")))
  :description "a baidupcs")



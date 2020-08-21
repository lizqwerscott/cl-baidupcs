(in-package :cl-baidupcs)

(defun run-program-m (program parameter &key (input nil) (output nil))
  #+sbcl (sb-ext:run-program (uiop:unix-namestring program) parameter :input input :output output)
  #+clozure (ccl:run-program (uiop:unix-namestring program) parameter :input input :output output))

(defun run-shell (cmd &optional (isDebug-p nil))
  (if isDebug-p 
      (let ((stream1 (make-string-output-stream))) 
        (run-program-m #P"/bin/sh" (list "-c" cmd) :input nil :output stream1)
        (get-output-stream-string stream1))
      (run-program-m #P"/bin/sh" (list "-c" cmd) :input nil :output nil)))

(defun start-server ()
  (run-shell "java -jar ~/quicklisp/local-projects/cl-baidupcs/selenium-server-standalone-3.141.59.jar &"))

(defun stop-server ()
  (run-shell (format nil "kill ~A" (run-shell (format nil "pgrep ~A" "java") t))))

(defun init ()
  (start-server)
  (sleep 5)
  (start-interactive-session)
  (setf (url) "https://pan.baidu.com")
  (format t "Please login the baidu")
  (sleep 10)
  (refresh))

(defun stop ()
  (stop-interactive-session)
  (stop-server))

;;biaozm-plist (:f-path :f-name :all-md5 :slice-md5 :content-length)
(defun save-file (f-path biaozm-str)
  (refresh)
  (let* ((biaozm (split biaozm-str "#")) 
         (new-biaozm (append (list (format nil "~A~A" f-path (car (last biaozm)))) 
                             (remove (car (last biaozm)) biaozm)))) 
    (format t "the convert biaozm:~A, ~A, ~A, ~A" (nth 0 new-biaozm) (nth 1 new-biaozm) (nth 2 new-biaozm) (nth 3 new-biaozm))
    (execute-script "$.ajax({type: \'POST\', url: \"/api/rapidupload\", data: {path: arguments[0], \'content-md5\': arguments[1], \'slice-md5\': arguments[2], \'content-length\': arguments[3]}});"
                  new-biaozm)
    (refresh) (car new-biaozm)))

(defun now-path ())

(defun list-file (path)
  ;TODO
  )

(defun change-path (path))

;retrun a share list
;such as (share-url share-tqm)
(defun create-share-url (f-path &optional (time-l 7))
  ;TODO
  )

;need a share list
;like (share-url share-tqm)
(defun convert-share-url (share-list)
  ;TODO
  )

(defun get-download-url (f-path)
  (convert-share-url (create-share-url f-path)))

(in-package :cl-user)

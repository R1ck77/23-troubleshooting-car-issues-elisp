(require 'cl)
(require 'buttercup)
(setq load-path (cons "." load-path))
(require 'car-troubleshooting-mode)

(defun get-argument (args)
  (first (first args)))

(defun generate-supplier (results)
  (lexical-let ((results results))
    (lambda (&optional ignored)
      (let ((next-result (first results)))
        (setq results (rest results))
        next-result))))

(describe "car-troubleshooting-mode.el"  
  (describe "ctm-read-boolean"
    (it "queries the user with the proper message"
      (spy-on 'read-string :and-return-value "Yes")
      (ctm-read-boolean "message")
      (expect 'read-string :to-have-been-called-with "message"))
    (it "reads yes, y and t as a positive answer (ignoring case)"
      (spy-on 'read-string :and-call-fake (generate-supplier (list "YeS" "Yes" "yes" "y" "Y" "t")))
      (expect (ctm-read-boolean "query text") :to-be t)
      (expect (ctm-read-boolean "query text") :to-be t)
      (expect (ctm-read-boolean "query text") :to-be t)
      (expect (ctm-read-boolean "query text") :to-be t)
      (expect (ctm-read-boolean "query text") :to-be t)
      (expect (ctm-read-boolean "query text") :to-be t))
    (it "reads no, n and nil as a negative answer (ignoring case)"
      (spy-on 'read-string :and-call-fake (generate-supplier (list "nO" "No" "no" "n" "N" "nil")))
      (expect (ctm-read-boolean "query text") :to-be nil)
      (expect (ctm-read-boolean "query text") :to-be nil)
      (expect (ctm-read-boolean "query text") :to-be nil)
      (expect (ctm-read-boolean "query text") :to-be nil)
      (expect (ctm-read-boolean "query text") :to-be nil)
      (expect (ctm-read-boolean "query text") :to-be nil))
    (it "queries the user until a correct answer is received"
      (spy-on 'read-string :and-call-fake (generate-supplier (list "a" "1" "0" "Ye" "Yes")))
      (ctm-read-boolean "message")
      (expect 'read-string :to-have-been-called-times 5)))
  (describe "car-troubleshooting"
    (before-each
      (kill-buffer (get-buffer "* Car Troubleshooting Mode *")))
    (it "creates a buffer with t%he specified name and mode"
      (car-troubleshooting)
      (let ((troubleshooting-buffer (get-buffer "* Car Troubleshooting Mode *")))
        (expect (buffer-live-p troubleshooting-buffer) :to-be t)
        (with-current-buffer troubleshooting-buffer
          (expect major-mode :to-be 'car-troubleshooting-mode))))
    (it "shows the appropriate first question"    
      (car-troubleshooting)
      (expect (buffer-substring (point-min) (point-max))
              :to-equal "Is the car silent when you turn the key?"))
    (it "resets the content of the previous troubleshooting buffer"
      (car-troubleshooting)
      (car-troubleshooting)
      (expect (buffer-substring (point-min) (point-max))
              :to-equal "Is the car silent when you turn the key?"))
    (it "displays the buffer with the troubleshooting"      
      (spy-on 'display-buffer)
      (car-troubleshooting)
      (let ((buffer (get-argument (spy-calls-all-args 'display-buffer))))
        (with-current-buffer buffer
          (expect major-mode :to-be 'car-troubleshooting-mode))))
    ))

(require 'cl)
(require 'buttercup)
(setq load-path (cons "." load-path))
(require 'car-troubleshooting-mode)

(defun get-argument (args)
  (first (first args)))

;;; TODO/FIXME duplicated code
(defun generate-supplier (results)
  (lexical-let ((results results))
    (lambda (&optional ignored)
      (let ((next-result (first results)))
        (setq results (rest results))
        next-result))))

(describe "car-troubleshooting-mode.el"  
  (describe "car-troubleshooting"
    (before-each
      (kill-buffer (get-buffer "* Car Troubleshooting Mode *")))
    (it "creates a buffer with t%he specified name and mode"
      (spy-on'ctm-read-boolean)
      (car-troubleshooting)
      (let ((troubleshooting-buffer (get-buffer "* Car Troubleshooting Mode *")))
        (expect (buffer-live-p troubleshooting-buffer) :to-be t)
        (with-current-buffer troubleshooting-buffer
          (expect major-mode :to-be 'car-troubleshooting-mode))))
    (xit "shows the appropriate first question"   ; TODO/FIXME can this test be refactored?
      (spy-on'ctm-read-boolean)
      (car-troubleshooting)
      (expect (buffer-substring (point-min) (point-max))
              :to-equal "Is the car silent when you turn the key? "))
    (xit "resets the content of the previous troubleshooting buffer" ; TODO/FIXME same…
      (spy-on'ctm-read-boolean)
      (car-troubleshooting)
      (car-troubleshooting)
      (expect (buffer-substring (point-min) (point-max))
              :to-equal "Is the car silent when you turn the key? "))
    (it "displays the buffer with the troubleshooting"      
      (spy-on'ctm-read-boolean)
      (car-troubleshooting)
      (expect major-mode :to-be 'car-troubleshooting-mode))
    (it "follows the correct path of results"
      (spy-on 'ctm-read-boolean :and-call-fake (generate-supplier '(nil nil t)))
      (car-troubleshooting)
      (expect (buffer-substring (point-min) (point-max))
              :to-equal "Is the car silent when you turn the key? No
Does the car make a clicking noise? No
Does the car crank up but fail to start? Yes
PROPOSED SOLUTION:
Check spark plug connections."))))

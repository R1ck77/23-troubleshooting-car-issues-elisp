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
      (car-troubleshooting)
      (expect major-mode :to-be 'car-troubleshooting-mode))))

(require 'cl)
(require 'buttercup)
(setq load-path (cons "." load-path))
(require 'car-troubleshooting-mode)

(defun get-argument (args)
  (first (first args)))

(describe "car-troubleshooting-mode.el"
  (before-each
    (kill-buffer (get-buffer "* Car Troubleshooting Mode *")))
  (describe "car-troubleshooting"
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
    (xit "resets the content of the previous troubleshooting buffer"
      (car-troubleshooting)
      (car-troubleshooting)
      (expect (buffer-substring (point-min) (point-max))
              :to-equal "Is the car silent when you turn the key?"))
    (xit "displays the buffer with the troubleshooting"
      
      (spy-on 'display-buffer)
      (car-troubleshooting)
      (let ((buffer (get-argument (spy-calls-all-args 'display-buffer))))
        (with-current-buffer buffer
          (expect major-mode :to-be 'car-troubleshooting-mode))))))

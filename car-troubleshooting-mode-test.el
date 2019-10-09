(require 'buttercup)
(setq load-path (cons "." load-path))
(require 'car-troubleshooting-mode)

(describe "car-troubleshooting-mode.el"
  (before-each
    (kill-buffer (get-buffer "* Car Troubleshooting Mode *")))
  (describe "car-troubleshooting"
    (it "creates a buffer with the specified name and mode"
      (car-troubleshooting-mode)
      (let ((troubleshooting-buffer (get-buffer "* Car Troubleshooting Mode *")))
        (expect (buffer-live-p troubleshooting-buffer :to-be t))
        (with-current-buffer Troubleshooting-buffer
          (expect major-mode :to-be 'car-troubleshooting-mode))))
    (it "shows the appropriate first question"    
      (car-troubleshooting-mode)
      (expect (buffer-substring (point-min) (point-max))
              :to-equal "Is the car silent when you turn the key?"))
    (it "resets the content of the previous troubleshooting buffer"
      (car-troubleshooting-mode)
      (car-troubleshooting-mode)
      (expect (buffer-substring (point-min) (point-max))
              :to-equal "Is the car silent when you turn the key?"))))

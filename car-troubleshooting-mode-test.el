(require 'cl)
(require 'buttercup)
(setq load-path (cons "." load-path))
(require 'test-utils)
(require 'car-troubleshooting-mode)

(defun get-argument (args)
  (first (first args)))

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
Check spark plug connections."))
    (it "bail with class when it doesn't have answers"
      (spy-on 'ctm-read-boolean :and-call-fake (generate-supplier '(nil nil nil nil nil)))
      (car-troubleshooting)
      (expect (buffer-substring (point-min) (point-max))
              :to-equal "Is the car silent when you turn the key? No
Does the car make a clicking noise? No
Does the car crank up but fail to start? No
Does the engine start and then die? No
PROPOSED SOLUTION:
Close the computer and go see a real mechanic, doofus!"))
    (it "handles poor user input like a pro"
      (spy-on 'read-string :and-call-fake (generate-supplier '("foo" "bar" "YeS" "Baz" "22" "nope" "nO")))
      (car-troubleshooting)
      (expect (buffer-substring (point-min) (point-max))
              :to-equal "Is the car silent when you turn the key? Yes
Are the battery terminals corroded? No
PROPOSED SOLUTION:
Replace cables and try again."))
    (it "works correctly if another buffer with the same name is present"
        (with-current-buffer (get-buffer-create "* Car Troubleshooting Mode *")
          (insert "**** Text That I Wouldn't Want To See ****")
          (setq buffer-read-only t))
      (spy-on 'ctm-read-boolean :and-call-fake (generate-supplier '(nil nil t)))
      (car-troubleshooting)
      (expect (buffer-substring (point-min) (point-max))
              :to-equal "Is the car silent when you turn the key? No
Does the car make a clicking noise? No
Does the car crank up but fail to start? Yes
PROPOSED SOLUTION:
Check spark plug connections."))))

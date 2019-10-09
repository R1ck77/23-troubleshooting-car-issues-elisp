(defconst car-troubleshooting-mode-buffer-name "* Car Troubleshooting Mode *")

(defvar car-troubleshooting-mode nil
  "Mode variable for \"Car Troubleshooting Mode\"")

(defun ctm--setup ()
  )

(defun ctm--car-troubleshooting-mode ()
  "Creates a buffer and set it to Car Troubleshooting Mode"
  (interactive)
  (ctm--setup))

(defun car-troubleshooting ()
  (get-buffer-create  car-troubleshooting-mode-buffer-name))

(provide 'car-troubleshooting-mode)

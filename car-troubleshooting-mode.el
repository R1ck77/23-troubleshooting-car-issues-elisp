(setq load-path (cons "." load-path))
(require 'car-troubleshooting-data)

(defconst car-troubleshooting-mode-buffer-name "* Car Troubleshooting Mode *")
(defconst car-troubleshooting-mode-name "Car Troubleshooting")

(defvar car-troubleshooting-mode nil
  "Mode variable for \"Car Troubleshooting Mode\"")

(defun ctm--setup ()
  (erase-buffer)
  (insert (first ctd-list)))

(defun ctm--car-troubleshooting-mode ()
  "Creates a buffer and set it to Car Troubleshooting Mode"
  (kill-all-local-variables)
  (setq major-mode 'car-troubleshooting-mode)
  (setq mode-name car-troubleshooting-mode-name)
  (ctm--setup))

(defun car-troubleshooting ()
  (interactive)
  (let ((buffer (get-buffer-create car-troubleshooting-mode-buffer-name)))
    (display-buffer buffer)
    (set-buffer buffer)
    (ctm--car-troubleshooting-mode)))

(provide 'car-troubleshooting-mode)

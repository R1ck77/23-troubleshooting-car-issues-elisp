(require 'seq)
(setq load-path (cons "." load-path))
(require 'car-troubleshooting-data)

(defconst car-troubleshooting-mode-buffer-name "* Car Troubleshooting Mode *")
(defconst car-troubleshooting-mode-name "Car Troubleshooting")

(defvar car-troubleshooting-mode nil
  "Mode variable for \"Car Troubleshooting Mode\"")

;;; TODO/FIXME belongs to another source. Also the downcase part is messy and not Open/Close
(defconst ctm-read-boolean-positive (list "yes" "y" "t"))
(defconst ctm-read-boolean-negative (list "no" "n" "nil"))
(defun ctm--read-valid-input (message valid-values)
  (let* ((valid-values (mapcar 'downcase valid-values))
         (result (downcase (read-string message))))
    (if (seq-contains valid-values result)
        result
      (ctm--read-valid-input message valid-values))))

(defun ctm-read-boolean (message)
  ; TODO/FIXME depends on the ctm--read-valid-input to deal with lowercase values… not good
  (seq-contains ctm-read-boolean-positive
                (ctm--read-valid-input message (append ctm-read-boolean-positive
                                                       ctm-read-boolean-negative))))
;;;;;

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

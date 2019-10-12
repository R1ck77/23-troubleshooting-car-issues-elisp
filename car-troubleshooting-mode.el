(require 'cl)
(setq load-path (cons "." load-path))
(require 'car-troubleshooting-data)
(require 'ctm-read)

(defconst car-troubleshooting-mode-buffer-name "* Car Troubleshooting Mode *")
(defconst car-troubleshooting-mode-name "Car Troubleshooting")
(defconst car-troubleshooting-yes "Yes")
(defconst car-troubleshooting-no "No")

(defvar car-troubleshooting-mode nil
  "Mode variable for \"Car Troubleshooting Mode\"")

(defun ctm--format-boolean (boolean)
  (if boolean
      car-troubleshooting-yes
    car-troubleshooting-no))

(defun ctm--write-solution (data)
  (insert
   (format "PROPOSED SOLUTION:\n%s" data)))

(defun ctm--procedure (procedure)
  (let ((question (concat (first procedure) " "))
        (answer (rest procedure)))
    (insert question)
    (let ((user-answer (ctm-read-boolean question)))
      (insert (ctm--format-boolean user-answer))
      (insert "\n")
      (let ((next (if user-answer
                      (first answer)
                    (second answer))))
        (if (stringp next)
            (ctm--write-solution next)
          (if next
              (ctm--procedure next)
            (ctm--write-solution "Close the computer and go see a real mechanic, doofus!")))))))

(defun ctm--setup ()
  (erase-buffer)
  (ctm--procedure car-troubleshooting-data))

(defun ctm--car-troubleshooting-mode ()
  "Creates a buffer and set it to Car Troubleshooting Mode"
  (kill-all-local-variables)
  (setq major-mode 'car-troubleshooting-mode)
  (setq mode-name car-troubleshooting-mode-name)
  (ctm--setup))

(defun ctm--get-new-buffer ()
  (let ((previous-buffer (get-buffer car-troubleshooting-mode-buffer-name)))
    (when previous-buffer
      (kill-buffer previous-buffer)))
  (get-buffer-create car-troubleshooting-mode-buffer-name))

(defun car-troubleshooting ()
  (interactive)
  (let ((buffer (ctm--get-new-buffer)))
    (switch-to-buffer buffer)
    (ctm--car-troubleshooting-mode)))

(provide 'car-troubleshooting-mode)

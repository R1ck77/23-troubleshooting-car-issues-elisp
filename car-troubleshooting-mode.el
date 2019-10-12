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

(defun ctm--decide-step (answers user-answer)
  (let ((next-step answers))
    (insert (ctm--format-boolean user-answer))
    (insert "\n")
    (ctm--procedure (if user-answer
                        (first next-step)
                      (second next-step)))))

(defun ctm--ask-question (question-text)
  (let ((question (concat question-text " ")))
    (insert question)
    (ctm-read-boolean question)))

(defun ctm--next-question (procedure)
  (ctm--decide-step (rest procedure)
                    (ctm--ask-question (first procedure))))

(defun ctm--write-solution (data)
  (insert
   (format "PROPOSED SOLUTION:\n%s" data)))

(defun ctm--procedure (procedure)
  (cond
   ((stringp procedure) (ctm--write-solution procedure))
   ((null procedure) (ctm--write-solution "Close the computer and go see a real mechanic, doofus!"))
   (:otherwise (ctm--next-question procedure))))

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

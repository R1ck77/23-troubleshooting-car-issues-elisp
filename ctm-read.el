(require 'seq)


(defconst ctm-read-boolean-positive (list "yes" "y" "t"))
(defconst ctm-read-boolean-negative (list "no" "n" "nil"))

(defun ctm--read-valid-input (message validator-function)
  (let ((result (read-string message)))
        (if (funcall validator-function result)
        result
        (ctm--read-valid-input message validator-function))))

(defun ctm--answer-in-setp (possible-answers answer)
  (let ((lowcase-answer (downcase answer)))
    (seq-contains possible-answers lowcase-answer)))

(defun ctm--is-positivep (answer)
  (ctm--answer-in-setp ctm-read-boolean-positive answer))

(defun ctm--is-negativep (answer)
  (ctm--answer-in-setp ctm-read-boolean-negative answer))

(defun ctm--validator (answer)
  (or (ctm--is-positivep answer)
      (ctm--is-negativep answer)))

(defun ctm-read-boolean (message)
  (ctm--is-positivep
   (ctm--read-valid-input message 'ctm--validator)))

(provide 'ctm-read)

(require 'seq)

;;; TODO/FIXME Also the downcase part is messy and not Open/Close
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

(provide 'ctm-read)

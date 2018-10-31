
(ql:quickload :fare-csv)
(setf fare-csv:*separator* #\Tab)

(defun read-file (file)
  (with-open-file (in file :external-format :utf-8) 
    (loop for x = (read-line in nil nil)
	  while x
	  when (> (length x) 0)
	  collect (string-trim '(#\Space #\Tab) x))))

(defparameter wiki   (read-file "ptwiki-20180622-all-titles-in-ns-0"))
(defparameter vp     (read-file "mwes_proposed.txt"))
(defparameter ar     (fare-csv:read-csv-file "antconc-AR.txt"))
(defparameter antc   (subseq (fare-csv:read-csv-file "antconc_results-0.txt") 2))


(print (length (intersection mwes titles :test #'string-equal)))
;; 212

(print (length (set-difference mwes titles :test #'string-equal)))
;; 218



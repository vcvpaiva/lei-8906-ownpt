
(ql:quickload :fare-csv)
(setf fare-csv:*separator* #\Tab)

(defun read-file (file)
  (with-open-file (in file :external-format :utf-8) 
    (loop for x = (read-line in nil nil)
	  while x
	  when (> (length x) 0)
	  collect (string-trim '(#\Space #\Tab) x))))

(defparameter titles (read-file "ptwiki-20180622-all-titles-in-ns-0"))
(defparameter mwes (union (read-file "mwes_proposed.txt")
			  (mapcar (lambda (s) (nth 3 s))
				  (fare-csv:read-csv-file "/Users/ar/work/lei-8906-ownpt/mwe/antconc-AR.txt"))
			  :test #'string-equal))

(print (length (intersection mwes titles :test #'string-equal)))
;; 212

(print (length (set-difference mwes titles :test #'string-equal)))
;; 218



;; A cool gist followed by some help from stackoverflow
;; https://gist.github.com/1683375
;; http://stackoverflow.com/questions/9184243/how-do-i-list-non-ecb-windows-in-emacs
(defun non-ecb-window-list ()
  (remove-if
   #'(lambda (window)
       (find (window-buffer window) (ecb-dedicated-special-buffers)))
   (window-list)))
(defun count-non-ecb-windows ()
  (length (non-ecb-window-list)))
(defun swap-windows ()
  "If you have 2 windows, it swaps them."
  (interactive)
  (cond ((not (= (count-non-ecb-windows) 2))
	 (message "You need exactly 2 windows to do this."))
	(t
	 (let* ((w1 (first (non-ecb-window-list)))
		(w2 (second (non-ecb-window-list)))
		(b1 (window-buffer w1))
		(b2 (window-buffer w2))
		(s1 (window-start w1))
		(s2 (window-start w2)))
	   (set-window-buffer w1 b2)
	   (set-window-buffer w2 b1)
	   (set-window-start w1 s2)
	   (set-window-start w2 s1)))))


;; Not sure how it is that I grabbed this from the source, but
;; didn't already have it...
;; http://repo.or.cz/w/emacs.git/blob/HEAD:/lisp/misc.el
(defun zap-up-to-char (arg char)
  "Kill up to, but not including ARGth occurrence of CHAR.
 Case is ignored if `case-fold-search' is non-nil in the current buffer.
 Goes backward if ARG is negative; error if CHAR not found.
 Ignores CHAR at point."
  (interactive "p\ncZap up to char: ")
  (let ((direction (if (>= arg 0) 1 -1)))
    (kill-region (point)
		 (progn
		   (forward-char direction)
		   (unwind-protect
		       (search-forward (char-to-string char) nil nil arg)
		     (backward-char direction))
		   (point)))))

;; (defun jds-find-tags-file ()
;;   "recursively searches each parent directory for a file named 'TAGS' and returns the
;; path to that file or nil if a tags file is not found. Returns nil if the buffer is
;; not visiting a file"
;;   (progn
;;     (defun find-tags-file-r (path)
;;       "find the tags file from the parent directories"
;;       (let* ((parent (file-name-directory path))
;; 	     (possible-tags-file (concat parent "TAGS")))
;; 	(cond
;; 	 ((file-exists-p possible-tags-file) (throw 'found-it possible-tags-file))
;; 	 ((string= "/TAGS" possible-tags-file) (error "no tags file found"))
;; 	 (t (find-tags-file-r (directory-file-name parent))))))
;; 
;;     (if (buffer-file-name)
;;         (catch 'found-it 
;;           (find-tags-file-r (buffer-file-name)))
;;       (error "buffer is not visiting a file"))))
;; 
;; (defun jds-set-tags-file-path ()
;;   "calls `jds-find-tags-file' to recursively search up the directory tree to find
;; a file named 'TAGS'. If found, set 'tags-table-list' with that path as an argument
;; otherwise raises an error."
;;   (interactive)
;;   (setq tags-table-list (cons (jds-find-tags-file) tags-table-list)))
;; 
;; ;; delay search the TAGS file after open the source file
;; (add-hook 'emacs-startup-hook 
;; 	  '(lambda () (jds-set-tags-file-path)))

(setq path-to-ctags "/usr/local/Cellar/ctags/5.8/bin/ctags") ;; <- your ctags path here
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "%s -f %s/TAGS -e -R %s" path-to-ctags dir-name (directory-file-name dir-name)))
  )


;; http://codereview.stackexchange.com/q/45/5601
(defun ckhrysze-find-parent-tags (dir)
  "Traverses the directory tree up to /home/[user]/ or / whichever comes first. 
   Returns either nil or the directory containing the first TAGS file it finds."
  (interactive (list default-directory))
  (ckhrysze-find-parent-tags-rec (ckhrysze-build-tag-paths dir)))
(defun ckhrysze-find-parent-tags-rec (list-of-filepath)
  (cond ((null list-of-filepath) nil)
        ((file-exists-p (car list-of-filepath)) (car list-of-filepath))
        (t (ckhrysze-find-parent-tags-rec (cdr list-of-filepath)))))
(defun ckhrysze-build-tag-paths (dir-string)
  (ckhrysze-build-tag-paths-rec (remove-if #'ckhrysze-empty-string? (split-string dir-string "/")) (list "/")))
(defun ckhrysze-build-tag-paths-rec (steps acc)
  (if (null steps) 
      (mapcar (lambda (p) (concat p "TAGS")) acc)
    (ckhrysze-build-tag-paths-rec (cdr steps)
			 (cons (concat (car acc) (car steps) "/") acc))))

(defun ckhrysze-empty-string? (s) (equalp s ""))



;; http://emacs-journey.blogspot.com/2009/08/lets-tag-and-load.html
;; (setq tags-directory "/path/to/tags/")
;; (setq tag-list 
;;       (list
;;        (cons '"/path/to/project1" (concat tags-directory "tags1"))
;;        (cons '"/path/to/project2" (concat tags-directory "tags2"))))
;; 
;; (defun load-tags ()
;;   (interactive)
;;   (if (buffer-file-name)
;;       (progn
;;         (dolist (tag-cons tag-list)
;;           (if (string-match (regexp-quote (car tag-cons)) (buffer-file-name))
;;               (progn
;;                 (if (not (equal tags-file-name (cdr tag-cons)))
;; 		    (progn
;; 		      (message (concat "loading tags" (cdr tag-cons)))
;; 		      (setq tags-file-name nil)
;; 		      (setq tags-table-list nil)
;; 		      (visit-tags-table (cdr tag-cons))))))))))
;; 
;; (defun switch-to-buffer-and-load-tags ()
;;   (interactive)
;;   (ido-switch-buffer)
;;   (load-tags))
;; 
;; (add-hook 'find-file-hook 'load-tags)

;; http://www.emacswiki.org/emacs/InteractivelyDoThings
(defun ido-find-file-in-tag-files ()
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t))
      (visit-tags-table-buffer))
    (find-file
     (expand-file-name
      (ido-completing-read
       "Project file: " (tags-table-files) nil t)))))

(defun find-next-tag ()
  (interactive)
  (find-tag "" t))

(defun increment-number-at-point ()
  (interactive)
  (skip-chars-backward "0123456789")
  (or (looking-at "[0123456789]+")
      (error "No number at point"))
  (replace-match (number-to-string (+ (string-to-number (match-string 0)) 1 ))))

(defun decrement-number-at-point ()
  (interactive)
  (skip-chars-backward "0123456789")
  (or (looking-at "[0123456789]+")
      (error "No number at point"))
  (replace-match (number-to-string (- (string-to-number (match-string 0)) 1 ))))

;;  move the current line by n lines
(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (let ((col (current-column))
	start
	end)
    (beginning-of-line)
    (setq start (point))
    (end-of-line)
    (forward-char)
    (setq end (point))
    (let ((line-text (delete-and-extract-region start end)))
      (forward-line n)
      (insert line-text)
      ;; restore point to original column in moved line
      (forward-line -1)
      (forward-char col))))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

;;  copy the current line
(defun duplicate-line (n)
  "Copy the current line up or down by N lines."
  (interactive "p")
  (let ((col (current-column))
	start
	end)
    (beginning-of-line)
    (setq start (point))
    (end-of-line)
    (forward-char)
    (setq end (point))
    (let ((line-text (delete-and-extract-region start end)))
      (insert line-text)
      (forward-line -1)
      (insert line-text)
      (if (equal -1 n)
	  (forward-line -1))
      (forward-char col)
      )))

(defun duplicate-line-up (n)
  "Copy the current line up by a line."
  (interactive "p")
  (duplicate-line (if (null n) -1 (- n))))

(defun duplicate-line-down (n)
  "Copy the current line down by a line."
  (interactive "p")
  (duplicate-line (if (null n) 0 n)))

(provide 'misc_functions)

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
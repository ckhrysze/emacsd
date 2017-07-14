;; https://emacs.stackexchange.com/questions/169/how-do-i-reload-a-file-in-a-buffer
;; Source: http://www.emacswiki.org/emacs-en/download/misc-cmds.el
(defun revert-buffer-no-confirm ()
    "Revert buffer without confirmation."
    (interactive)
    (revert-buffer t (not (buffer-modified-p))))

;; http://stackoverflow.com/questions/2416655/file-path-to-clipboard-in-emacs
(defun copy-file-name-to-clipboard ()
  "Put the current file name on the clipboard"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (let ((x-select-enable-clipboard t)) (kill-new filename))
      )))

;;; https://www.emacswiki.org/emacs/ToggleWindowSplit
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

;; A cool gist followed by some help from stackoverflow
;; https://gist.github.com/1683375
(defun swap-windows ()
  "If you have 2 windows, it swaps them."
  (interactive)
  (cond ((not (= (count-windows) 2))
         (message "You need exactly 2 windows to do this."))
        (t
         (let* ((w1 (car (window-list)))
                (w2 (cadr (window-list)))
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


(defun date ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

(defun ckhrysze-web-mode-hook ()
  "Hooks for Web mode"
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent--offset 2)
  (setq web-mode-code-indent-offset 2)
  )

(defun insert-elixir-pipe ()
  (interactive)
  (insert "|> ")
  )

(defun elixir-newline-pipe ()
  (interactive)
  (newline-and-indent)
  (insert-elixir-pipe)
  )

(defun ckhrysze-javascript-mode-hook ()
  (setq js-indent-level 2)
  )

(defun ckhrysze-elixir-mode-hook ()
  "Hooks for extra keybindings in elixir mode"
  (local-set-key (kbd "C->") 'insert-elixir-pipe)
  (local-set-key (kbd "C-;") 'insert-elixir-pipe)
  (local-set-key (kbd "C-<return>") 'elixir-newline-pipe)
  (company-mode 1)
  (smartparens-mode 1)
  (add-hook 'before-save-hook
            (lambda ()
              (untabify (point-min) (point-max))))
  )

(defun ckhrysze-python-mode-hook ()
  (electric-pair-mode 1)
  ;(pyvenv-activate venv-name)
  ;(setq flycheck-checker pychecker)
  )

(defun run-local-vars-mode-hook ()
  "Run a hook for the major-mode after the local variables have been processed."
  (run-hooks (intern (concat (symbol-name major-mode) "-local-vars-hook"))))

;;; ask to create directories when appropriate on buffer creation
(defun my-create-non-existent-directory ()
  (let ((parent-directory (file-name-directory buffer-file-name)))
    (when (and (not (file-exists-p parent-directory))
               (y-or-n-p (format "Directory `%s' does not exist! Create it?" parent-directory)))
      (make-directory parent-directory t))))
(add-to-list 'find-file-not-found-functions #'my-create-non-existent-directory)
;;;

;;; Line movement functions
;;; I really liked these in my java ide days
;;; (netbeans? eclipse? both? not sure)

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

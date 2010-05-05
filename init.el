;;; if something goes wrong, I want to know about it
(setq debug-on-error t)

;;; add to the load path
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;; (add-to-list 'load-path (expand-file-name "~/elisp/snippets"))
;; (add-to-list 'load-path (expand-file-name "~/elisp/icicles"))
;; (add-to-list 'load-path (expand-file-name "~/elisp/cucumber.el"))
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/.emacs.d/")
	   (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))

;;; don't really need a tool bar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(scroll-bar-mode -1)

;;; global key settings
(global-set-key [f1] 'goto-line)
(global-set-key [f4] 'call-last-kbd-macro)
(global-set-key [f5] 'revert-buffer)
(global-set-key [f9] 'ecb-goto-window-directories)
(global-set-key [f10] 'ecb-goto-window-sources)
(global-set-key [f11] 'ecb-goto-window-methods)
(global-set-key [f12] 'ecb-goto-window-edit1)
(global-set-key "\C-z" 'undo)
(global-set-key (kbd "C-<slash>") 'comment-or-uncomment-region)
(global-set-key "\C-c\C-c" 'comment-or-uncomment-region)

(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-y" 'clipboard-yank)
(global-set-key "\C-v" 'clipboard-yank)

;;; bindings to custom functions
(global-set-key (kbd "C-M-<up>") 'duplicate-line-up)
(global-set-key (kbd "C-M-<down>") 'duplicate-line-down)
(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

;;; global settings
(setq inhibit-startup-message t)
(global-font-lock-mode t)
(show-paren-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq font-lock-maximum-decoration t)
(setq save-abbrevs t)
(delete-selection-mode 1)
(column-number-mode 1)

;; more typical line numbers
(global-linum-mode 1)

;; some window numbering
(add-to-list 'load-path "/path/to/window-numbering")
(require 'window-numbering)
(window-numbering-mode 1)

(require 'smooth-scrolling)

(require 'bar-cursor)
(bar-cursor-mode 1)

(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))


;;; messing with colors
;; see http://www.gnu.org/software/emacs/manual/html_node/emacs/Standard-Faces.html
(set-face-background 'modeline          "#ccccff")
(set-face-background 'modeline-inactive "#cccccc")
(set-face-background 'fringe "#fcfcfc")



;;; as per http://www.emacswiki.org/emacs/SmoothScrolling try to make mouse scrolling sane
;; scroll one line at a time (less “jumpy” than defaults)
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil) ;; don’t accelerate scrolling
(setq mouse-wheel-follow-mouse t) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

; for xml files, use nxml-mode instead of sgml-mode
(add-to-list 'auto-mode-alist '("\\.xml\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.html.erb\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.xml.erb\\'" . nxml-mode))

;These lines are required for ECB
(setq semantic-load-turn-everything-on t)
(require 'semantic-load)

;;; Backup files in one spot
(setq backup-directory-alist nil)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/eback"))
            backup-directory-alist))


; This installs ecb - it is activated with M-x ecb-activate
(require 'ecb-autoloads)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-layout-name "left13")
 '(ecb-options-version "2.32")
 '(ecb-show-sources-in-directories-buffer (quote ("left7" "left13" "left14" "left15")))
 '(ecb-source-path (quote (("/home/ckhrysze/code/blc/likeassets/rails" "mp_rails") ("/home/ckhrysze/code/blc/likeassets/flex" "mp_flex") ("/home/ckhrysze/code/magic/deckapp" "magic") ("/home/ckhrysze/code/don/game" "drcgame"))))
 '(ecb-tip-of-the-day nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; Yegge's js mode
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; sass-mode
(require 'sass-mode)
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))

; when to use ruby mode
(setq auto-mode-alist  (cons '(".rb$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '(".rake$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '("Rakefile$" . ruby-mode) auto-mode-alist))


;;; actionscript
(require 'actionscript-mode)
(add-to-list 'auto-mode-alist '("\\.as$" . actionscript-mode))



;;;
;;; custom methods
;;;

;   move the current line by n lines
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

;   copy the current line
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

;;; Taken from http://www.emacswiki.org/emacs/AutoIndentation#SmartPaste

(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
	   (and (not current-prefix-arg)
		(member major-mode '(emacs-lisp-mode lisp-mode
						     clojure-mode    scheme-mode
						     haskell-mode    ruby-mode
						     rspec-mode      python-mode
						     c-mode          c++-mode
						     objc-mode       latex-mode
						     plain-tex-mode))
		(let ((mark-even-if-inactive transient-mark-mode))
		  (indent-region (region-beginning) (region-end) nil))))))

(defadvice kill-line (before check-position activate)
  (if (and (eolp) (not (bolp)))
      (progn (forward-char 1)
	     (just-one-space 0)
	     (backward-char 1))))

;;; Taken from http://www.emacswiki.org/emacs/OpenNextLine

;; Behave like vi's o command
(defun open-next-line (arg)
  "Move to the next line and then opens a line.
    See also `newline-and-indent'."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (next-line 1)
  (when newline-and-indent
    (indent-according-to-mode)))

;; Behave like vi's O command
(defun open-previous-line (arg)
  "Open a new line before the current one. 
     See also `newline-and-indent'."
  (interactive "p")
  (beginning-of-line)
  (open-line arg)
  (when newline-and-indent
    (indent-according-to-mode)))

;; Autoindent open-*-lines
(defvar newline-and-indent t
  "Modify the behavior of the open-*-line functions to cause them to autoindent.")

(global-set-key [S-return]   'open-next-line)
(global-set-key [C-S-return] 'open-previous-line)


;; http://www.emacswiki.org/emacs/SlickCopy
(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position)
	   (line-beginning-position 2)))))
 
(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
	   (line-beginning-position 2)))))

(require 'icicles)
(icy-mode 1)

;;; Notes
; auto increment magic (thank yegge!)
; M-x replace-regexp
;   Replace regexp: \(.+:\)
;   Replace regexp with \#.
;


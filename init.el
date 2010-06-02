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
(global-set-key (kbd "C-;") 'rails/goto)
(global-set-key "\C-t" 'rails/resources/toggle-test)

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

(pymacs-load "pymdev" "pymdev-")

(require 'filesets+)
(filesets-init) ; Enable filesets

(autoload 'mode-compile "mode-compile"
  "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
  "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)


;; more typical line numbers
(global-linum-mode 1)

(eval-after-load "icomplete" '(progn (require 'icomplete+)))


;; some window numbering
(add-to-list 'load-path "/path/to/window-numbering")
(require 'window-numbering)
(window-numbering-mode 1)

(require 'smooth-scrolling)

(require 'bar-cursor)
(bar-cursor-mode 1)

(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

(require 'compile)
;; (require 'rspec-mode)

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
(add-to-list 'auto-mode-alist '("\\.xml$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.erb$" . nxml-mode))

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

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)


;; Yegge's js mode
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;;; actionscript
(require 'actionscript-mode)
(add-to-list 'auto-mode-alist '("\\.as$" . actionscript-mode))



;;; For rails development
(require 'rails-autoload)

;; (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))

;; yaml mode from http://tweedle-dee.org/svn/emacs.d/site-lisp/yaml-mode.el
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; sass-mode
;; (require 'sass-mode)
;; (add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))



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

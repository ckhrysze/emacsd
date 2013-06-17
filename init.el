;;; if something goes wrong, I want to know about it
(setq debug-on-error t)
(setq stack-trace-on-error 1)

;;; add to the load path
(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (let* ((my-lisp-dir "~/.emacs.d/")
	   (default-directory my-lisp-dir))
      (setq load-path (cons my-lisp-dir load-path))
      (normal-top-level-add-subdirs-to-load-path)))

;;; don't really need a tool bar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(scroll-bar-mode -1)

(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
			 ("gnu" . "http://elpa.gnu.org/packages/")))

(require 'solarized-definitions)

;;; setup yasnippets
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(yas-global-mode 1)

;;; global key settings
(global-set-key [f1] 'goto-line)
(global-set-key [f2] 'server-edit)
(global-set-key [f4] 'call-last-kbd-macro)
(global-set-key [f5] 'revert-buffer)
(global-set-key "\C-z" 'undo)
(global-set-key [(ctrl /)] 'comment-or-uncomment-region)
(global-set-key "\C-c\C-c" 'keyboard-escape-quit)
(global-set-key "\C-c\C-f" 'ido-find-file-in-tag-files)
(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-y" 'clipboard-yank)
(global-set-key "\C-v" 'clipboard-yank)
;; (global-set-key (kbd "C-;") 'rails/goto)
;; (global-set-key "\C-t" 'rails/resources/toggle-test)
(global-set-key (kbd "C-t") 'ruby-test-toggle-implementation-and-specification)
(global-set-key "\M-z" 'zap-up-to-char)
(global-set-key "\C-x\C-b" 'buffer-menu) ;; so the buffer list appears in the current window
(global-set-key (kbd "M-t") 'helm-mini)

;;; bindings to custom functions
(global-set-key (kbd "C-M-<up>") 'duplicate-line-up)
(global-set-key (kbd "C-M-<down>") 'duplicate-line-down)
(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)
(global-set-key (kbd "C-+") 'increment-number-at-point)
(global-set-key (kbd "C--") 'decrement-number-at-point)
(global-set-key (kbd "C-.") 'find-next-tag)

;;; global settings
(setq inhibit-startup-message t)
(global-font-lock-mode t)
(show-paren-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq font-lock-maximum-decoration t)
(setq save-abbrevs t)
;; (delete-selection-mode 1)
(column-number-mode 1)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(setq exec-path (append exec-path '("/usr/local/bin")))
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

(setq mac-command-modifier 'meta)

(require 'misc_functions)


(require 'autopair)
;; (autopair-global-mode) ;; enable autopair in all buffers
(add-hook 'ruby-mode-hook (lambda () (autopair-mode t)))
(require 'ruby-electric)
(add-hook 'ruby-mode-hook (lambda () (ruby-electric-mode t)))

(setq ruby-deep-indent-paren nil)
(setq ruby-deep-indent-paren-style nil)
(setq ruby-deep-arglist nil)

'(require 'ruby-mode-indent-fix)

(autoload 'gtags-mode "gtags" "" t)
(require 'gtags)


(load "~/.emacs.d/nxhtml/autostart.el")

(add-to-list 'auto-mode-alist '("\\.xml\\.erb$" . eruby-nxhtml-mumamo-mode))
(add-to-list 'auto-mode-alist '("\\.html\\.erb$" . eruby-nxhtml-mumamo-mode))

(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(setq mumamo-background-colors nil)

					;(pymacs-load "pymdev" "pymdev-")

(autoload 'mode-compile "mode-compile"
  "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
  "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)


;; more typical line numbers
(line-number-mode 1)
(global-linum-mode 1)


(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
		("\\.cmake\\'" . cmake-mode))
	      auto-mode-alist))


(eval-after-load "icomplete" '(progn (require 'icomplete+)))

(ido-mode t)
(setq ido-enable-flex-matching t) ; fuzzy matching is a must have

;; some window numbering
(add-to-list 'load-path "/path/to/window-numbering")
(require 'window-numbering)
(window-numbering-mode 1)

(require 'smooth-scrolling)

;; (require 'bar-cursor)
;; (bar-cursor-mode 1)

;; (require 'feature-mode)
;; (add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

(require 'compile)
;; (require 'rspec-mode)

;;; messing with colors
;; see http://www.gnu.org/software/emacs/manual/html_node/emacs/Standard-Faces.html
;; (set-face-background 'modeline          "#ccccff")
;; (set-face-background 'modeline-inactive "#cccccc")
;; (set-face-background 'fringe "#fcfcfc")


;;; as per http://www.emacswiki.org/emacs/SmoothScrolling try to make mouse scrolling sane
;; scroll one line at a time (less “jumpy” than defaults)
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil) ;; don’t accelerate scrolling
(setq mouse-wheel-follow-mouse t) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; for xml files, use nxml-mode instead of sgml-mode
(add-to-list 'auto-mode-alist '("\\.xml$" . nxml-mode))

;; These lines are required for ECB
;; (setq semantic-load-turn-everything-on t)
;; (require 'semantic-load)

;;; Backup files in one spot
(setq backup-directory-alist nil)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/eback"))
            backup-directory-alist))


(require 'nav)
(nav-disable-overeager-window-splitting)

;; ;; This installs ecb - it is activated with M-x ecb-activate
;; (require 'semantic/analyze)
;; (provide 'semantic-analyze)
;; (provide 'semantic-ctxt)
;; (provide 'semanticdb)
;; (provide 'semanticdb-find)
;; (provide 'semanticdb-mode)
;; (provide 'semantic-load)
;; 
;; (require 'ecb)
;;
;; (require 'ecb-autoloads)
;; (add-hook 'ecb-before-activate-hook
;; 	  (function
;; 	   (lambda ()
;; 	     (global-ede-mode 1)
;; 	     ;; Enable semantic. Causes the "Development" main menu to
;; 	     be added.
;; 	     (semantic-mode 1)
;; 	     ;; If enabled, semantic inserts lines in the code buffer
;; 	     above the tags
;; 	     ;; it is tracking, and highlights things like #includes
;; 	     (dflt=nil)
;; 	     (global-semantic-decoration-mode 1)
;; 	     ;; dflt=nil
;; 	     (global-semantic-highlight-func-mode 1)
;; 	     ;; dflt=nil
;; 	     (global-semantic-idle-completions-mode 1)
;; 	     ;; dflt=nil
;; 	     (global-semantic-idle-tag-highlight-mode 1)
;; 	     ;; dflt=nil
;; 	     (global-semantic-show-parser-state-mode 1)
;; 	     ;; dflt=nil
;; 	     (global-semantic-show-unmatched-syntax-mode 1)
;; 	     (setq ecb-bucket-node-display '("[" "]" ecb-bucket-node-face))
;; 	     ))
;; 	  )

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)


(require 'nginx-mode)
(require 'ruby-test)

;;; actionscript
;; (require 'actionscript-mode)
;; (add-to-list 'auto-mode-alist '("\\.as$" . actionscript-mode))



;;; For rails development
					; (require 'rails-autoload)
					; (require 'haml-mode)

(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.task$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))

;; https://github.com/yoshiki/yaml-mode/raw/master/yaml-mode.el
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

;; sass-mode
(require 'sass-mode)
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))

;; coffee script mode, by defunkt
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
(defun coffee-custom ()
  "coffee-mode-hook"
  (set (make-local-variable 'tab-width) 2))

(add-hook 'coffee-mode-hook
	  '(lambda() (coffee-custom)))


(autoload 'javascript-mode "javascript" nil t)

;; Someones modified version of Yegge's js mode
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;;; Taken from http://www.emacswiki.org/emacs/EmacsClient
;;; use close buffer key for ending client session
(add-hook 'server-switch-hook
	  (lambda ()
	    (when (current-local-map)
	      (use-local-map (copy-keymap (current-local-map))))
	    (when server-buffer-clients
	      (local-set-key (kbd "C-x k") 'server-edit))))


(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

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

;;; Notes
;; auto increment magic (thank yegge!)
;; M-x replace-regexp
;;   Replace regexp: \(.+:\)
;;   Replace regexp with \#.

(setq ruby-insert-encoding-magic-comment nil)

;; to let emacsclient calls work
(server-start)
;; (add-hook 'after-init-hook 'server-start)

(setq yas/root-directory (expand-file-name "~/.emacs.d/snippets"))

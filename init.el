(setq debug-on-error t)

;; (require 'package)
;; list the packages you want
(setq package-list '(web-mode window-numbering color-theme-solarized))

; list the repositories containing them
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
			 ("melpa" . "http://melpa.org/packages/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;;; make the path better on mac
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;;; global settings
(setq inhibit-startup-message t)
(show-paren-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(column-number-mode 1)
(line-number-mode 1)
(global-linum-mode 1)
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(scroll-bar-mode -1)
(ido-mode t)
(setq ido-enable-flex-matching t)

;;; git it my backup system, and I work nearly 100% on my own machine
(setq create-lockfiles nil
      auto-save-list-file-prefix nil
      backup-inhibited t
      make-backup-files nil
      auto-save-default nil)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(add-to-list 'load-path "~/.emacs.d/elisp/")
(load-library "functions")
(load-library "hooks")
(load-library "keybindings")

;;; enabled some 'advanced' features
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(setq mac-command-modifier 'meta) ;; so I don't go crazy on a mac

;;; package settings
;; (require 'window-numbering)
(window-numbering-mode 1)

;;; web-mode setup
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.eex\\'" . web-mode))

(server-start)

;;; not sure these are still uses
;; (setq exec-path (append exec-path '("/usr/local/bin")))

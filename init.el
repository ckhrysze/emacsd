(setq debug-on-error t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

(setq package-list '(web-mode window-numbering use-package))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

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

;;; git is my backup system, and I work nearly 100% on my own machine
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
(window-numbering-mode 1)

;;; web-mode setup
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.eex\\'" . web-mode))

(use-package yasnippet
  :config
  (yas-global-mode 1))

(server-start)

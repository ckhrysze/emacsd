;;; global settings
(setq inhibit-startup-message t)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(fset 'yes-or-no-p 'y-or-n-p)
(setq ring-bell-function 'ignore)
(setq-default frame-title-format '("%f [%m]"))

;;; git is my backup system, and I work nearly 100% on my own machine
(setq create-lockfiles nil
      auto-save-list-file-prefix nil
      backup-inhibited t
      make-backup-files nil
      auto-save-default nil)

;;; mac specific
(when (memq window-system '(mac ns))
  (setq mac-command-modifier 'meta)
  (exec-path-from-shell-initialize))

;;; enabled some 'advanced' features
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

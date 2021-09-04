;;; global settings
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(fset 'yes-or-no-p 'y-or-n-p)

(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(setq ring-bell-function 'ignore)
(setq require-final-newline t)

(when window-system
  (setq-default frame-title-format '(buffer-file-name "%f" (%b))))

;;; git is my backup system, and I work nearly 100% on my own machine
(setq create-lockfiles nil
      auto-save-list-file-prefix nil
      backup-inhibited t
      make-backup-files nil
      auto-save-default nil)

;;; mac specific
;; (when (memq window-system '(mac ns))
;;  (exec-path-from-shell-initialize))
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (exec-path-from-shell-initialize))

;;; enabled some 'advanced' features
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(show-paren-mode t)
(column-number-mode 1)
(line-number-mode 1)
(global-linum-mode 1)
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(scroll-bar-mode -1)

;;; ido
;;; NOTE: C-s and C-r for moving between things
(ido-mode t)
(setq ido-enable-flex-matching t)

(window-numbering-mode 1)
(flycheck-mode)

(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package projectile
  :config
  (projectile-mode 1))

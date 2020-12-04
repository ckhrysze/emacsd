(show-paren-mode t)
(column-number-mode 1)
(line-number-mode 1)
(global-hl-line-mode 1)
(global-display-line-numbers-mode t)
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(scroll-bar-mode -1)

;;; ido
;;; NOTE: C-s and C-r for moving between things
(ido-mode t)
(setq ido-enable-flex-matching t)

(window-numbering-mode 1)
(flycheck-mode)

(use-package smartparens-config)

(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package projectile
  :config
  (projectile-mode 1))

(use-package direnv
  :config
  (direnv-mode 1))

(use-package fringe-current-line
  :config
  (global-fringe-current-line-mode 1))

(use-package ace-jump-mode
  :config
  (define-key global-map (kbd "C-c SPC") 'ace-jump-mode))

(use-package flycheck-pyflakes
  :no-require t
  :config
  (add-to-list 'flycheck-disabled-checkers 'python-pylint))

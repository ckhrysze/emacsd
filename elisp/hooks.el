;;; Taken from http://www.emacswiki.org/emacs/EmacsClient
(add-hook 'server-switch-hook
          (lambda ()
            (when (current-local-map)
              (use-local-map (copy-keymap (current-local-map))))
            (when server-buffer-clients
              (local-set-key (kbd "C-x k") 'server-edit))))

(add-hook 'web-mode-hook 'ckhrysze-web-mode-hook)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'js-mode-hook 'ckhrysze-javascript-mode-hook)

(require 'alchemist)
(add-hook 'elixir-mode-hook 'alchemist-mode)
(add-hook 'elixir-mode-hook 'ckhrysze-elixir-mode-hook)

(require 'flycheck-pyflakes)
;;; (add-to-list 'flycheck-disabled-checkers 'python-pylint)

(add-hook 'python-mode-hook 'ckhrysze-python-mode-hook)

(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

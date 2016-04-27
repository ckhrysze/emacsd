;;; Taken from http://www.emacswiki.org/emacs/EmacsClient
(add-hook 'server-switch-hook
	  (lambda ()
	    (when (current-local-map)
	      (use-local-map (copy-keymap (current-local-map))))
	    (when server-buffer-clients
	      (local-set-key (kbd "C-x k") 'server-edit))))

(add-hook 'web-mode-hook 'ckhrysze-web-mode-hook)
(add-hook 'elixir-mode-hook 'ckhrysze-elixir-mode-hook)


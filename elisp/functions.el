(defun date ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

(defun ckhrysze-web-mode-hook ()
  "Hooks for Web mode"
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent--offset 2)
  (setq web-mode-code-indent-offset 2)
  )

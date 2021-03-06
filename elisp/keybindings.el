(global-set-key [f2] 'server-edit)
(global-set-key [f4] 'call-last-kbd-macro)
(global-set-key [f5] 'revert-buffer-no-confirm)
(global-set-key "\C-z" 'undo)
(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-y" 'clipboard-yank)
(global-set-key "\C-v" 'clipboard-yank)
(global-set-key "\C-x\C-b" 'buffer-menu)

(global-set-key (kbd "M-]") 'next-buffer)
(global-set-key (kbd "M-[") 'previous-buffer)

(global-set-key (kbd "C-M-<up>") 'duplicate-line-up)
(global-set-key (kbd "C-M-<down>") 'duplicate-line-down)
(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)
(global-set-key (kbd "C-+") 'increment-number-at-point)
(global-set-key (kbd "C--") 'decrement-number-at-point)

(global-set-key (kbd "C-x C-r") 'revert-buffer-no-confirm)

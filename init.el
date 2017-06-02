(setq debug-on-error t)

;;; packages to always have installed
(setq package-list
      '(
	web-mode
	window-numbering
	yaml-mode
	projectile-mode
	)
      )

;;; list the repositories containing them
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
			 ("melpa" . "http://melpa.org/packages/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ))
;;; activate all the packages (in particular autoloads)
(package-initialize)

;;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(add-to-list 'load-path "~/.emacs.d/elisp/")
(load-library "settings")
(load-library "modes")
(load-library "associations")
(load-library "functions")
(load-library "hooks")
(load-library "keybindings")

;;; mainly for git commit messages
(server-start)

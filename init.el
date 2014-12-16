;; Set font
(set-face-attribute 'default nil
		    :family "Inconsolata" :height 140)
;; Set package archives
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                           ("marmalade" . "http://marmalade-repo.org/packages/")
                           ("melpa" . "http://melpa.milkbox.net/packages/")))

;; load CEDET
(load-file "~/.emacs.d/cedet-1.1/common/cedet.el")
(global-ede-mode 1)                      ; Enable the Project management system
(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
(global-srecode-minor-mode 1)            ; Enable template insertion menu

;; theme
(add-hook 'after-init-hook
          (lambda ()
            (progn
              (require 'color-theme)
              (color-theme-initialize)
              (color-theme-monokai))))




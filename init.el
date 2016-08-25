(require 'cask "~/.cask/cask.el")
(cask-initialize)

;; UI Cleanups
(setq inhibit-splash-screen t)
(tool-bar-mode 0)
(menu-bar-mode 0)
(toggle-scroll-bar 0)
(column-number-mode 1)
;;(tabbar-mode 0)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("marmalade" . "https://marmalade-repo.org/packages/")
			 ("melpa" . "https://melpa.milkbox.net/packages/") 
			 ("melpa-stable" . "https://melpa-stable.milkbox.net/packages/")))

(let ((default-directory "~/.emacs.d"))
  (normal-top-level-add-subdirs-to-load-path))


;; (dolist (dir (directory-files "~/Library/Preferences/Aquamacs Emacs" t "^[^.]"))
;;   (when (file-directory-p dir)
;;     (setq load-path (cons dir load-path))))


(require 'color-theme)


;; save history between sessions
(setq savehist-additional-variables    ;; also save...
  '(search-ring regexp-search-ring)    ;; ... my search entries
  savehist-file "~/.emacs.d/savehist") ;; keep my home clean
(savehist-mode t)                      ;; do customization before activate

;; screw backup and autosave. up yours delors.
(setq make-backup-files nil)
(setq auto-save-default nil)

;; code folding using outline mode, cedet is unusable right now
;; (add-hook 'python-mode-hook 'outline-minor-mode)
;; (require 'outline-magic)
;; (define-key outline-minor-mode-map (kbd "<C-tab>") 'outline-cycle)

;;; Python
;; fixme (package-initialize)
;; fixme (elpy-enable)

;; let mouse work in terminal emacs
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] '(lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
                              (interactive)
                              (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
)


;;; Make erc much less chatty
(require 'erc-utils)
(setq erc-hide-list '("MODE"))
(add-hook 'erc-insert-pre-hook 'erc-ignore-unimportant)

(require 'utils)

;;Global key bindings
(global-set-key (kbd "<deletechar>") 'backward-delete-char)
(global-set-key (kbd "ESC <deletechar>") 'backward-kill-word)
(global-set-key (kbd "C-z") nil)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-k" 'kill-word)
(global-set-key "\C-cc" 'compile)
(global-set-key "\C-a" 'beginning-of-line-dwim)
(global-set-key "\C-co" 'other-window)
(global-set-key (kbd "M-r") 're-search-backward)
(global-set-key (kbd "M-s") 're-search-forward)
(global-set-key [f12] 'locate)

;; sauron!
(require 'sauron)
(global-set-key (kbd "C-c s") 'sauron-toggle-hide-show)
(setq sauron-min-priority 2)
(setq sauron-max-line-length 140)

;; events to ignore
(add-hook 'sauron-event-block-functions
  (lambda (origin prio msg &optional props)
    (or
      (string-match "^*** Users" msg)
      (string-match "has joined #")
      (string-match "has left #")))) ;; filter out IRC spam

;;; Python
(package-initialize)
(elpy-enable)

;;;
(require 'flymake-cursor)


(global-set-key (kbd "C-c +") 'increment-number-at-point)
(global-set-key [f1] 'show-file-name)
(put 'upcase-region 'disabled nil)


(message "Hello-world -- this is my init.el file loading!")


;;; org-capture

(define-key global-map (kbd "\C-ct") 'org-capture)

(setq org-capture-templates
      '(
        ("t" "Todo" entry (file+headline "~/notes/todo.org" "Tasks")
         "* TODO %?\n  %u\n")
        ("n" "Note" entry (file+headline "~/notes/notes.org" "Notes")
         "* Note: %?\n  %u\n")
        ("j" "Journal"
         entry (file+datetree "~/notes/journal.org")
         "* %?"
         :empty-lines 1)
        ))


;; A-M-down and A-M-up bound to other-window. You'll get there
;; eventually, which is much better than figuring out where to chord

(global-set-key (kbd "A-M-<down>") 'other-window)
(global-set-key (kbd "A-M-<up>") 'other-window)


(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(dumb-jump-mode t)

;; Color-theme
(require 'color-theme)
(load "~/.emacs.d/color-theme-molokai.el")
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-molokai)))

(defun system-is-mac ()
  (interactive)
  (string-equal system-type "darwin"))


(if (system-is-mac)
    (setq locate-command "mdfind")
  )
;; ; set command key to be meta instead of option
;; (if (system-is-mac)
;;     ;; (setq ns-command-modifier 'meta)
;;     (setq mac-command-modifier 'meta
;;     (setq mac-command-modifier 'alt))


(setq markdown-command "pandoc -c file:///Users/mgokhale/.emacs.d/pandoc-github.css --from markdown_github -t html5 --mathjax --highlight-style pygments --standalone")

(electric-pair-mode t)


;; from the gnu's mouth
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Frame-Parameters.html#Frame-Parameters

(add-to-list 'default-frame-alist
             '(font . "Inconsolata-11"))

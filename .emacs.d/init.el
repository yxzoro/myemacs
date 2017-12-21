;; ==== this is a simple version my emacs config: ====

;;Install Packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(
    evil
    neotree
    multiple-cursors
    better-defaults
    ein
    magit
    elpy
    flycheck
    py-autopep8
    helm
    ace-jump-mode
    switch-window
    highlight-symbol
    jedi
    git-gutter
    ))

(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)

;; Basic Configuration
(menu-bar-mode 0)
(setq inhibit-startup-message t) ;; hide the startup message
(global-linum-mode t) ;; enable line numbers globally
(setq linum-format "%d ")
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
(global-hl-line-mode 1)
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq-default truncate-lines t)  ;; no wordwrap when line is long


(elpy-enable)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; evil mode using vim's keybinding:
(require 'evil)

;;magit: 
(global-set-key (kbd "C-x g") 'magit-status)

(require 'py-autopep8)

(add-to-list 'load-path "/root/.emacs.d/elpa/neotree-20160306.730/")
(require 'neotree)

;; emacs backup file path
(setq backup-directory-alist (quote ((".*" . "~/.myemacs_backups/"))))

;; show git diff: 
(global-git-gutter-mode +1)

(set-face-foreground 
  'git-gutter:separator "yellow")

(global-hl-line-mode  1)

;;choose number to switch windows
(require 'switch-window) 
(global-set-key (kbd "C-x o") 'switch-window)


;;helm
(global-set-key (kbd "M-x") 'helm-M-x)

;; --------------------------------------key-bindings------------------------------------------------------ ;;
(global-set-key [f4] 'evil-mode)  ;; vim evil mode
(global-set-key [f3] 'global-linum-mode)
(global-set-key [f2] 'goto-line)
(global-set-key [f1] 'neotree-toggle)

(global-set-key (kbd "C-q") 'ace-jump-char-mode) ;ace-jump mode: go to anywhere in emacs!!
(global-set-key (kbd "M-n") 'scroll-up-line) 
(global-set-key (kbd "M-m") 'scroll-down-line) 
(global-set-key (kbd "M-/") 'elpy-doc) ;; show python doc
(global-set-key (kbd "M-.") 'elpy-goto-definition)  ;; go to definition

(display-time)
(setq default-tab-width 4)
(fset 'yes-or-no-p 'y-or-n-p)  
;; auto-completion on brackets.
(setq skeleton-pair t)
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "'") 'skeleton-pair-insert-maybe)   ;; TODO: don't use in lisp-mode'

(global-undo-tree-mode 1) 


;; ---------------------------------------go setting-------------------------------------------
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))
;;--------------------------------------------------------
;; must change this to your $GOPATH first !
(setenv "GOPATH" "/home/go")
(add-to-list 'exec-path "/home/go/bin")

(defun my-go-mode-hook ()
      (add-hook 'before-save-hook 'gofmt-before-save)
        ; Godef jump key binding                                                      
	  (local-set-key (kbd "M-.") 'godef-jump)
	  (local-set-key (kbd "M-/") 'godoc)
	      )
(add-hook 'go-mode-hook 'my-go-mode-hook)

(defun auto-complete-for-go ()
  (auto-complete-mode 1))
 (add-hook 'go-mode-hook 'auto-complete-for-go)
(with-eval-after-load 'go-mode
(require 'go-autocomplete))

;;-------------------------------------------------------------------------------------------


;;------------------- you need to install some Python Packages using pip:--------------------;;
;; pip install flake8==2.6 autopep8 jedi
;;-------------------------------------------------------------------------------------------;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(exec-path-from-shell go-complete go-autocomplete go-snippets go-errcheck go-eldoc go-mode git-gutter jedi highlight-symbol switch-window ace-jump-mode helm py-autopep8 flycheck elpy magit ein better-defaults multiple-cursors neotree evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

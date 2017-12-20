
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
    neotree
    ace-jump-mode
    switch-window
    ))

(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)

;; Basic Configuration
(global-hl-line-mode 1)
(setq-default truncate-lines t)  ;; no wordwrap when line is long

(add-to-list 'load-path "/root/.emacs.d/elpa/neotree-20160306.730/")
(require 'neotree)
;;change neotree color
(custom-set-faces
 '(highlight ((t (:background "black" :foreground "blue"))))
 '(lazy-highlight ((t (:foreground "purple" :underline t))))
 '(neo-dir-link-face ((t (:foreground "cyan"))))
 '(neo-file-link-face ((t (:foreground "purple")))))

;;choose number to switch windows
(require 'switch-window) 
(global-set-key (kbd "C-x o") 'switch-window)
(global-set-key [f3] 'global-linum-mode)
(global-set-key [f2] 'goto-line)
(global-set-key [f1] 'neotree-toggle)

(global-set-key (kbd "C-q") 'ace-jump-char-mode) ;ace-jump mode: go to anywhere in emacs!!
(global-set-key (kbd "M-n") 'scroll-up-line) 
(global-set-key (kbd "M-m") 'scroll-down-line) 

(display-time)
(setq default-tab-width 4)
(fset 'yes-or-no-p 'y-or-n-p)  
;; auto-completion on brackets.
(setq skeleton-pair t)
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "'") 'skeleton-pair-insert-maybe)   ;; TODO: don't use in lisp-mode'



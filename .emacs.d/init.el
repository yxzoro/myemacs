;; ---------------------------------------------------------------------------------------;;
;; emacs/vim as editor in linux terminal, pycharm/sublime in gui. my 4 awesome editors...
;; 在emacs里也使用vim(emacs+evil mode)在纯文本编辑时还是使用vim快捷键更高效?突然发现emacs的acejump直接秒杀vim的所有光标移动操作
;; Don't waste time in ide staff. 
;; Focus on coding/algorithm... deep things.
;; prisma和tornado的创业故事总是提醒我写程序真正应该关注的核心是什么 ==>
;; 清晰深远的思路/熟悉的业务逻辑+使用合适的数据结构和算法写出代码来解决实际问题！
;; ---------------------------------------------------------------------------------------;;

;;-------build Emacs24.4/[or 25.1] from source code in centos6.7-minimal----------;;
; tar -xvzf emacs-24.4.tar.gz
; cd emacs-24.4
; yum install ncurses-devel  (只缺少这1个依赖库)
;; apt-get install libncurses-dev(Ubuntu) + `export TERM=xterm`(Ubuntu16)
; ./configure  --without-x   (无图形化)
; make
; make install 
; make clean
; emacs-24.4 --version
; centos6.7自带python2.6,2.7则需要自己编译安装(正常编译3步即可,不缺任何依赖包) 
;;----------------------------------------------------------------------;;


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
    git-gutter
    neotree
    multiple-cursors
    multi-term
    better-defaults
    ein
    magit
    elpy
    flycheck
    py-autopep8
    helm
    ace-jump-mode
    switch-window
    elscreen
    highlight-symbol
    comment-dwim-2
    vimish-fold
    powerline
    airline-themes
    smooth-scrolling
    jedi
    ))

(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)

;; Basic Configuration
(setq inhibit-startup-message t) ;; hide the startup message
(global-linum-mode t) ;; enable line numbers globally
(setq linum-format "%d ")
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
(global-hl-line-mode 1)
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq-default truncate-lines t)  ;; no wordwrap when line is long

(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq highlight-indent-guides-method 'character)
;(setq highlight-indent-guides-character ?\|)

;;--------------------------------------------------------------------------------------------;;
;; use emacs + elpy as Python IDE: 【https://elpy.readthedocs.io/en/latest/ide.html】
;;--------------------------------------------------------------------------------------------;;
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
;(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(add-to-list 'load-path "/root/.emacs.d/elpa/neotree-20160306.730/")
(require 'neotree)
;;change neotree color
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight ((t (:background "black" :foreground "blue"))))
 '(lazy-highlight ((t (:foreground "purple" :underline t))))
 '(neo-dir-link-face ((t (:foreground "cyan"))))
 '(neo-file-link-face ((t (:foreground "purple")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("b571f92c9bfaf4a28cb64ae4b4cdbda95241cd62cf07d942be44dc8f46c491f4" "a2e7b508533d46b701ad3b055e7c708323fb110b6676a8be458a758dd8f24e27" "e1994cf306356e4358af96735930e73eadbaf95349db14db6d9539923b225565" "fad38808e844f1423c68a1888db75adf6586390f5295a03823fa1f4959046f81" "e9460a84d876da407d9e6accf9ceba453e2f86f8b86076f37c08ad155de8223c" "251348dcb797a6ea63bbfe3be4951728e085ac08eee83def071e4d2e3211acc3" default)))
 '(git-gutter:separator-sign "|")
 '(package-selected-packages
   (quote
    (go-autocomplete exec-path-from-shell go-mode company-go vimish-fold switch-window smooth-scrolling rainbow-identifiers rainbow-delimiters rainbow-blocks py-autopep8 neotree multiple-cursors multi-term material-theme magit jedi highlight-symbol highlight-indent-guides helm git-timemachine git-gutter flycheck evil elscreen elpy ein comment-dwim-2 better-defaults airline-themes ace-jump-mode)))
 '(rainbow-delimiters-outermost-only-face-count 2))

;; emacs backup file path
(setq backup-directory-alist (quote ((".*" . "~/.myemacs_backups/"))))

;; show git diff: 
(global-git-gutter-mode +1)

(set-face-foreground 
  'git-gutter:separator "yellow")
;;goto every submit version of a file in git:
;; M-x git-timemachine
;; p Visit previous historic version
;; n Visit next historic version
;; w Copy the abbreviated hash of the current historic version
;; W Copy the full hash of the current historic version
;; g Goto nth revision
;; q Exit the time machine.
;; b Run magit-blame on the currently visited revision (if magit available).

;;turn off highlight current line mode:
(global-hl-line-mode  1)

;;choose number to switch windows
(require 'switch-window) 
(global-set-key (kbd "C-x o") 'switch-window)

;;key binding 
(fset 'mypdb
   "import pdb; pdb.set_trace()") ;; insert pdb breakpoint code. record Emacs Macro to a function.
(fset 'copyword
   "\C-[\C-[[D\C-@\C-[\C-[[C\C-[w") ;; copy a whole word which cursor is in.
(fset 'mylog
   "from yxLog1 import yxdebug; yxdebug('-'*80)\C-m    yxdebug()")
;; --> you can use `pudb` in emacs term, same as eclipse's debug mode,pudb enhance emacs's python degug.
;;     or you should use `ipdb/pdb` in a simple but powerful way !!
;;     or good log can help you fix bug already !!

;;helm
(global-set-key (kbd "M-x") 'helm-M-x)

;; --------------------------------------key-bindings------------------------------------------------------ ;;
;;(global-set-key [f9] 'mylog) ;;log
;;(global-set-key [f8] 'mypdb)  ;;debug
;;(global-set-key [f5] 'cua-mode)  ;; use C-c/x/v/z in cua-mode like Windows.
(global-set-key [f4] 'evil-mode)  ;; vim evil mode
(global-set-key [f3] 'global-linum-mode)
(global-set-key [f2] 'goto-line)
(global-set-key [f1] 'neotree-toggle)

(global-set-key (kbd "C-q") 'ace-jump-char-mode) ;ace-jump mode: go to anywhere in emacs!!
(global-set-key (kbd "M-n") 'scroll-up-line) 
(global-set-key (kbd "M-m") 'scroll-down-line) 
(global-set-key (kbd "C-x w") 'copyword)
(global-set-key (kbd "M-;") 'comment-dwim-2) ;;`C-/` is undo/redo in emacs, `M-;` is comment/uncomment.
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


;;use airline-theme for powerline: (https://github.com/AnthonyDiGirolamo/airline-themes)
(require 'airline-themes)
(load-theme 'airline-cool)  ;; choose one powerline theme from  ~/.emacs.d/elpa/airline-themes/.
(setq airline-display-directory  'airline-directory-Shortened)

(global-undo-tree-mode 0) 


; ---------------------------------------go setting-------------------------------------------
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))
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



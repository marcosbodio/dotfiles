;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; disable CTRL-Z
(global-unset-key (kbd "C-z"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FIX hang issue with tramp
;; (setq projectile-mode-line " Projectile")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; color preferences
;; (set-background-color "black")
;; (set-foreground-color "white")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; higlight current line mode
;; (global-hl-line-mode 1) ;; enable it globally
;; (set-face-background 'hl-line "#006633") ;; change color
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; show column numbers in the mode line
(setq column-number-mode t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; set global highlight mode
(global-hl-line-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; remove scroll bar, tool bar, and menu bar
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; theme
;; (load-theme 'wheatgrass t) 
;; solarized them from https://github.com/sellout/emacs-color-theme-solarized      
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
;; (load-theme 'solarized-dark t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; use spaces instead of tabs, and make them 4 spaces long
;; (setq-default indent-tabs-mode nil)
;; (setq default-tab-width 4)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; set Load Path: see http://emacswiki.org/emacs/LoadPath
;; (let ((default-directory "~/.emacs.d/lisp/"))
;;   (normal-top-level-add-to-load-path '("."))
;;   (normal-top-level-add-subdirs-to-load-path))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Add copy a whole line to clipboard to Emacs, bound to meta-c.
;; I copied this from here: http://carlhu.com/orgmode
(defun quick-copy-line ()
  "Copy the whole line that point is on and move to the beginning of the next line.
    Consecutive calls to this command append each line to the
    kill-ring."
  (interactive)
  (let ((beg (line-beginning-position 1))
        (end (line-beginning-position 2)))
    (if (eq last-command 'quick-copy-line)
        (kill-append (buffer-substring beg end) (< end beg))
      (kill-new (buffer-substring beg end))))
  (beginning-of-line 2)
  (message "Line appended to kill-ring."))
(define-key global-map (kbd "M-c") 'quick-copy-line)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org-mode settings
;; Set to the location of your Org files on your local system
(setq org-directory "~/org")
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
;; Org-mode agenda: use all files in path ~/org
;; (setq org-agenda-files '("~/org"))
(setq org-agenda-files (list "~/IBM/org/ibm.org"))
(setq org-log-done t)
(setq org-startup-truncated nil)
(setq org-startup-indented t)
(setq org-hide-leading-stars t)
(setq org-completion-use-ido t)
(setq org-indent-mode t)
;;
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
;; use Chrome to open link from org-mode
;; (setq browse-url-browser-function 'browse-url-generic
;;      browse-url-generic-program "google-chrome")
;; seetting up capture: http://orgmode.org/org.html#Setting-up-capture
(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)
;; capture templates
(setq org-capture-templates
    '(("t" "Todo" entry (file+headline "~/org/todo.org" "Tasks")
           "* TODO %?\n  %i\n  %a")
      ("b" "Bookmark" entry (file+headline "~/org/notes.org" "Bookmarks")
	   "* %? %^G\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n" :empty-lines 0)
      ("j" "Journal" entry (file+datetree "~/org/myblog.org")
           "* %?\nEntered on %U\n  %i\n  %a")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; turn off auto-backup (~ files)
(setq make-backup-files nil) ; stop creating backup~ files
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ido
(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; tramp
(require 'tramp)
(setq tramp-default-method "ssh")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; undo-tree
;; (require 'undo-tree)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; scala-mode
;; (add-to-list 'load-path "scala-emacs-mode")
;; (require 'scala-mode-auto)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yasnippet
;; (add-to-list 'load-path "yasnippet")
;; (require 'yasnippet)
;; (yas-global-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ace-jumps
;; (add-to-list 'load-path "/home/marco/.emacs.d/elpa/ace-jump-mode-2.0.0.0/")
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; edit jar, war, etc. in archive mode
;; (setq auto-mode-alist
;;       (append
;;        '(("\\.war\\'" . archive-mode))
;;        '(("\\.jar\\'" . archive-mode))
;;        auto-mode-alist))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; scoll up/down the view without moving the cursor
(global-set-key "\M-n"  (lambda () (interactive) (scroll-up   4)) )
(global-set-key "\M-p"  (lambda () (interactive) (scroll-down 4)) )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; active Org-babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
  '( (perl . t)         
     (python . t)
     (plantuml . t)
;;     (restclient . t)
;;   (http . t)
   ))   

(setq org-plantuml-jar-path
      (expand-file-name "~/bin/plantuml-8040.jar"))

;; to get syntax highlighting for MySQL SQL
(add-hook 'sql-mode-hook
          (lambda ()
            (sql-highlight-mysql-keywords)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; flycheck
;; (add-hook 'after-init-hook #'global-flycheck-mode)
;; redefine flycheck keymap prefix from "C-c !" to "C-c f", because the first conflicts with org mode agenda
;; (setq flycheck-keymap-prefix (kbd "C-c f"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; other repos
(require 'package)
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; initialize exec-path-from-shell for MAC OSX (see https://github.com/purcell/exec-path-from-shell)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SQL DB2 settings for iribnchmrk.mul.ie.ibm.com
;; (require 'sql)
;; (setq sql-db2p-rogram "/data/sngl-adpt/db2/db2inst1/sqllib/bin/db2")
;; (defadvice sql-db2 (around sql-db2-around activate)
;;   "SSH to linux, then connect"
;;   (let ((default-directory "/ssh:db2inst1@iribnchmrk.mul.ie.ibm.com:"))
;;     ad-do-it))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-dark-emacs/dark-theme 'solarized-dark)
 '(auto-dark-emacs/light-theme 'solarized-light)
 '(custom-enabled-themes '(solarized-light))
 '(custom-safe-themes
   '("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default))
 '(org-export-backends '(ascii html icalendar latex md odt))
 '(org-modules
   '(org-bbdb org-bibtex org-docview org-gnus org-info org-irc org-mhe org-rmail org-w3m))
 '(package-selected-packages
   '(ace-window markdown-toc markdown-mode gnuplot gnuplot-mode exec-path-from-shell json-mode solarized-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; markdown-mode
(setq markdown-command "/usr/local/bin/pandoc")
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; show which parenthesis matches the one I'm looking at https://www.gnu.org/software/emacs/manual/html_node/efaq/Matching-parentheses.html
(show-paren-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ace-window - https://github.com/abo-abo/ace-window
(global-set-key (kbd "M-o") 'ace-window)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto-dark-emacs: https://github.com/LionyxML/auto-dark-emacs
(add-to-list 'load-path "~/.emacs.d/vendor/auto-dark-emacs/")
(require 'auto-dark-emacs)

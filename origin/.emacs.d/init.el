(setq inhibit-startup-message t)

(setq-default tab-width 4)
(setq tab-stop-list
 '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))

(setq-default indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-mybe)

(menu-bar-mode 0)
;; paren mode
(show-paren-mode t)
;; Limit the final word to a line break code (automatically correct)
(setq require-final-newline t)

(defalias 'yes-or-no-p 'y-or-n-p)

(set-language-environment 'Japanese)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(keyboard-translate ?\C-h ?\C-?)

(setq make-backup-files nil)
(setq auto-save-default nil)

(global-whitespace-mode 1)
(require 'whitespace)
(setq whitespace-style '(face
                         trailing
                         tabs
                         empty
                         space-mark
                         tab-mark))
(setq whitespace-display-mappings
    '((space-mark ?\u3000 [?\u25a1])
      (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))
(setq whitespace-space-regexp "\\(\u3000+\\)")


(let ((default-directory "~/.emacs.d/site-lisp"))
    (setq loat-path (cons default-directory load-path))
    (normal-top-level-add-subdirs-to-load-path))

(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/site-lisp/auto-install/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)
(setq auto-install-save-confirm nil)

(column-number-mode t)
(which-function-mode t)

(global-set-key "\C-h" 'delete-backward-char)

(setq history-length 1000)
(setq undo-limit 100000)
(setq undo-strong-limit 100000)

;; line numbers
(require 'linum)
(global-linum-mode t)
(setq linum-format "%4d: ")

;; anything
;; emacs --batch -Q -L ~/.emacs.d/site-lisp/auto-install --eval "(require 'auto-install)(setq auto-install-directory \"~/.emacs.d/site-lisp/auto-install/\")(auto-install-batch \"anything\")"
(when (require 'anyting nil t)
    (add-to-list 'anything-sources 'anything-c-source-emacs-commands))

(when (require 'flymake nil t))

;; php-mode
;; emacs --batch -Q -L ~/.emacs.d/site-lisp/auto-install --eval "(require 'auto-install)(setq auto-install-directory \"~/.emacs.d/site-lisp/auto-install/\")(auto-install-from-url \"http://svn.code.sf.net/p/php-mode/code/tags/php-mode-1.5.0/php-mode.el\")"
(when (require 'php-mode nil t))

;; auto-complete
;; emacs --batch -Q -L ~/.emacs.d/site-lisp/auto-install --eval "(require 'auto-install)(setq auto-install-directory \"~/.emacs.d/site-lisp/auto-install/\")(auto-install-batch \"auto-complete development version\")"
(when (require 'auto-complete-config nil t)
    (ac-config-default)
    (define-key ac-completing-map (kbd "M-n") 'ac-next)
    (define-key ac-completing-map (kbd "M-p") 'ac-previous)
    (setq ac-auto-start nil)
    (ac-set-trigger-key "TAB")
    (setq ac-dwim t)
)

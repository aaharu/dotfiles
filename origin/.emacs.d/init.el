(setq inhibit-startup-message t)

(setq-default tab-width 4)
(setq tab-stop-list
 '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))

(setq-default indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-mybe)

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

(require 'cl)
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

(line-number-mode t)
(column-number-mode t)
(which-function-mode t)

(global-set-key "\C-h" 'delete-backward-char)

(setq history-length 1000)
(setq undo-limit 100000)
(setq undo-strong-limit 100000)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
(load-theme 'solarized-dark t)

(require 'anything)
(add-to-list 'anything-sources 'anything-c-source-emacs-commands)

(require 'flymake)

(require 'php-mode)

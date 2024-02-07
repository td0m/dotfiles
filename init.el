;;; -*- lexical-binding: t -*-
;; DOM (not DOOM) emacs
;;   don't bother organizing, pretty much all lines in chronological order.
;;   treat this file like a persistent *scratch* buffer.
;;   keep scope to just code editing + org mode + git. no email for at least 12 months.

;; (occur "use-package")

(setq user-full-name "Dominik Tarnowski"
      user-mail-address "dom.tarnowski@rungway.com")

(set-frame-font "PT Mono 11" t)

(global-set-key (kbd "C-x k") 'kill-this-buffer)

(tool-bar-mode -1)
(menu-bar-mode -1)

(recentf-mode 1)

(global-font-lock-mode 0)

(delete-selection-mode 1)

;; (setq dired-listing-switches "--group-directories-first -la")

(setq delete-by-moving-to-trash t)

(setq tab-always-indent 'complete)

(load-theme 'modus-operandi)
(setq cursor-type 'bar)
(blink-cursor-mode -1)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(package-initialize)
;; (package-refresh-contents)
;; (setq use-package-always-ensure t)
(setq package-native-compile t)

(use-package vertico
  :init (vertico-mode))

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook (lambda () (setq display-line-numbers 'relative)))

(delete-selection-mode 1)

(when (not (eq system-type 'darwin))
  (setq dired-listing-switches "-l --group-directories-first"))

(use-package org)

(setq org-confirm-babel-evaluate nil)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (python . t)))

(setq custom-file "~/.config/emacs/custom.el")

(add-hook 'before-save-hook #'delete-trailing-whitespace)

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(savehist-mode 1)

(defadvice compile (before ad-compile-smart activate)
  "Advises `compile' so it sets the argument COMINT to t."
  (ad-set-arg 1 t))

(use-package magit
  :bind ("C-c g" . magit-status))

(use-package corfu
  :init
  (global-corfu-mode)
  :config
  (setq corfu-auto t)
  :bind
  (:map corfu-map
        ("SPC" . corfu-insert-separator)
        ("C-n" . corfu-next)
        ("C-p" . corfu-previous)))

(setq tab-always-indent 'complete)

(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode)))

(use-package emmet-mode
  :init
  (add-hook 'web-mode-hook 'emmet-mode)
  (add-hook 'emmet-mode-hook 'emmet-preview-mode))

(use-package expand-region
  :init
  (global-set-key (kbd "C-,") 'er/expand-region))

(setq electric-indent-inhibit t)

;; js multi line strings require this...
;; (global-set-key (kbd "C-<TAB>") 'indent-relative)

(add-hook 'go-mode-hook 'eglot-ensure)

(set-default 'truncate-lines t)

(defun eslint-formatter (&optional b e)
      "formats the selected text to format the js"
    (interactive "r")
    (call-process-region (point-max) (point-min) "eslint_d" t t nil "--stdin" "--fix-to-stdout"))

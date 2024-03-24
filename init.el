;;; -*- lexical-binding: t -*-
;; DOM (not DOOM) emacs

(use-package emacs
  :custom
  (delete-by-moving-to-trash t)
  (js-mode-map (make-sparse-keymap)) ; plz disable it, things like M-. are better with lsp
  (js-ts-mode-map (make-sparse-keymap))
  (package-native-compile t)
  (tab-always-indent 'complete)
  (user-full-name "Dominik Tarnowski")
  (user-mail-address "dom@tdom.dev")
  (completion-ignore-case t)
  :init
  (set-face-attribute 'default nil :font "monospace-9")
  (add-hook 'before-save-hook #'delete-trailing-whitespace)
  (add-hook 'prog-mode-hook 'display-line-numbers-mode)
  (add-hook 'text-mode-hook (lambda () (setq display-line-numbers 'relative)))
  (blink-cursor-mode -1)
  (global-font-lock-mode -1)
  (global-set-key (kbd "C-x k") 'kill-this-buffer)
  (load-theme 'modus-operandi)
  (menu-bar-mode -1)
  (recentf-mode 1)
  (savehist-mode 1)
  (tool-bar-mode -1))

(use-package package
  :custom (package-native-compile t)
  :init
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  (add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
  (package-initialize))

(use-package vertico
  :init
  (vertico-mode)
  (setq completion-in-region-function #'consult-completion-in-region))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package magit
  :init
  (setq magit-define-global-key-bindings 'recommended)
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)
  (setq magit-bury-buffer-function #'magit-restore-window-configuration))

(use-package emmet-mode
  :mode ("\\.html\\'" . emmet-mode)
  :custom
  (emmet-preview-default nil)
  :init
  (add-hook 'web-mode-hook 'emmet-mode))

(use-package embark
  :init
  (global-set-key (kbd "C->") 'embark-export)
  (global-set-key (kbd "C-.") 'embark-act))

(use-package embark-consult
  :init
  (add-hook 'embark-collect-mode 'consult-preview-at-point-mode))

(use-package wgrep)

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package keycast)

(defadvice compile (before ad-compile-smart activate)
  "Advises `compile' so it sets the argument COMINT to t."
  (ad-set-arg 1 t))

(defun recompile-quietly ()
  "Re-compile without changing the window configuration."
  (interactive)
  (save-window-excursion
    (recompile)))

(defun compile-on-save-start ()
  (let ((buffer (compilation-find-buffer)))
    (unless (get-buffer-process buffer)
      (recompile))))

(define-minor-mode compile-on-save-mode
  "compile on save."
  :lighter " CoS"
  (if compile-on-save-mode
      (progn  (make-local-variable 'after-save-hook)
              (add-hook 'after-save-hook 'compile-on-save-start nil t))
    (kill-local-variable 'after-save-hook)))

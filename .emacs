;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

;; (setq package-archives
;;       '(("gnu" . "https://elpa.gnu.org/packages/")
;;         ("marmalade" . "https://marmalade-repo.org/packages/")
;;         ("melpa" . "https://melpa.org/packages/")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (dracula)))
 '(custom-safe-themes
   (quote
    ("ff7625ad8aa2615eae96d6b4469fcc7d3d20b2e1ebc63b761a349bebbb9d23cb" "d9129a8d924c4254607b5ded46350d68cc00b6e38c39fc137c3cfb7506702c12" "dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" "b571f92c9bfaf4a28cb64ae4b4cdbda95241cd62cf07d942be44dc8f46c491f4" default)))
 '(fci-rule-color "#383838")
 '(smooth-scrolling-mode t)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))

(let ((bootstrap-file (concat user-emacs-directory "straight/repos/straight.el/bootstrap.el"))
      (bootstrap-version 3))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(delete-selection-mode 1)

(setq exec-path (append exec-path '("~/.local/bin")))
(require 'site-gentoo)

(setq gc-cons-threshold 100000000)

;; === Package management

(straight-use-package 'use-package)

(use-package straight
  :init
  (setq straight-use-package-by-default t))

(use-package use-package)

;; ===

;; === Misc

(use-package keychain-environment
  :config
  (keychain-refresh-environment))

(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package helm
  :demand t

  :config
  (require 'helm-config)
  (helm-mode 1)

  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ;; ("C-x b" . helm-mini)
         ("M-y" . helm-show-kill-ring)))

(use-package undo-tree
  :config
  (global-undo-tree-mode 1)

  :bind (("C-S-z" . undo-tree-redo)
         ("C-z" . undo-tree-undo)))

(use-package magit
  :bind (("C-x g" . magit-status)))

(use-package nlinum
  :config
  (global-nlinum-mode 1))

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package whitespace-cleanup-mode
  :config
  (global-whitespace-cleanup-mode))

(use-package expand-region
  :bind (("C-x \\" . er/expand-region)))

(use-package flycheck
  :config
  (global-flycheck-mode))

(use-package editorconfig
  :config
  (editorconfig-mode 1))

(use-package ace-window
  :bind (("M-o" . ace-window)))

(use-package dockerfile-mode)

(use-package markdown-mode)

(use-package yaml-mode)

(use-package dracula-theme)

;; ===

;; === RTags ===

(use-package rtags
  :config
  (add-hook 'c-mode-hook 'rtags-start-process-unless-running)
  (add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
  (rtags-enable-standard-keybindings))

(use-package helm-rtags
  :after (helm rtags)

  :config
  (setq rtags-display-result-backend 'helm))

(use-package company-rtags
  :after (company rtags)

  :init
  (setq rtags-autostart-diagnostics t)
  (setq rtags-completions-enabled t)

  :config
  (push 'company-rtags company-backends))

(use-package flycheck-rtags
  :after (flycheck rtags))

;; ===

;; === Haskell ===

(use-package haskell-mode)

;; (use-package intero
;;   :config
;;   (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;   (add-hook 'haskell-mode-hook 'intero-mode))

;; ===

;; === Lisp ==

(use-package sly
  :init
  (setq inferior-lisp-program "sbcl"))

(use-package sly-company
  :after (sly company)

  :config
  (add-hook 'sly-mode-hook 'sly-company-mode)
  (add-to-list 'company-backends 'sly-company))

(use-package paredit
  :config
  (add-hook 'clojure-mode-hook #'paredit-mode)
  (add-hook 'lisp-mode-hook #'paredit-mode)
  (add-hook 'emacs-lisp-mode-hook #'paredit-mode))

;; ===

;; === Projectile ===

(use-package projectile
  :config
  (projectile-global-mode))

(use-package helm-projectile
  :after (helm projectile)

  :config
  (helm-projectile-on))

;; ===

;; === Rust ===

(use-package rust-mode)

(use-package flycheck-rust
  :after (rust-mode flycheck)

  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

;; ===

;; === Ruby ===

(use-package robe
  :config
  (add-hook 'ruby-mode-hook 'robe-mode)
  (push 'company-robe company-backends))

(use-package slim-mode)

(use-package scss-mode)

;; ===

;; === Elixir ===

(use-package alchemist)

(use-package flycheck-dialyxir
  :after (flycheck)

  :config
  (flycheck-dialyxir-setup))

;; ===


(add-hook 'prog-mode-hook 'electric-indent-mode)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(setq-default indent-tabs-mode nil
              c-default-style "stroustrup"
			  tab-width 4
			  c-basic-offset 4

			  inhibit-startup-screen t)

(global-auto-revert-mode 1) ; autoreload files

; (add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq mouse-wheel-scroll-amount '(3 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

(setq font-lock-maximum-decoration 2)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Makes *scratch* empty.
(setq initial-scratch-message "")

;; Removes *scratch* from buffer after the mode has been set.
(defun remove-scratch-buffer ()
  (if (get-buffer "*scratch*")
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

;; Removes *messages* from the buffer.
(setq-default message-log-max nil)
(kill-buffer "*Messages*")

;; Removes *Completions* from buffer after you've opened a file.
(add-hook 'minibuffer-exit-hook
      '(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
                (kill-buffer buffer)))))

;; Don't show *Buffer list* when opening multiple files at the same time.
(setq inhibit-startup-buffer-menu t)

(setq doc-view-continuous t) ; docmode scroll

(fset 'yes-or-no-p 'y-or-n-p)

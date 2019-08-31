;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

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
    ("e598fb69b8d73182d82e37015f0df7e31b47784e8f393bfa5962fabd9b77677b" "ff7625ad8aa2615eae96d6b4469fcc7d3d20b2e1ebc63b761a349bebbb9d23cb" "d9129a8d924c4254607b5ded46350d68cc00b6e38c39fc137c3cfb7506702c12" "dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" "b571f92c9bfaf4a28cb64ae4b4cdbda95241cd62cf07d942be44dc8f46c491f4" default)))
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

;; === Package management

(straight-use-package 'use-package)

(use-package straight
  :init
  (setq straight-use-package-by-default t))

(use-package use-package)

;; ===

;; === Misc

(use-package exec-path-from-shell
  :custom
  (exec-path-from-shell-check-startup-files nil)
  :config
  (exec-path-from-shell-initialize))

(use-package keychain-environment
  :config
  (keychain-refresh-environment))

(use-package rainbow-delimiters
  :config
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package helm
  :demand t

  :config
  (require 'helm-config)
  (helm-mode 1)

  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x b" . helm-mini)
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
  :hook (after-init . global-company-mode))

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

(use-package erc
  :custom
  (erc-log-channels-directory "~/.emacs.d/erc-logs/")
  :config
  (add-to-list 'erc-modules 'notifications)
  (add-to-list 'erc-modules 'log)
  (erc-update-modules))

(use-package edit-indirect
  :bind (("C-c e i" . edit-indirect-region)))

(use-package dockerfile-mode)

(use-package yaml-mode)

(use-package dracula-theme)

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :custom (markdown-command "pandoc"))

;; ===

;; === LSP ===

(use-package lsp-mode)

(use-package lsp-ui
  :after (lsp-mode)

  :hook
  (lsp-mode . lsp-ui-mode)

  :bind (:map lsp-ui-mode-map
              ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
              ([remap xref-find-references] . lsp-ui-peek-find-references)
              ([remap xref-find-apropos] . lsp-ui-peek-workspace-symbol)))

(use-package company-lsp
  :custom
  (company-transformers nil)
  (company-lsp-cache-candidates nil)

  :config
  (push 'company-lsp company-backends))

(use-package yasnippet
  :hook (prog-mode . yas-minor-mode))

;; ===

;; === CQuery ===

(use-package cquery
  :custom
  (cquery-executable "~/Code/cquery/_build/cquery")
  (cquery-sem-highlight-method 'font-lock))

;; ===

;; === Haskell ===

;; (use-package haskell-mode)

;; (use-package intero
;;   :config
;;   (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;   (add-hook 'haskell-mode-hook 'intero-mode))

;; ===

;; === Lisp ==

;; :straight (cider :host github
;;                 :repo "clojure-emacs/cider"
;;                 :branch "v0.21.0"
;;                 :files ("*.el" (:exclude ".dir-locals.el")))

;; (use-package cider)

(use-package sly
  :init
  (setq inferior-lisp-program "sbcl")

  :custom
  (sly-complete-symbol-function #'sly-flex-completions))

(use-package paredit
  :hook ((clojure-mode lisp-mode emacs-lisp-mode) . paredit-mode))

;; ===

;; === Projectile ===

(use-package projectile
  :config
  (projectile-mode)
  (add-to-list 'projectile-globally-ignored-directories "_build")
  (add-to-list 'projectile-globally-ignored-directories ".cquery_cached_index")

  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package helm-projectile
  :after (helm projectile)

  :config
  (helm-projectile-on))

;; ===

;; === Rust ===

(use-package rust-mode)

(use-package flycheck-rust
  :after (rust-mode flycheck)

  :hook (flycheck-mode . flycheck-rust-setup))

(use-package lsp-rust
  :hook (rust-mode . lsp-rust-enable)
  :hook (rust-mode . flycheck-mode))

;; ===

(use-package go-mode)


;; === GLSL ===

(use-package glsl-mode)

;; ===

;; === Elixir ===

(use-package alchemist)

(use-package flycheck-dialyxir
  :after (flycheck)

  :config
  (flycheck-dialyxir-setup))

(use-package elixir-mode
  :hook (elixir-mode . (lambda () (add-hook 'before-save-hook 'elixir-format nil t))))

;; ===

;; === Scala

(use-package ensime
  :init
  (setq ensime-startup-notification nil))

(use-package play-routes-mode)

;;

;; Web

(use-package web-mode
  :mode ("\\.scala.html\\'"
         "\\.html.eex\\'"
         "\\.html?\\'"
         "\\.jsx?\\'"
         "\\.vue\\'"))

;;

;; Debug

(use-package realgud)

;; ===

;; == C/++

(use-package bison-mode)

;;

;; Built-in

(use-package delsel
  :straight nil

  :config
  (delete-selection-mode 1))

(use-package site-gentoo
  :straight nil

  :if (string-match-p "gentoo" operating-system-release))

(use-package electric
  :straight nil

  :hook (prog-mode . electric-indent-mode))

(use-package scroll-bar
  :straight nil

  :config
  (scroll-bar-mode -1))

(use-package autorevert
  :straight nil

  :config
  (global-auto-revert-mode 1))

(use-package files
  :straight nil

  :custom
  (backup-directory-alist `((".*" . ,temporary-file-directory)))
  (auto-save-file-name-transforms `((".*" ,temporary-file-directory t))))

(use-package mwheel
  :straight nil

  :custom
  (mouse-wheel-scroll-amount '(3 ((shift) . 1) ((control) . nil)))
  (mouse-wheel-progressive-speed nil))

(use-package font-lock
  :straight nil

  :custom
  (font-lock-maximum-decoration 2))

(use-package simple
  :straight nil)

(use-package frame
  :straight nil
  :config
  (set-frame-font "Inconsolata 12"))

;; ===

;; Defined in emacs' C code

(tool-bar-mode -1)
(menu-bar-mode -1)

(c-add-style "my"
             '("stroustrup"
               (c-offsets-alist
                (arglist-close . 0)
                (innamespace . 0))))

(setq-default indent-tabs-mode nil

              tab-width 4

              c-default-style "my"
			  c-basic-offset 4

			  inhibit-startup-screen t)

;; ===

;; (add-to-list 'default-frame-alist '(fullscreen . maximized)

;; Makes *scratch* empty.
(setq initial-scratch-message "")

;; Don't show *Buffer list* when opening multiple files at the same time.
(setq inhibit-startup-buffer-menu t)

(setq doc-view-continuous t)

(fset 'yes-or-no-p 'y-or-n-p)

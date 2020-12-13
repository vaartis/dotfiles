;; -*- lexical-binding: t; -*-

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(auto-save-file-name-transforms '((".*" "/tmp/" t)))
 '(backup-directory-alist '((".*" . "/tmp/")))
 '(column-number-mode t)
 '(cquery-executable "~/Code/cquery/_build/cquery")
 '(cquery-sem-highlight-method 'font-lock)
 '(erc-log-channels-directory "~/.emacs.d/erc-logs/")
 '(exec-path-from-shell-check-startup-files nil)
 '(fci-rule-color "#383838")
 '(font-lock-maximum-decoration 2)
 '(lsp-file-watch-threshold 10000)
 '(markdown-command "pandoc")
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount '(3 ((shift) . 1) ((control))))
 '(newsticker-url-list nil)
 '(newsticker-url-list-defaults nil)
 '(org-src-fontify-natively t)
 '(send-mail-function 'smtpmail-send-it)
 '(smooth-scrolling-mode t)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   '((20 . "#BC8383")
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
     (360 . "#DC8CC3")))
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

(use-package dracula-theme
  :config
  (load-theme 'dracula t))

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :custom (markdown-command "pandoc"))

;; ===

;; === LSP ===

(use-package lsp-mode
  :config
  (setq
   gc-cons-threshold 100000000
   lsp-prefer-capf t
   read-process-output-max (* 1024 1024)
   company-minimum-prefix-length 1
   company-idle-delay 0.0
   lsp-clients-emmy-lua-jar-path (expand-file-name "~/Code/EmmyLua/EmmyLua-LS-all.jar")
   lsp-enable-on-type-formatting nil)
  :bind-keymap ("C-c l" . lsp-command-map)
  :hook ((c++-mode lua-mode) . lsp))

(use-package lsp-ui
  :commands lsp-ui-mode
  :bind (:map lsp-ui-mode-map
              ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
              ([remap xref-find-references] . lsp-ui-peek-find-references)
              ([remap xref-find-apropos] . lsp-ui-peek-workspace-symbol)))

(use-package helm-lsp
  :commands helm-lsp-workspace-symbol)

(use-package yasnippet
  :config
  (yas-reload-all)
  :bind (("C-c y" . company-yasnippet))
  :hook
  ((prog-mode yaml-mode) . yas-minor-mode))

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


(use-package cider)

;(use-package slime
;  :config
;  (slime-fancy-init))

(use-package sly
  :init
  (setq inferior-lisp-program "sbcl")
  ;;(setq inferior-lisp-program "ecl")
)

(use-package paredit
  :hook ((clojure-modme lisp-mode emacs-lisp-mode) . paredit-mode))

(use-package macrostep
  :config
  (define-key emacs-lisp-mode-map (kbd "C-c C-m") 'macrostep-expand))

;; ===

;; === Projectile ===

(use-package projectile
  :config
  (projectile-mode)
  (add-to-list 'projectile-globally-ignored-directories "_build")
  (add-to-list 'projectile-globally-ignored-directories ".clangd")

  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package helm-projectile
  :after (helm projectile)

  :config
  (helm-projectile-on))

;; ===

;; === Rust ===

(use-package rust-mode
  :hook (rust-mode . lsp))

(use-package flycheck-rust
  :after (rust-mode flycheck)

  :hook (flycheck-mode . flycheck-rust-setup))

;; === Go ===

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

;; (use-package ensime
;;   :init
;;   (setq ensime-startup-notification nil))
;;
;; (use-package play-routes-mode)

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

(use-package ccls)

(use-package cmake-mode)

;;

;; Things for org-mode

(use-package org
  :straight nil

  :custom
  (org-html-htmlize-output-type 'css)
  (org-html-htmlize-font-prefix "org-"))

(use-package kotlin-mode)

;; Lua

(use-package lua-mode)

(use-package moonscript)

;; RSS

(use-package elfeed
  :custom
  (elfeed-search-filter "@6-months-ago")
  (elfeed-feeds '("https://eev.ee/feeds/atom.xml"
                  "https://defungames.com/feed"
                  "https://www.plasma-mobile.org/feed.xml")))


;; Python

(use-package elpy
  :defer t
  :init
  (elpy-enable))

(use-package kwallet-auth-source
  :straight (kwallet-auth-source
             :type git
             :host github
             :repo "vaartis/kwallet-auth-source"
             :files ("*.el"))
  :init
  (setq kwallet-auth-source-folder "Mail")

  :config
  (kwallet-auth-source-enable))

(use-package mu4e
  :straight nil
  :if (string-match-p "arch" operating-system-release)

  :config
  (defun init--mu4e-context-match (match-str)
    (lambda (msg)
      (when msg
        (string-prefix-p match-str (mu4e-message-field msg :maildir)))))
  (cl-defun init--mu4e-make-context (name address smtp-name smtp-server
                                          &key (port 587))
    (make-mu4e-context
     :name name
     :match-func (init--mu4e-context-match (concat "/" name))
     :vars `((mu4e-sent-folder . ,(concat "/" name "/Sent"))
             (mu4e-drafts-folder . ,(concat "/" name "/Drafts"))
             (mu4e-trash-folder . ,(concat "/" name "/Trash"))
             (mu4e-refile-folder . ,(concat "/" name "/Archive"))
             (user-mail-address . ,address)
             (user-full-name . "vaartis")

             (smtpmail-smtp-user . ,smtp-name)
             (smtpmail-local-domain . ,smtp-server)
             (smtpmail-smtp-server . ,smtp-server)
             (smtpmail-smtp-service . ,port))))
  (add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e/")

  (defun init--mu4e-make-contexts ()
    (load (expand-file-name "~/.emacs.d/my-mail-addresses.el"))
    (mapcar (lambda (params)
              (apply 'init--mu4e-make-context params))
            my-mail-addresses))

  (let* ((contexts (init--mu4e-make-contexts))
         (addresses (mapcar (lambda (args) (nth 1 args)) my-mail-addresses))
         (main-name (nth 0 (car my-mail-addresses))))
    (setq
     mu4e-bookmarks
     '((:name "Unread messages" :query "flag:unread AND NOT flag:trashed AND NOT maildir:/Junk/" :key ?u)
       (:name "Today's messages" :query "date:today..now AND NOT maildir:/Junk/" :key ?t))
     mu4e-view-show-images t
     mu4e-view-show-addresses t
     mu4e-completing-read-function 'completing-read
     mu4e-contexts contexts
     user-mail-address (car addresses)
     mu4e-personal-addresses addresses
     mu4e-get-mail-command "mbsync -a"
     mu4e-sent-folder (concat "/" main-name "/Sent")
     mu4e-drafts-folder (concat "/" main-name "/Drafts")
     mu4e-trash-folder (concat "/" main-name "/Trash")
     mu4e-change-filenames-when-moving t
     mu4e-update-interval (* 5 60)))

  (setf (alist-get 'trash mu4e-marks)
        (list :char '("d" . "¶")
              :prompt "dtrash"
              :dyn-target (lambda (target msg)
                            (mu4e-get-trash-folder msg))
              :action (lambda (docid msg target)
                        ;; Here's the main difference to the regular trash mark,
                        ;; no +T before -N so the message is not marked as
                        ;; IMAP-deleted:
                        (mu4e~proc-move docid (mu4e~mark-check-target target) "-N")))
        (alist-get 'delete mu4e-marks)
        (list :char '("D" . "x")
              :prompt "Delete"
              :show-target (lambda (target) "delete")
              :action
              (lambda (docid msg target)
                ;; Mark the message as IMAP-deleted instead of actually deleting it.
                ;; It will go away after the sync.
                (mu4e~proc-move docid (mu4e~mark-check-target target) "+T-N")))))

(use-package mu4e-alert
  :after mu4e
  :init
  (setq mu4e-alert-interesting-mail-query
        ;; Join all inboxes into a filter
        (mapconcat
         (lambda (value)
           (concat "flag:unread maildir:/" value "/Inbox"))
         (mapcar (lambda (args) (car args)) my-mail-addresses)
         " OR "))
  :config
  (mu4e-alert-set-default-style 'libnotify)
  :hook (after-init . mu4e-alert-enable-notifications))

;; Built-in

(use-package desktop
  :straight nil

  :config
  (when (not (null window-system))
    (desktop-save-mode 1)))

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
  (set-frame-font "Hack 10"))

(use-package window
  :straight nil
  :bind (("M-o" . other-window)))

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

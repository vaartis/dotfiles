;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
    ("marmalade" . "https://marmalade-repo.org/packages/")
    ("melpa" . "https://melpa.org/packages/")))
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
 '(electric-indent-mode nil)
 '(fci-rule-color "#383838")
 '(org-agenda-files nil)
 '(package-selected-packages
   (quote
    (flycheck-rtags company-rtags helm-rtags rtags helm-projectile projectile sly-company sly realgud hindent intero cmake-ide company-irony irony cmake-font-lock paredit lua-mode cider expand-region whitespace-cleanup-moe whitespace-cleanup-mode company company-mode toml-mode use-package rust-mode go-mode ocp-indent tuareg helm keychain-environment uptimes dockerfile-mode ssh-agency magithub yaml-mode bison-mode magit nlinum llvm-mode dracula-theme rainbow-delimiters undo-tree)))
 '(smooth-scrolling-mode t)
 '(tramp-syntax (quote default) nil (tramp))
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

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq exec-path (append exec-path '("~/.local/bin")))

(require 'site-gentoo)

(setq gc-cons-threshold 100000000)

(use-package use-package
  :init
  (setq use-package-always-ensure t))

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
  (add-hook 'after-init-hook 'global-company-mode))

(use-package whitespace-cleanup-mode
  :config
  (global-whitespace-cleanup-mode))

(use-package expand-region
  :bind (("C-x \\" . er/expand-region)))

(use-package paredit
  :config
  (add-hook 'clojure-mode-hook #'paredit-mode)
  (add-hook 'lisp-mode-hook #'paredit-mode)
  (add-hook 'emacs-lisp-mode-hook #'paredit-mode))

(use-package flycheck
  :config
  (global-flycheck-mode))

;; === RTags ===

(use-package rtags
  :config
  (add-hook 'c-mode-hook 'rtags-start-process-unless-running)
  (add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
  (rtags-enable-standard-keybindings))

(use-package helm-rtags
  :config
  (setq rtags-display-result-backend 'helm))

(use-package company-rtags
  :init
  (setq rtags-autostart-diagnostics t)
  (setq rtags-completions-enabled t)
  :config
  (push 'company-rtags company-backends))

(use-package flycheck-rtags)

;; ===

;; === Haskell ===

(use-package intero
  :config
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
  (add-hook 'haskell-mode-hook 'intero-mode))

(use-package hindent
  :config
  (add-hook 'haskell-mode-hook 'hindent-mode))

;; ===

;; === Lisp ==

(use-package sly
  :init
  (setq inferior-lisp-program "sbcl"))

(use-package sly-company
  :config
  (add-hook 'sly-mode-hook 'sly-company-mode)
  (add-to-list 'company-backends 'sly-company))

;; ===

;; === Projectile ===

(use-package projectile
  :config
  (projectile-global-mode))

(use-package helm-projectile
  :config
  (helm-projectile-on))

;; ===

(global-set-key (kbd "M-o") 'other-window)

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

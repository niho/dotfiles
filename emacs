
;;; Code:

;; Never use tabs, please.
(setq-default indent-tabs-mode nil)
(setq-default typescript-indent-level 2)

;; Disable lock files.
(setq create-lockfiles nil)

;; Disable backup files.
(setq make-backup-files nil)

;; Show parens mode
(show-paren-mode 1)
(setq-default show-paren-style 'mixed)
(set-face-background 'show-paren-match "#aaaaaa")
(set-face-attribute 'show-paren-match nil
                    :weight 'bold :underline nil :overline nil :slant 'normal)
(set-face-background 'show-paren-mismatch "red")
(set-face-attribute 'show-paren-mismatch nil
                    :weight 'bold :underline t :overline nil :slant 'normal)

;; Fill column mode
(setq-default fill-column 80)

;; Org mode
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)


;; MELPA Package Manager
(require 'package)

(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(edts-man-root "/Users/niklas/.emacs.d/edts/doc/24.1")
 '(helm-completion-style 'emacs)
 '(package-selected-packages
   '(pug-mode swift-mode edts tide forge rjsx-mode protobuf-mode vue-mode editorconfig yasnippet dash exec-path-from-shell helm-lsp lsp-origami lsp-ui erlang hackernews graphql-mode gradle-mode typescript-mode treemacs-projectile treemacs-magit treemacs kubernetes kotlin-mode flycheck-dialyzer flycheck-gradle flycheck-kotlin which-key lsp-mode magit docker-compose-mode dockerfile-mode projectile helm evil-visual-mark-mode markdown-mode company-ghci company flycheck-tip flycheck-elm flycheck-haskell haskell-mode jdee))
 '(projectile-enable-caching t)
 '(projectile-use-git-grep t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Editorconfig
(editorconfig-mode 1)

;; Helm
(global-set-key (kbd "M-x") 'helm-M-x)
(helm-mode 1)

;; Projectile
(require 'projectile)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(projectile-mode +1)p

;; Ensure your Emacs environment looks like your user's shell one
(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

;; Language Server Protocol
(require 'lsp-mode)
(setq lsp-keymap-prefix "C-l") ;; Customize prefix for key-bindings
(setq lsp-log-io t) ;; Enable logging for lsp-mode

;; Enable and configure the LSP UI Package
(require 'lsp-ui)
(setq lsp-ui-sideline-enable t)
(setq lsp-ui-doc-enable t)
(setq lsp-ui-doc-position 'bottom)

;; Enable LSP Origami Mode (for folding ranges)
(require 'lsp-origami)
(add-hook 'origami-mode-hook #'lsp-origami-mode)
(add-hook 'erlang-mode-hook #'origami-mode)

;; Agda Mode
(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))

;; Haskell Mode
;(require 'haskell-mode)
;(define-key haskell-mode-map [f5] (lambda () (interactive) (compile "stack build --fast")))

;; Erlang Mode
(setq load-path (cons  "/usr/local/Cellar/erlang/24.0.5/lib/erlang/lib/tools-3.5/emacs" load-path))
(setq erlang-root-dir "/usr/local/Cellar/erlang/24.0.5")
(setq exec-path (cons "/usr/local/Cellar/erlang/24.0.5/bin" exec-path))
;(require 'erlang)
(require 'erlang-start)
(require 'flycheck-dialyzer)
;(add-hook 'erlang-mode-hook #'lsp)
(add-hook 'erlang-mode-hook 'flycheck-mode)
(add-hook 'erlang-mode-hook 'linum-mode) ;; Show line numbers
(add-hook 'erlang-mode-hook 'column-number-mode) ;; Show column numbers
(add-hook 'erlang-mode-hook #'display-fill-column-indicator-mode) ;; Show ruler at col 80

;; JDE (Java) Mode
;; (add-to-list 'load-path (format "%s/dist/jdee-2.4.1/lisp" my-jdee-path))
;;(autoload 'jde-mode "jde" "JDE mode" t)
;;(setq auto-mode-alist (append '(("\\.java\\'" . jde-mode)) auto-mode-alist))

;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup)
(eval-after-load 'flycheck '(flycheck-elm-setup))

;; Flycheck Tip
(require 'flycheck-tip)

;; Company (auto-complete)
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; Haskell auto-complete
;(require 'company-ghci)
;(push 'company-ghci company-backend)
;(add-hook 'haskell-mode-hook 'company-mode)

;; YAML mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))

;; Which Key Mode
(require 'which-key)
(which-key-mode)
(add-hook 'erlang-mode-hook 'which-key-mode)
(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))

;; Require and enable the Yasnippet templating system
(require 'yasnippet)
(yas-global-mode t)

(provide 'emacs)
;;; emacs ends here


;;; Code:

;; Never use tabs, please.
(setq-default indent-tabs-mode nil)

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
 '(package-selected-packages
   '(which-key lsp-mode magit docker-compose-mode dockerfile-mode projectile helm evil-visual-mark-mode markdown-mode company-ghci company-distel company flycheck-tip flycheck-elm flycheck-haskell haskell-mode jdee)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Helm
(global-set-key (kbd "M-x") 'helm-M-x)
(helm-mode 1)

;; Projectile
(require 'projectile)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(projectile-mode +1)

;; Projectile projects
(setq projectile-project-search-path '("~/jtc/" "~/hedvig/" y"~/ithaca/"))

;; Agda Mode
(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))

;; Haskell Mode
(require 'haskell-mode)
(define-key haskell-mode-map [f5] (lambda () (interactive) (compile "stack build --fast")))

;; Erlang Mode
(setq load-path (cons  "/usr/local/Cellar/erlang/23.2.5/lib/erlang/lib/tools-3.4.3/emacs/" load-path))
(setq erlang-root-dir "/usr/local/Cellar/erlang/23.2.5")
(setq exec-path (cons "/usr/local/Cellar/erlang/23.2.5/bin" exec-path))
(require 'erlang-start)

;; JDE (Java) Mode
;; (add-to-list 'load-path (format "%s/dist/jdee-2.4.1/lisp" my-jdee-path))
(autoload 'jde-mode "jde" "JDE mode" t)
(setq auto-mode-alist (append '(("\\.java\\'" . jde-mode)) auto-mode-alist))

;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup)
(eval-after-load 'flycheck '(flycheck-elm-setup))

;; Flycheck Tip
(require 'flycheck-tip)

;; Company (auto-complete)
(add-hook 'after-init-hook 'global-company-mode)

;; Haskell auto-complete
(require 'company-ghci)
(push 'company-ghci company-backend)
(add-hook 'haskell-mode-hook 'company-mode)

;; YAML mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))

;; Which Key Mode
(require 'which-key)
(which-key-mode)

(provide 'emacs)
;;; emacs ends here

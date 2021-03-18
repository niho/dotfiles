
;;; Code:

;; Never use tabs, please.
(setq-default indent-tabs-mode nil)

;; Show parens mode
(show-paren-mode 1)
(setq-default show-paren-style 'mixed)
(set-face-background 'show-paren-match "#aaaaaa")
(set-face-attribute 'show-paren-match nil
                    :weight 'bold :underline nil :overline nil :slant 'normal)
(set-face-background 'show-paren-mismatch "red")
(set-face-attribute 'show-paren-mismatch nil
                    :weight 'bold :underline t :overline nil :slant 'normal)


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
 '(helm-completion-style 'emacs)
 '(package-selected-packages
   '(hackernews graphql-mode gradle-mode typescript-mode treemacs-projectile treemacs-magit treemacs kubernetes kotlin-mode flycheck-dialyzer flycheck-gradle flycheck-kotlin which-key lsp-mode magit docker-compose-mode dockerfile-mode projectile helm evil-visual-mark-mode markdown-mode company-ghci company-distel company flycheck-tip flycheck-elm flycheck-haskell haskell-mode jdee))
 '(projectile-enable-caching t)
 '(projectile-use-git-grep t))
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
(setq projectile-project-search-path '("~/jtc/" "~/hedvig/" "~/ithaca/"))

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
(require 'flycheck-dialyzer)
(add-hook 'erlang-mode-hook 'flycheck-mode)

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

;; macOS Dark Mode support (does not seem to work)
;;(add-to-list 'load-path "~/.emacs.d/vendor/auto-dark-emacs/")
;;(require 'auto-dark-emacs)

(provide 'emacs)
;;; emacs ends here

(add-to-list 'load-path "~/.emacs.d/elisp/")

(when (> emacs-major-version 22)
  (require 'package)

  (let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                   (not (gnutls-available-p))))
          (proto (if no-ssl "http" "https")))
    ;; Comment/uncomment the next two statements to enable/disable
    ;; MELPA and MELPA Stable as desired
    ;; (add-to-list 'package-archives
    ;;   (cons "melpa" (concat proto "://melpa.org/packages/")) t)
    (add-to-list 'package-archives
      (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
    (when (< emacs-major-version 24)
      ;; For important compatibility libraries like cl-lib
      (add-to-list 'package-archives
        '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
  ;; (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

  ;; Added by Package.el.  This must come before configurations of
  ;; installed packages.  Don't delete this line.  If you don't want
  ;; it, just comment it out by adding a semicolon to the start of the
  ;; line.  You may delete these explanatory comments.
  (package-initialize)

  ;; ;; Configure apex-mode
  ;; (require 'apex-mode)

  ;; ;; Configure counsel-etags
  ;; (require 'counsel-etags)
  ;; (global-set-key (kbd "M-.") 'counsel-etags-find-tag-at-point)

  ;; ;; Configure docker-cli
  ;; (require 'docker-cli)

  ;; ;; Configure editorconfig-mode
  ;; (require 'editorconfig)
  ;; (editorconfig-mode 1)

  ;; ;; Configure eglot
  ;; (require 'eglot)
  ;; (add-hook 'c-mode-hook 'eglot-ensure)
  ;; (add-hook 'c++-mode-hook 'eglot-ensure)

  ;; ;; Configure helm-mode
  ;; (require 'helm-config)
  ;; (helm-mode 1)

  ;; ;; Configure mmm-mode
  ;; (require 'mmm-mode)
  ;; (setq mmm-global-mode 'maybe)
  ;; (mmm-add-mode-ext-class nil "\\.php\\'" 'html-php)
  ;; (mmm-add-classes
  ;;  '((html-php
  ;;     :submode php-mode
  ;;     :front "<\\?\\(php\\)?"
  ;;     :back "\\?>")))
  ;; (autoload 'php-mode "php-mode" "PHP editing mode" t)
  ;; (add-to-list 'auto-mode-alist '("\\.php\\'" . html-mode))

  ;; ;; Configure slime
  ;; (require 'slime-autoloads)
  ;; (setq inferior-lisp-program "sbcl")
  ;; (setq slime-contribs '(slime-fancy))

  ;; ;; Bootstrap use-package
  ;; (unless (package-installed-p 'use-package)
  ;;   (package-refresh-contents)
  ;;   (package-install 'use-package))
  ;; (require 'use-package-ensure)
  ;; (setq use-package-always-ensure t)

  ;; (use-package ace-window
  ;;   :ensure t
  ;;   :init
  ;;   (progn
  ;;     (global-set-key [remap other-window] 'ace-window)
  ;;     (custom-set-faces
  ;;       '(aw-leading-char-face
  ;;          ((t (:inherit ace-jump-face-foreground :height 3.0)))))
  ;;     ))

  ;; (use-package eterm-256color
  ;;   :ensure t
  ;;   :hook (term-mode . eterm-256color-mode))

  ;; (use-package lsp-mode
  ;;   :commands (lsp lsp-deferred)
  ;;   :config
  ;;   (lsp-enable-which-key-integration t)
  ;;   :hook ((c++-mode python-mode) . lsp-deferred)
  ;;   :init
  ;;   (setq lsp-keymap-prefix "C-c l"))

  ;; (use-package lsp-ui
  ;;   :commands lsp-ui-mode
  ;;   :config
  ;;   (setq lsp-ui-doc-enable nil)
  ;;   (setq lsp-ui-doc-header t)
  ;;   (setq lsp-ui-doc-include-signature t)
  ;;   (setq lsp-ui-doc-border (face-foreground 'default))
  ;;   (setq lsp-ui-sideline-show-code-actions t)
  ;;   (setq lsp-ui-sideline-delay 0.05))

  ;; (use-package projectile
  ;;   :bind-keymap
  ;;   ("C-c p" . projectile-command-map)
  ;;   :ensure t
  ;;   :config (projectile-mode)
  ;;   :diminish projectile-mode
  ;;   :init
  ;;   (when (file-directory-p "~/git")
  ;;     (setq project-project-search-path '("~/git")))
  ;;   (setq projectile-switch-project-action #'projectile-dired))

  ;; (use-package savehist
  ;;   :ensure t
  ;;   :init
  ;;   (savehist-mode))

  ;; (use-package try
  ;;   :ensure t)

  ;; (use-package vertico
  ;;   :ensure t
  ;;   :init
  ;;   (vertico-mode))

  ;; (use-package which-key
  ;;   :config (which-key-mode)
  ;;   :ensure t)

  ;; ;; Configure for macOS
  ;; (setq insert-directory-program "gls" dired-use-ls-dired t)
  ;; (setq mac-command-modifier 'meta)
  ;; (setq mac-option-modifier 'control)

  ;; ;; Configure PHP/Web mode toggle
  ;; (defun toggle-php-flavor-mode ()
  ;;   (interactive)
  ;;   "Toggle between PHP- and Web-Mode Helper modes"
  ;;   (cond ((eq major-mode 'php-mode)
  ;;          (web-mode))
  ;;         ((eq major-mode 'web-mode)
  ;;          (php-mode))))

  ;; ;; Set global keybindings
  ;; (global-set-key [f5] 'toggle-php-flavor-mode)
  ;; (global-set-key (kbd "C-x g") 'magit-status)
  )

;; ;; Configure input-decode-map
;; (defun terminal-init-screen ()
;;   "Terminal initialization function for GNU screen."
;;   (when (boundp 'input-decode-map)
;;     (define-key input-decode-map "^[[1;5C" [(control right)])
;;     (define-key input-decode-map "^[[1;5D" [(control left)])))

;; Default to indenting with spaces (rather than tabs)
(setq-default indent-tabs-mode nil)

;; Set C default style
(setq c-default-style "bsd")

;; Override default major mode according to file name pattern
(add-to-list 'auto-mode-alist '("Pipfile.lock\\'" . javascript-mode))
(add-to-list 'auto-mode-alist '("Pipfile\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.clang-tidy\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.env-.+\\'" . dotenv-mode))
(add-to-list 'auto-mode-alist '("\\.fish\\'" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.gmk\\'" . makefile-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.lst\\'" . fundamental-mode))
(add-to-list 'auto-mode-alist '("\\.pylintrc\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("pylintrc\\'" . conf-mode))

;; Customizations follow

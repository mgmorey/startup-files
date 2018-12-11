(require 'package)

(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq inferior-lisp-program "sbcl")
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'control)
(setq slime-contribs '(slime-fancy))

;; (require 'helm-config)
;; (require 'slime-autoloads)

(global-set-key (kbd "C-x g") 'magit-status)
;; (helm-mode 1)

(add-to-list 'auto-mode-alist '("Pipfile\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("Pipfile.lock\\'" . javascript-mode))


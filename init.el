(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(setq backup-directory-alist `(("." ,(expand-file-name  "backups" user-emacs-directory)))
      custom-file "custom.el")
(setq-default indent-tabs-mode nil)
(electric-pair-mode)
(setq ring-bell-function #'ignore)
(setcdr (assoc 'truncation fringe-indicator-alist) '(nil nil))
(add-hook 'prog-mode-hook (lambda ()
                            (setq truncate-lines t)
                            (setq left-fringe-width 1) ;; 0 creates '$'s
                            (display-line-numbers-mode)))

(use-package latex
  :ensure auctex)

(use-package cdlatex
  :ensure t)

(use-package org
  :vc (org-mode :url "https://git.tecosaur.net/tec/org-mode" :lisp-dir "lisp")
  :hook
  (org-mode . org-cdlatex-mode)
  (org-mode . org-latex-preview-auto-mode)
  (org-mode . (lambda () (electric-indent-local-mode -1)))
  :custom
  (org-special-ctrl-k t)
  (org-special-ctrl-a/e t)
  (org-insert-heading-respect-content t)
  (org-startup-with-latex-preview t)
  (org-hide-emphasis-markers t)
  (org-latex-preview-appearance-options
   '(:foreground auto
     :background "Transparent"
     :scale 1.0
     :zoom 1.2
     :page-width 1.0
     :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))
  :custom-face
  (org-document-title ((t (:height 2.0))))
  (org-level-1 ((t (:inherit outline-1 :height 1.5))))
  (org-level-2 ((t (:inherit outline-2 :height 1.3))))
  (org-level-3 ((t (:inherit outline-3 :height 1.1)))))

(use-package org-indent
  :after org
  :custom
  (org-indent-indentation-per-level 0)
  (org-indent-mode-turns-on-hiding-stars nil)
  :hook
  (org-mode . org-indent-mode))

(use-package org-modern
  :config
  (global-org-modern-mode)
  :ensure t)

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode))

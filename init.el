;; setup MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; detect external changes & update file buffers
(global-auto-revert-mode t)
;; use spaces over tabs
(setq-default indent-tabs-mode nil)
;; don't hurt my eardrums when I hit EOF
(setq ring-bell-function #'ignore)
;; put FILENAME~ files in `user-emacs-directory'
(setq backup-directory-alist `(("." . ,(expand-file-name  "backups" user-emacs-directory))))
;; put customizations in some random file in `user-emacs-directory'
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(delete-selection-mode)

;; better visual experience for code buffers
(setcdr (assoc 'truncation fringe-indicator-alist) '(nil nil)) ; personally don't like indicators for truncated (long) lines
(add-hook 'prog-mode-hook (lambda ()
                            (setq truncate-lines t)
                            (setq left-fringe-width 1) ;; 0 creates '$'s
                            (display-line-numbers-mode)))

(electric-pair-mode)

;; prevent cursor from entering minibuffer prompt
;; e.g "|M-x "
;; contrived example: M-x C-: (goto-char 0) <CR> and then type
(setq minibuffer-prompt-properties
      '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)
(setq enable-recursive-minibuffers t) ; this is useful sometimes

;; best plugin ever
(use-package spotify
  :vc (emacs-spotify :url "https://github.com/SnootierMoon/emacs-spotify"))

;; neat completion plugin, integrates well w/ Emacs
(use-package vertico
  :ensure t
  :config
  (vertico-mode))

;; fast latex editing
(use-package cdlatex
  :ensure t
  :custom
  (cdlatex-use-dollar-to-ensure-math nil)
  (cdlatex-math-symbol-prefix ?\')
  (cdlatex-math-modify-prefix ?\")
  (cdlatex-math-modify-alist '((?B "\\mathbb" nil t nil nil)))
  (cdlatex-modify-backwards nil)) ; cool idea, but haven't gotten familiar w it yet

(defun my/org-cdlatex-math-symbol (&optional _arg)
  "Execute `cdlatex-math-symbol' in LaTeX fragments.
Revert to the normal definition outside of these fragments.

Reference: `org-cdlatex-math-modify'."
  (interactive "P")
  (if (org-inside-LaTeX-fragment-p)
      (call-interactively 'cdlatex-math-symbol)
    (let (org-cdlatex-mode)
      (call-interactively (key-binding (vector last-input-event))))))

;; newest Org for cool Org/latex edit & preview
(use-package org
  :vc (org-mode :url "https://git.tecosaur.net/tec/org-mode" :lisp-dir "lisp")
  :hook
  (org-mode . org-cdlatex-mode)
;; (org-mode . (lambda () (electric-indent-local-mode -1)))
  (org-mode . visual-line-mode) ; wrap lines in a nice way
  :bind
  (:map org-cdlatex-mode-map
        ("'" . my/org-cdlatex-math-symbol) ; ' for cdlatex symbols
        ("\"" . org-cdlatex-math-modify)) ; " for cdlatex modify
  :custom
  (org-special-ctrl-k t) ; fire
  (org-special-ctrl-a/e t) ; banger
  (org-insert-heading-respect-content t) ; epic
  (org-startup-with-latex-preview t) ; amazing
  (org-hide-emphasis-markers t) ; YES
  (org-latex-packages-alist '(("" "amssymb" t) ("" "amsmath" t)))
  :custom-face
  (org-document-title ((t (:height 2.0))))
  (org-level-1 ((t (:inherit outline-1 :height 1.5))))
  (org-level-2 ((t (:inherit outline-2 :height 1.3))))
  (org-level-3 ((t (:inherit outline-3 :height 1.1))))
  :config
  ;;  (modify-syntax-entry ?< "." org-mode-syntax-table)
  ;;  (modify-syntax-entry ?> "." org-mode-syntax-table)
  )

;; auto latex previewing
(use-package org-latex-preview
  :after org
  :hook
  (org-mode . org-latex-preview-auto-mode)
  :custom
  (org-latex-create-formula-image-program 'dvipng)
  (org-latex-preview-preamble "\\documentclass[leqno]{article}\n[DEFAULT-PACKAGES]\n[PACKAGES]\n\\usepackage{xcolor}")
  :config
  (plist-put org-latex-preview-appearance-options :zoom 1.2))

;; goated for lists
(use-package org-indent
  :after org
  :custom
  (org-indent-indentation-per-level 0)
  (org-indent-mode-turns-on-hiding-stars nil)
  :hook
  (org-mode . org-indent-mode))


;; make various org symbols look better
(use-package org-modern
  :config
  (global-org-modern-mode)
  :ensure t)

(use-package org-roam
  :ensure t
  :custom
  (org-roam-capture-templates
   '(("d" "default" plain "%?"
      :target (file+head "${slug}.org" "#+TITLE: ${title}\n")
      :unnarrowed t)))
  (org-roam-directory "~/Math/notes")
  :config
  (org-roam-db-autosync-enable))

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode))

;;; snoot.el --- Helpful elisp code
;;; Commentary:
;;; Code:

(require 'org)

(defconst snoot/init-org-file
  (expand-file-name "README.org" user-emacs-directory))
(defconst snoot/init-lisp-dir
  (expand-file-name "lisp" user-emacs-directory))
(defconst snoot/easy-keys
  '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?e ?r ?u ?i))

(defvar snoot/theme-loaded nil)

(defun snoot/tangle-readme ()
  "Tangle README.org and generate elisp files."
  (require 'org)
  (make-directory snoot/init-lisp-dir :parents)
  (org-babel-tangle-file snoot/init-org-file))

;; REMINDER: kill-this-buffer is bronked:
;; https://www.reddit.com/r/emacs/comments/64xb3q/killthisbuffer_sometimes_just_stops_working/
(defun snoot/kill-current-buffer ()
  "Delete the current buffer."
  (interactive)
  (kill-buffer (current-buffer)))

(defun snoot/reformat-buffer (arg)
  "`indent-region' the current buffer and remove trailing whitespace.

Additionally, if ARG is non-nil, `fill-column' the buffer as
well."
  (interactive "P")
  (save-excursion
    (if (eq major-mode 'org-mode)
	(org-indent-region (point-min) (point-max))
      (indent-region (point-min) (point-max)))
    (delete-trailing-whitespace)))



(provide 'snoot)
;;; snoot.el ends here

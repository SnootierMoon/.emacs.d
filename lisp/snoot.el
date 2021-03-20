;;; snoot.el --- Init code written by me
;;; Commentary:
;;; Code:

(require 'org)

(defconst snoot/init-org-file (expand-file-name "README.org" user-emacs-directory))
(defconst snoot/init-lisp-dir (expand-file-name "lisp" user-emacs-directory))
(defconst snoot/easy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?e ?r ?u ?i))

(defun snoot/tangle-readme ()
  "Tangle README.org and generate elisp files."
  (require 'org)
  (make-directory snoot/init-lisp-dir :parents)
  (org-babel-tangle-file snoot/init-org-file))

(defun snoot/indent-buffer ()
  "Indent the current buffer with `indent-region'."
  (interactive)
  (indent-region (point-min) (point-max))
  (delete-trailing-whitespace))

(provide 'snoot)
;;; snoot.el ends here

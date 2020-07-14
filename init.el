;;; init.el --- Initialize emacs

;;; Commentary:

;; This file only loads .emacs.d/etc/config.org with org-babel.
;; Packages and configurations are in .emacs.d/etc/config.org.
;; The .emacs.d/etc directory is also `no-littering-etc-directory'.

;;; Code:

(org-babel-load-file (expand-file-name (concat user-emacs-directory "etc/config.org")))

(provide 'init)
;;; init.el ends here

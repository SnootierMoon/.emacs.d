(setq inhibit-startup-message t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)

(add-to-list 'default-frame-alist '(font . "Liberation Mono"))

(load-theme 'modus-vivendi)

(setq-default cursor-type 'bar)

(setq inhibit-startup-message t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)

(set-face-attribute 'default nil :font "Liberation Mono" :height 120)

(load-theme 'modus-vivendi)

(setq-default cursor-type 'bar)

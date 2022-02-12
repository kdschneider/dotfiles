;; My emacs config

;; User Interface

(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)

(menu-bar-mode -1)

(setq visible-bell t)


;; Font

(set-face-attribute 'default nil :family "FiraCode Nerd Font Mono" :height 180)

;; Theme
(load-theme 'wombat)

;; Escape quit
(global-set-key (kbd "<escape>") 'keyboard-escape-qui
;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)


;; Command log
(use-package command-log-mode)


;; Ivy
(use-package ivy
  :diminish
  :config
  (ivy-mode 1))


;; Modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

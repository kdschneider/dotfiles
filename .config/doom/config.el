;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;
;; DOOM EMACS CONFIGURATION
;; AUTHOR: KONSTANTIN SCHNEIDER
;;

;; IDENT
(setq user-full-name "Konstantin Schneider"
      user-mail-address "ks@konstantin-schneider.eu")

;; FONT
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 15)
      doom-big-font (font-spec :family "FiraCode Nerd Font" :size 20)
      doom-variable-pitch-font (font-spec :family "Overpass Nerd Font" :size 15))

;; THEME
(setq doom-theme 'doom-dracula)

;; ORG
(setq org-directory "~/org/")

;; LINE NUMBERS
(setq display-line-numbers-type 'relative)

;; WINDOW SIZE
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
;;(setq initial-frame-alist '((top . 1) (left . 1) (width . 143) (height . 55)))


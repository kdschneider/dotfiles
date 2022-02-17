(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ;; ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  (auto-package-update-show-preview t)
  (auto-package-update-delete-old-versions t)
  :config
  (auto-package-update-at-time "09:00")
  (auto-package-update-maybe))

(use-package general
  :config
  (general-create-definer kds/spc-leader
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")
  (general-create-definer kds/ctrl-c-keys
    :prefix "C-c"))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(defconst IS-MAC     (eq system-type 'darwin))
(defconst IS-LINUX   (eq system-type 'gnu/linux))
(defconst IS-WINDOWS (memq system-type '(cygwin windows-nt ms-dos)))
(defconst IS-BSD     (or IS-MAC (eq system-type 'berkeley-unix)))

(cond
 (IS-MAC
  (setq mac-command-modifier      'super
  ns-command-modifier       'super
  mac-option-modifier       'meta
  ns-option-modifier        'meta
  mac-right-option-modifier 'none
  ns-right-option-modifier  'none))
 (IS-WINDOWS
  (setq w32-lwindow-modifier 'super
  w32-rwindow-modifier 'super)))

(kds/spc-leader
  "t" '(:ignore t :which-key "toggles")
  "tw" '(whitespace-mode :which-key "whitespace")
  "tt" '(counsel-load-theme :which-key "choose theme")
  "te" '(global-emojify-mode :which-key "emojis"))

(setq tramp-default-method "ssh")

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-respect-visual-line-mode t)
  (setq evil-undo-system 'undo-tree)

  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (defun kds/dont-arrow-me-bro ()
    (interactive)
    (message "Arrows are bad, ma dude.."))

  ;; Disable arrow keys in normal and visual modes
  (define-key evil-normal-state-map (kbd "<left>") 'kds/dont-arrow-me-bro)
  (define-key evil-normal-state-map (kbd "<right>") 'kds/dont-arrow-me-bro)
  (define-key evil-normal-state-map (kbd "<down>") 'kds/dont-arrow-me-bro)
  (define-key evil-normal-state-map (kbd "<up>") 'kds/dont-arrow-me-bro)
  (evil-global-set-key 'motion (kbd "<left>") 'kds/dont-arrow-me-bro)
  (evil-global-set-key 'motion (kbd "<right>") 'kds/dont-arrow-me-bro)
  (evil-global-set-key 'motion (kbd "<down>") 'kds/dont-arrow-me-bro)
  (evil-global-set-key 'motion (kbd "<up>") 'kds/dont-arrow-me-bro)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package undo-tree
  :config (global-undo-tree-mode))

(global-set-key (kbd "C-M-u") 'universal-argument)

(use-package hydra)

(setq inhibit-startup-message t)

(scroll-bar-mode 0)
(tool-bar-mode 0)
(tooltip-mode 0)

(set-fringe-mode 10)
(set-frame-parameter nil 'internal-border-width 10)

(menu-bar-mode -1)

(setq visible-bell t)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))  ; one line at a time
(setq mouse-wheel-progressive-speed nil)             ; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't)                   ; scroll window under mouse
(setq scroll-step 1) ; keyboard scroll one line at a time
(setq use-dialog-box nil) ; Disable dialog boxes since they weren't working in Mac OSX

(set-frame-parameter (selected-frame) 'alpha '(85 . 85))
(add-to-list 'default-frame-alist '(alpha . (85 . 85)))
 ;;(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
 ;;(add-to-list 'default-frame-alist '(fullscreen . maximized))

(set-face-attribute 'default nil
		    :font "FiraCode Nerd Font Mono"
		    :weight 'light
		    :height 200)

(set-face-attribute 'fixed-pitch nil
		    :font "FiraCode Nerd Font Mono"
		    :weight 'light
		    :height 200)

(set-face-attribute 'variable-pitch nil
		    :font "FiraCode Nerd Font"
		    :weight 'light
		    :height 200)

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (doom-themes-visual-bell-config)
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(use-package zenburn-theme)

(load-theme 'doom-dracula t)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 18)
  (setq doom-modeline-bar-width 4)
  (setq doom-modeline-hud nil)
  (setq doom-modeline-window-width-limit fill-column)
  (setq doom-modeline-project-detection 'projectile)
  (setq doom-modeline-buffer-file-name-style 'name)
  (setq doom-modeline-major-mode-icon t)
  (setq doom-modeline-major-mode-color-icon t)
  (setq doom-modeline-buffer-state-icon t)
  (setq doom-modeline-buffer-modification-icon t)
  (setq doom-modeline-minor-modes nil)
  (setq doom-modeline-enable-word-count t)
  (setq doom-modeline-continuous-word-count-modes '(text-mode markdown-mode org-mode))
  (setq doom-modeline-lsp t))

(use-package all-the-icons)

(use-package dashboard
  :init
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title nil)
  (setq dashboard-project-backend 'projectile)
  (setq dashboard-center-content t)
  (setq dashboard-items '((recents . 5)
                          (agenda . 5)
                          (bookmarks . 3)
                          (projects . 3)))
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-set-navigator t)
  :config
  (dashboard-setup-startup-hook))

(use-package emojify
  :hook erc-mode)

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package command-log-mode)

(use-package alert
  :custom alert-default-style 'notifications)

(setq large-file-warning-threshold nil)
;;(setq vc-follow-symlinks t)
(setq ad-redefinition-action 'accept)

(setq auto-save-default nil)

(use-package super-save
  :config
  (super-save-mode +1)
  (setq super-save-auto-save-when-idle t))

(visual-line-mode 1)

(setq-default tab-width 2)
(setq-default evil-shift-width tab-width)

(setq-default indent-tabs-mode nil)

(use-package origami
	:hook yaml-mode)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package evil-nerd-commenter)

(defun kds/org-mode-visual-fill ()
  (interactive)
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . kds/org-mode-visual-fill))

(column-number-mode 1)

;; Enable line numbers for some modes
(dolist (mode '(text-mode-hook
		prog-mode-hook
		conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))

;; Override some modes which derive from the above
(dolist (mode '(org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package ivy
  :diminish
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind
  (("M-x" . counsel-M-x)
   ("C-x C-b" . counsel-switch-buffer)
   ("C-x C-f" . counsel-find-file)))

(use-package company)

(use-package all-the-icons-dired)
(use-package dired-single)
(use-package dired-ranger)
(use-package dired-collapse)

(setq dired-listing-switches "-agho --group-directories-first"
      dired-omit-files "^\\.[^.].*"
      dired-omit-verbose nil
      dired-hide-details-hide-symlink-targets nil
      delete-by-moving-to-trash t)

(autoload 'dired-omit-mode "dired-x")

(add-hook 'dired-load-hook
	  (lambda ()
	    (interactive)
	    (dired-collapse)))

(add-hook 'dired-mode-hook
	  (lambda ()
	    (interactive)
	    (dired-omit-mode 1)
	    (dired-hide-details-mode 1)
	    (all-the-icons-dired-mode 1))
	    (hl-line-mode 1))

(evil-collection-define-key 'normal 'dired-mode-map
  "h" 'dired-single-up-directory
  "H" 'dired-omit-mode
  "l" 'dired-single-buffer
  "y" 'dired-ranger-copy
  "X" 'dired-ranger-move
  "p" 'dired-ranger-paste)

(use-package treemacs)

;; This is ugly af and keeps breaking.
;; TODO: Try to org-modules on their own.
(defun kds/org-mode-setup ()
  (interactive)
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-mode 1))
;; (diminish org-indent-mode))           


(use-package org
  :hook (kds/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")
  (setq org-agenda-files '("~/Cloud/org/agenda"))
  (setq org-hide-emphasis-markers t)
  (setq org-src-fontify-natively t)
  (setq org-fontify-quote-and-verse-blocks t)
  (setq org-src-tab-acts-natively t)
  (setq org-hide-block-startup nil)
  (setq org-src-preserve-indentation nil)
  (setq org-startup-folded t)
  (setq org-cycle-separator-lines 2)
  (setq org-capture-bookmark nil)

  ;; Org Modules
  (setq org-modules '(org-crypt
                      org-habit
                      org-bookmark
                      org-eshell
                      org-irc
                      org-indent
                      org-tempo))

  (setq org-outline-path-complete-in-steps nil)
  (setq org-refile-use-outline-path t)

  (evil-define-key '(normal insert visual) org-mode-map (kbd "C-j") 'org-next-visible-heading)
  (evil-define-key '(normal insert visual) org-mode-map (kbd "C-k") 'org-previous-visible-heading)

  (evil-define-key '(normal insert visual) org-mode-map (kbd "M-j") 'org-metadown)
  (evil-define-key '(normal insert visual) org-mode-map (kbd "M-k") 'org-metaup)

  ;; Structure Templates
  (add-to-list 'org-structure-template-alist '("sh" . "src sh"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("li" . "src lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("r" . "src r"))

  ;; Fonts and Faces
  (set-face-attribute 'org-document-title nil
                      :font "FiraCode Nerd Font"
                      :weight 'bold
                      :height 1.3)

  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil
                        :font "FiraCode Nerd Font"
                        :weight 'medium
                        :height (cdr face)))

  ;; ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  ;; (set-face-attribute 'org-block nil
  ;;                     :foreground nil
  ;;                     :inherit 'fixed-pitch)
  ;; (set-face-attribute 'org-table nil
  ;;                     :inherit 'fixed-pitch)
  ;; (set-face-attribute 'org-formula nil
  ;;                     :inherit 'fixed-pitch)
  ;; (set-face-attribute 'org-code nil
  ;;                     :inherit '(shadow fixed-pitch))
  ;; ;;(set-face-attribute 'org-indent nil
  ;; ;;                    :inherit '(org-hide fixed-pitch))
  ;; (set-face-attribute 'org-verbatim nil
  ;;                     :inherit '(shadow fixed-pitch))
  ;; (set-face-attribute 'org-special-keyword nil
  ;;                     :inherit '(font-lock-comment-face fixed-pitch))
  ;; (set-face-attribute 'org-meta-line nil
  ;;                     :inherit '(font-lock-comment-face fixed-pitch))
  ;; (set-face-attribute 'org-checkbox nil
  ;;                     :inherit 'fixed-pitch)

  ;; ;; Get rid of the background on column views
  ;; (set-face-attribute 'org-column nil
  ;;                     :background nil)
  ;; (set-face-attribute 'org-column-title nil
  ;;                     :background nil))
  )

(use-package org-superstar
  :after org
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-leading-bullet ?\s
        org-superstar-leading-fallback ?\s
        org-hide-leading-stars nil
        org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●")))

(use-package org-make-toc
  :after org)

(use-package org-roam
  :after org
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Cloud/org")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert))
  :config
  (org-roam-setup))

(use-package org-auto-tangle
  :hook (org-mode . org-auto-tangle-mode))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (setq projectile-project-search-path '("~/"))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(kds/spc-leader
"p" '(projectile-command-map :which-key "projectile"))

(kds/spc-leader
"b" '(:ignore t :which-key "buffer")
"bb" '(counsel-switch-buffer :which-key "switch buffer"))

(kds/spc-leader
"w" '(:ignore t :which-key "window")
"ww" '(evil-window-next :which-key "next window")
"wc" '(evil-window-close :which-key "close window"))

(use-package rg)

(use-package magit)

(use-package forge
  :after magit
  :disabled)

(use-package lsp-mode)

(use-package polymode)
(use-package poly-markdown)
(use-package poly-R)

(add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-R-mode))

(use-package ess)

(use-package ess)

(use-package eww)

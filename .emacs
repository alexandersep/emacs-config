; Silent's .emacs configuration file

;; Initialize/require/load packages
(package-initialize)
(require 'package)
(require 'evil-leader)
(require 'evil)
(require 'recentf)
(require 'haskell-mode)
(require 'haskell-interactive-mode)
(require 'haskell-process)
;;(require 'hindent)
;;(require 'lsp)
;;(require 'lsp-haskell)

;; Add package manager melpa to emacs and refresh archive
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;(package-refresh-contents)

;; Backup and Autosave Directories
(setq temporary-file-directory "~/.tmp/")
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; disable splash screen
(setq inhibit-startup-screen t)
;; disable menu bar
(menu-bar-mode 0)
;; disable tool bar mode
(tool-bar-mode 0)
;; remove scroll bar
(scroll-bar-mode 0)
;; show parenthesis
(show-paren-mode 1)
;; set numberline
;; enable relative number
(global-display-line-numbers-mode)  
(setq display-line-numbers-type 'relative)  
(setq-default display-line-numbers-width 3)
(setq-default indicate-empty-lines t)
;; Do not split window vertically
;;(setq split-height-threshold 9999) 
;; Splitting horizontal is more likely
;;(setq split-width-threshold 0)   
;;(setq scroll-step 1)
;;(setq scroll-margin 1)
;;(setq scroll-step            1
;;      scroll-conservatively  10000)
(setq scroll-margin 1
  scroll-conservatively 0
  scroll-up-aggressively 0.01
  scroll-down-aggressively 0.01)
(setq-default scroll-up-aggressively 0.01
  scroll-down-aggressively 0.01)

;; Set theme for emacs
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(gruber-darker))
 '(custom-safe-themes
   '("3d2e532b010eeb2f5e09c79f0b3a277bfc268ca91a59cdda7ffd056b868a03bc" default))
 '(package-selected-packages
   '(lsp-haskell lsp-mode hindent haskell-mode evil-leader gruber-darker-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Forces the messages to 0, and kills the *Messages* buffer - thus disabling it on startup.
(setq-default message-log-max nil)
(kill-buffer "*Messages*")
;; Disabled *Completions*
(add-hook 'minibuffer-exit-hook 
      '(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
            (kill-buffer buffer)))))

;; Evil related configuartions

;; Enable Evil
(evil-mode 1)
;; Ctrl+W switches buffers
(setq evil-want-C-w-delete nil evil-want-C-w-in-emacs-state t) 
;;(evil-set-initial-state 'interactive-haskell-mode 'emacs)
;;(term-send-esc)
;;(evil-local-mode 1)
;;(evil-initialize)

;; set leader space key
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>") 
(evil-leader/set-key
  "-" 'shrink-window-if-larger-than-buffer
  "+" 'balance-windows
  "^" 'enlarge-window
  "xkxk" 'kill-buffer-and-window
  "xe" 'eval-last-sexp
  "ff" 'find-file
  "fr" 'recentf-open-files
  "bn" 'next-buffer
  "bp" 'previous-buffer
  "h'" 'describe-char
  "hk" 'describe-key
  "hv" 'describe-variable
  "<ESC>" 'delete-other-windows
  "ho" 'describe-symbol 
  "hf" 'describe-function
  "cz" 'haskell-interactive-switch-back
;;  "xo" 'other-window
  "cl" 'haskell-process-load-file)

;; Haskell configuration
(setq haskell-interactive-popup-errors nil)
;;(add-hook 'haskell-mode-hook 'haskell-indent-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode) 
(add-hook 'haskell-mode-hook 'haskell-doc-mode)
;;(add-hook 'haskell-mode-hook 'hindent-mode)
;;(add-hook 'haskell-mode-hook #'lsp)
;;(add-hook 'haskell-literate-mode-hook #'lsp)
;;(evil-set-initial-state 'bs-mode 'emacs)
;;(evil-set-initial-state 'interactive-haskell-mode 'emacs) ;; Major mode only
;;(set-evil-initial-state 'interactive-haskell-mode 'emacs)
;;(add-hook 'interactive-haskell-mode-hook 'turn-off-evil-mode) ;; Minor mode 
;;(evil-set-initial-state 'interactive-haskell-mode 'emacs)
;;(add-hook 'haskell-interactive-mode-hook
;;          (lambda () (local-set-key (kbd "xo") #'otherwindow)))
;;(add-hook 'text-mode-hook 'turn-on-auto-fill)
;;(add-hook 'prog-mode-hook 'hs-minor-mode)
;;(add-hook 'haskell-interactive-mode-hook 'emacs)
;;(define-key haskell-mode-map (kbd "C-c C-l") 'haskell-interactive-mode-clear)
;;(eval-after-load ' '(progn
;;  (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
;;(define-key interactive-haskell-mode-map (kbd "M-.") 'haskell-mode-goto-loc)
;;(define-key interactive-haskell-mode-map (kbd "C-c C-t") 'haskell-mode-show-type-at)
;;(defun interactive-haskell-mode-hook ()
;;   (evil-mode -1))
;;(add-hook 'haskell-mode-hook (lambda () (evil-mode -1)))



(defun haskell-evil-open-above ()
  (interactive)
  (evil-digit-argument-or-evil-beginning-of-line)
  (haskell-indentation-newline-and-indent)
  (evil-previous-line)
  (haskell-indentation-indent-line)
  (evil-append-line nil))

(defun haskell-evil-open-below ()
  (interactive)
  (evil-append-line nil)
  (haskell-indentation-newline-and-indent))

  (evil-define-key 'normal haskell-mode-map "o" 'haskell-evil-open-below
                                            "O" 'haskell-evil-open-above)

(setq split-width-threshold nil)
(setq split-height-threshold 0)

;; Enable recentf
(recentf-mode 1)



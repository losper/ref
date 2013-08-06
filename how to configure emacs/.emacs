(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
 (add-hook 'c-mode-common-hook ( lambda() ( c-set-style "k&r" ) ) ) 
 (add-hook 'c++-mode-common-hook ( lambda() ( c-set-style "k&r" ) ) )  
  
  (c-set-offset 'inline-open 0)  
  (c-set-offset 'friend '-)  
  (c-set-offset 'substatement-open 0)
  
  
  (autoload 'senator-try-expand-semantic "senator")
 
  (setq hippie-expand-try-functions-list
  '(
    senator-try-expand-semantic
    try-expand-dabbrev
    try-expand-dabbrev-visible
    try-expand-dabbrev-all-buffers
    try-expand-dabbrev-from-kill
    try-expand-list
    try-expand-list-all-buffers
    try-expand-line
    try-expand-line-all-buffers
    try-complete-file-name-partially
    try-complete-file-name
    try-expand-whole-kill
    )
  )
      
  ;;(defun my-indent-or-complete ()
  ;; (interactive)
  ;;  (if (looking-at "\\>")
  ;;      (hippie-expand nil)
  ;;    (indent-for-tab-command))
  ;;)
  
  (defadvice push-mark (around semantic-mru-bookmark activate)
    "Push a mark at LOCATION with NOMSG and ACTIVATE passed to `push-mark'.
    If `semantic-mru-bookmark-mode' is active, also push a tag onto
    the mru bookmark stack."
    (semantic-mrub-push semantic-mru-bookmark-ring
                        (point)
                        'mark)
  ad-do-it)
  
  (defun semantic-ia-fast-jump-back ()
    (interactive)
    (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
        (error "Semantic Bookmark ring is currently empty"))
    (let* ((ring (oref semantic-mru-bookmark-ring ring))
           (alist (semantic-mrub-ring-to-assoc-list ring))
           (first (cdr (car alist))))
      (if (semantic-equivalent-tag-p (oref first tag) (semantic-current-tag))
          (setq first (cdr (car (cdr alist)))))
      (semantic-mrub-switch-tags first)
    )
  )
    
  (defun my-c-mode-common-hook()
    (setq semantic-default-submodes '(
      global-semanticdb-minor-mode
      global-semantic-idle-scheduler-mode
      global-semantic-idle-summary-mode
      global-semantic-idle-completions-mode
      global-semantic-highlight-func-mode
      global-semantic-stickyfunc-mode
      global-semantic-mru-bookmark-mode))
    (semantic-mode 1)
    (global-ede-mode 1)
    (require 'eassist nil 'noerror)
    
    (global-semantic-highlight-edits-mode (if window-system 1 -1))
    (global-semantic-show-unmatched-syntax-mode 1)
    (global-semantic-show-parser-state-mode 1)
    
    (setq tab-width 4 indent-tabs-mode nil)  
    (c-toggle-auto-hungry-state 1)  
   
    (define-key c-mode-base-map [(f4)] 'speedbar)
    (define-key c-mode-base-map [(f7)] 'compile)
    (define-key c-mode-base-map [(return)] 'newline-and-indent)
    (define-key c-mode-base-map [(meta ?/)] 'semantic-ia-complete-symbol)
    (define-key c-mode-base-map [(f12)] 'semantic-ia-fast-jump)
    (define-key c-mode-base-map [(control f12)] 'semantic-ia-fast-jump-back)
    
    ;; (setq semanticdb-project-roots (list (expand-file-name "/")))
    (defconst cedet-user-include-dirs
    (list ".." "../include" "../inc" "../common" "../public"
          "../.." "../../include" "../../inc" "../../common" "../../public"))
    (defconst cedet-win32-include-dirs
    (list "D:/app/cygwin/usr/include"
          "D:/Program Files/ms/VC/include"))
    (require 'semantic-c nil 'noerror)
    (let ((include-dirs cedet-user-include-dirs))
    (when (eq system-type 'windows-nt)
      (setq include-dirs (append include-dirs cedet-win32-include-dirs)))
    (mapc (lambda (dir)
            (semantic-add-system-include dir 'c++-mode)
            (semantic-add-system-include dir 'c-mode))
          include-dirs))
          
    (define-key c-mode-base-map [f11] 'eassist-switch-h-cpp)
  )
  (add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

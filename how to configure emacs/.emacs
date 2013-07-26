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
  (defun my-c-mode-common-hook()
    (setq tab-width 4 indent-tabs-mode nil)  
    (c-toggle-auto-hungry-state 1)  
   
    (define-key c-mode-base-map [(control tab)] 'my-indent-or-complete)
    (define-key c-mode-base-map [(f7)] 'compile)
    (define-key c-mode-base-map [(meta ?/)] 'semantic-ia-complete-symbol-menu)
  )
  (add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
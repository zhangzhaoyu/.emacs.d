;; self setting
(custom-set-variables
 '(menu-bar-mode nil)
 '(auto-fill-mode nil)
 '(transilent-mark-mode t)
 )

;; (global-linum-mode t)
;; (setq line-number-mode t)
;; (setq x-select-enable-clipboard t)
;; (setq backup-by-copying nil)

(setq make-backup-files nil)

;;--------------------------------------------------------
;; keyboard shortcuts setting
;---------------------------------------------------------
(global-set-key (kbd "C-c m") 'set-mark-command)
(global-set-key (kbd "M-g") 'goto-line)

(provide 'init-local)

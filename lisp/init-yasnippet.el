(defun my-yas-expand ()
  (interactive)
  (unless (bound-and-true-p yas-global-mode)
    (yas-global-mode 1))

  (if (buffer-file-name)
      (let ((ext (car (cdr (split-string (buffer-file-name) "\\."))) )
            (old-yas-flag yas-indent-line))
        (if (or (string= ext "ftl") (string= ext "jsp"))
          (setq yas-indent-line nil))
        (yas-expand)
        ;; restore the flag
        (setq yas-indent-line old-yas-flag))
    (yas-expand)))

;; default TAB key is occupied by auto-complete
(global-set-key (kbd "C-c k") 'my-yas-expand)

(eval-after-load 'yasnippet
  '(progn
     ;; http://stackoverflow.com/questions/7619640/emacs-latex-yasnippet-why-are-newlines-inserted-after-a-snippet
     (setq-default mode-require-final-newline nil)

     ;; my private snippets
     (setq my-yasnippets (expand-file-name "~/my-yasnippets"))
     (if (and  (file-exists-p my-yasnippets) (not (member my-yasnippets yas/snippet-dirs)))
         (add-to-list 'yas/snippet-dirs my-yasnippets))
     ;; (message "yas/snippet-dirs=%s" (mapconcat 'identity yas-snippet-dirs ":"))

     ;; default hotkey `C-c C-s` is still valid
     ;; (global-set-key (kbd "C-c l") 'yas-insert-snippet)
     ;; give yas/dropdown-prompt in yas/prompt-functions a chance
     (require 'dropdown-list)
     (setq yas-prompt-functions '(yas-dropdown-prompt
                                  yas-ido-prompt
                                  yas-completing-prompt))

     ;; use yas/completing-prompt when ONLY when `M-x yas-insert-snippet'
     ;; thanks to capitaomorte for providing the trick.
     (defadvice yas-insert-snippet (around use-completing-prompt activate)
       "Use `yas-completing-prompt' for `yas-prompt-functions' but only here..."
       (let ((yas-prompt-functions '(yas-completing-prompt)))
         ad-do-it))
     ))

(provide 'init-yasnippet)

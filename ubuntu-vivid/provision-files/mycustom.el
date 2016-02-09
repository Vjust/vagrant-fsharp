(defun make-tmp-name ()
  (concat "tmp_" (int-to-string (random 100000)))
  )


(fset 'my-save-buffer
   "\C-x\C-s")
 
(fset 'vmacro-copy-whole-buff
   "\C-xh\367")
 
(fset 'vmacro-quit
   "\C-g")
 
(fset 'vmacro-enter
   [return])
 
(setq debug-on-error t)
;(setq scheme-program-name "c:/tools/mzscheme/mzscheme.exe -m ")


(defun my-file-open-hook ()
  nil
)
 
 
;; this will yank a line and copy it to the kill-ring
(defun my-kill-line ()
	  (interactive)
	  (kill-line)
	  (yank)
	  (beginning-of-line))
 

 
;(debug)

 
(defun myswitch-to-buffer()
  (interactive)
  (bs-cycle-previous)
  (execute-kbd-macro 'vmacro-enter))
 
(defun mykill-buffer()
  (interactive)
  (kill-buffer )
  (execute-kbd-macro 'vmacro-enter))
 
 
(defun mykill-buffer()
;;  (interactive)
  (kill-buffer buffer-name)
  (execute-kbd-macro 'vmacro-enter))
 

 
 
 
;; first clear the scratch buffer
 
(defun my-clear-scratch()
  (interactive)
  (make-tmp-name ""))
; (switch-to-buffer "tbuf")
;  (erase-buffer))
 
;; execute buffer contents as a shell script
(defun my-exec-shell-in-buffer()
  (interactive)
  (save-buffer)
  (executable-interpret "/tmp/v_temp.txt"))
;  (executable-interpret "~/vj_emacs_temp_shell"))
 
 
(defun my-copy-whole-buffer()
  (interactive)
  (execute-kbd-macro 'vmacro-copy-whole-buff))
 
(global-set-key [pause] 'kk1)
 
(defun kk1()
  (interactive)
  (execute-kbd-macro 'vmacro-quit))
 
(defun myexpand-abbrev()
  (interactive)
  ( let  ((old-point (point) ) )
     (expand-abbrev)
     (if (= (point) old-point )
	 (dabbrev-expand nil))))
 
 
(setq dabbrev-case-replace nil)
 
(defun dup-this-line()
  (interactive)
  (beginning-of-line)
  (kill-line)
  (yank)
  (open-line 1)
  (beginning-of-line 2)
  (yank))
 
 
(toggle-truncate-lines t)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)



(global-auto-revert-mode)

(setq dired-listing-switches "-al")




(menu-bar-mode 0)








(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))



(setq display-time-day-and-date t)
(display-time)

(linum-mode 1)

(setq linum-format " %d ")

(tool-bar-mode )



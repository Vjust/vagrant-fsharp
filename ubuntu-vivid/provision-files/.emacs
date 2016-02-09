;------------ setup package manager --------------------
                                                        
(require 'package)

(add-to-list 'package-archives 
    '("melpa" .
      "http://melpa.org/packages/") t)
(package-initialize)

;---------------------------------------------------------


(require 'git)
(load-library "git")

;(load-theme 'zenburn t)
(load-theme 'darkburn t)


;; Ido vertical mode
;(require 'ido-vertical-mode)
;--(ido-mode 1)
;(ido-vertical-mode 1)
;--(setq ido-enable-flex-matching t)
;--(setq ido-everywhere nil)


;----------------- tool: multi-term -----------
(defun ad-advised-definition-p (k) nil)
(require 'multi-term)
(setq multi-term-program "/bin/zsh")
;----------------------------------------


;; ---------------- tool python/jedi --------------
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)   
;;---------------------------------------





; --------------- customizations ---------------------------

(load "~/.emacs.d/mycustom.el")
(load "~/.emacs.d/mykb.el")
(load "~/.emacs.d/mydb.el")

; ----------------------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("8cf56691a70156f611ac86d0bbcbc7dee7673df195de5918f34bfdc6814ffd39" "1e194b1010c026b1401146e24a85e4b7c545276845fc38b8c4b371c8338172ad" "769bb56fb9fd7e73459dcdbbfbae1f13e734cdde3cf82f06a067439568cdaa95" default)))
 '(virtualenv-root "~/.emacs.d/.python-environments/default/"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


; ------ printing -----

(setq ps-font-size 12)

;--------------------

;--- temp area ------------------------
;(add-to-list 'load-path "~/.emacs.d/fsharp-mode/")
;(autoload 'fsharp-mode "fsharp-mode"     "Major mode for editing F# code." t)
;(add-to-list 'auto-mode-alist '("\\.fs[iylx]?$" . fsharp-mode))
;(add-to-list 'load-path "~/.emacs.d/fsharp-mode/")
;(autoload 'scala-mode )
;"fsharp-mode"     "Major mode for editing F# code." t)
;(add-to-list 'auto-mode-alist '("\\.sc[iylx]?$" . scala-mode))



;------------------- end temp area ----------------------


;-------- project based customizations ---------------------
;(defun go-pil-1()
;  /ssh:pilot-1|sudo:sjacdev@pilot-1:/opt/corroborator

(defun go-pil-1-sudo()
  (interactive)
  (find-file "/ssh:pilot-1|sudo:sjacdev:/opt/corroborator"))

(defun go-pil-1()
  (interactive)
  (find-file "/ssh:pilot-1:/opt/corroborator"))

(defun go-pil-1-clone-sudo()
  (interactive)
  (find-file "/ssh:pilot-1-clone|sudo:sjacdev:/opt/corroborator"))

(defun go-pil-1-clone()
  (interactive)
  (find-file "/ssh:pilot-1-clone:/opt/corroborator"))

(defun go-wp1-sudo()
  (interactive)
  (find-file "/ssh:wp1|sudo:vjust:~"))

(defun go-vagrant()
  (interactive)
  (find-file "/vagrant@vm-default:~"))

(defun go-vagrant-sudo()
  (interactive)
  (find-file "/root@vm-default:~"))


(defun go-ssh-config()
  (interactive)
  (find-file "~/.ssh/config"))

(defun go-ghub()
  (interactive)
  (find-file "~/ghub"))

(defun go-coo()
  (interactive)
  (find-file "~coo"))


; ~~~~~~~~~~~~~~~~~~~~   Python setup ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`

(setq py-install-directory "~/.emacs.d/python-mode.el-6.2.0")
(add-to-list 'load-path py-install-directory)
(require 'python-mode)

(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")
;(setq py-python-command-args
;  '("--gui=wx" "--pylab=wx" "-color" "Linux"))
(setq py-force-py-shell-name-p t)

(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)

(setq py-split-windows-on-execute-p nil)
(setq py-smart-indentation t)

(setq coo-env "/home/vjust/code4/corroborator_dev0/env/bin/")
(setq ipython-coo (concat coo-env "ipython"))




; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ emacs backup ~~~~~~~~~~~~~~~~~~~~~~~~~~`
(setq backup-directory-alist `(("." . "~/.emacs_backups")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)


					; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

(tool-bar-mode -1)


;(add-hook 'info-mode-hook 'vjs-info-mode)


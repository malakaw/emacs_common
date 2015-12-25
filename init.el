(package-initialize)
(add-to-list 'package-archives  '("melpa" . "http://stable.melpa.org/packages/"))
;;(add-to-list 'package-archives  '("melpa" . "http://melpa.org/packages/"))
 ;; (setq package-archives
 ;;       '(("melpa" . "http://melpa.milkbox.net/packages/")) )









(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))

(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))


(load-user-file "~/.emacs.d/my_config/1.el")







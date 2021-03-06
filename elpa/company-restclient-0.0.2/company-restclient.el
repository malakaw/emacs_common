;;; company-restclient.el --- company-mode completion back-end for restclient-mode

;; Public domain.

;; Author:    Iku Iwasa <iku.iwasa@gmail.com>
;; URL:       https://github.com/iquiw/company-restclient
;; Package-Version: 0.0.2
;; Version:   0.0.2
;; Package-Requires: ((cl-lib "0.5") (company "0.8.0") (emacs "24") (know-your-http-well "0.2.0"))

;;; Commentary:

;; `company-mode' back-end for `restclient-mode'.
;;
;; It provides auto-completion for HTTP methods and headers in `restclient-mode'.
;; Completion source is given by `know-your-http-well'.

;;; Code:

(require 'cl-lib)
(require 'company)
(require 'know-your-http-well)

(defvar company-restclient--current-context nil)

(defun company-restclient--find-context ()
  "Find context (method, header, body) of the current line."
  (save-excursion
    (catch 'result
      (let ((state 0))
        (while (and (>= (forward-line -1) 0)
                    (null (looking-at-p "^#")))
          (cond
           ((looking-at-p "^\\([[:space:]]*$\\|:\\)")
            (cond
             ((= state 0) (setq state 1))
             ((= state 2) (setq state 3))))
           ((= state 0) (setq state 2))
           ((or (= state 1) (= state 3))
            (throw 'result 'body))))

        (if (or (= state 0) (= state 1))
            (throw 'result 'method)
          (throw 'result 'header))))))

(defun company-restclient-prefix ()
  "Provide completion prefix at the current point."
  (cl-case (setq company-restclient--current-context
                 (company-restclient--find-context))
    (method (let ((case-fold-search nil)) (company-grab "^[[:upper:]]*")))
    (header (company-grab "^[-[:alpha:]]*"))))

(defun company-restclient-candidates (prefix)
  "Provide completion candidates for the given PREFIX."
  (cl-case company-restclient--current-context
    (method (all-completions prefix (mapcar #'car http-methods)))
    (header (all-completions (downcase prefix) (mapcar #'car http-headers)))))

(defun company-restclient-meta (candidate)
  "Return description of CANDIDATE to display as meta information."
  (cl-case company-restclient--current-context
    (method (cl-caadr (assoc candidate http-methods)))
    (header (cl-caadr (assoc candidate http-headers)))))

(defun company-restclient-post-completion (candidate)
  "Format CANDIDATE in the buffer according to the current context.
For HTTP method, insert space after it.
For HTTP header, capitalize if necessary and insert colon and space after it."
  (cl-case company-restclient--current-context
    (method (insert " "))
    (header (let (start (end (point)))
              (when (save-excursion
                      (backward-char (length candidate))
                      (setq start (point))
                      (let ((case-fold-search nil))
                        (looking-at-p "[[:upper:]]")))
                (delete-region start end)
                (insert (mapconcat 'capitalize (split-string candidate "-") "-"))))
            (insert ": "))))

;;;###autoload
(defun company-restclient (command &optional arg &rest ignored)
  "`company-mode' completion back-end for `restclient-mode'.
Provide completion info according to COMMAND and ARG.  IGNORED, not used."
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-restclient))
    (prefix (and (derived-mode-p 'restclient-mode) (company-restclient-prefix)))
    (candidates (company-restclient-candidates arg))
    (ignore-case 'keep-prefix)
    (meta (company-restclient-meta arg))
    (post-completion (company-restclient-post-completion arg))))

(provide 'company-restclient)
;;; company-restclient.el ends here

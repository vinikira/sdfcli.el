;;; sdfcli.el --- A wrapper for SDF CLI for Java

;;; Commentary:

;;; This file contains core functions of sdfcli.el

;;; Code:

(require 'projectile)

(defun sdfcli/import-objects ()
  "Import objects from SDF Project."
  (interactive)
  (message (format (concat "sdfcli importobjects "
                           "-destinationfolder %s "
                           "-scriptid %s "
                           "-type %s "
                           "-p %s "
                           "-url %s "
                           "-account %s "
                           "-email %s "
                           "-role %s ")
                   (read-string "Enter script id: ")
                   (read-string "Enter type: ")
                   (read-string "Enter destination folder: ")
                   (read-string "Enter url: ")
                   (read-string "Enter account id: ")
                   (read-string "Enter email: ")
                   (read-string "Enter role: "))))

(defun sdfcli--sdf-file-in-project-p ()
  "Check if the .SDF file is already created in current project."
  (let (project-root (projectile-project-root))
    (file-exists-p (concat project-root ".SDF"))))

(defun sdfcli/generate-sdf-file ()
  "Generate .SDF file in the current project."
  (interactive)
  (if (not (sdfcli--sdf-file-in-project-p))
      (let ((file-name (concat (projectile-project-root) ".SDF")))
        (with-temp-file file-name
          (insert (format
                   (concat "account=%s \n"
                           "email=%s \n"
                           "role=%s \n"
                           "url=%s")
                   (read-string "Enter the account id: ")
                   (read-string "Enter the email: ")
                   (read-string "Enter the role: ")
                   (read-string "Enter the url: ")))
          (write-file file-name)
          (kill-buffer)))
    (message "File already created.")))

(provide 'sdfcli)
;;; sdfcli.el ends here

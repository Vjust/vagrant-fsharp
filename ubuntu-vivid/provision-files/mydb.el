(defun db-conn-local(env user)
      (setq sql-user user)
      (setq sql-password "yantra")
      (setq sql-database "corroborator" ok 1)
      (if (equal env "clone")
	  (progn
	      (setq sql-database "corroborator")
	      (setq sql-mysql-options  (list "-P 3309"))
	  )
	  (if (equal env "prod")
	      (progn 
		(setq sql-database "corroborator")
	        (setq sql-mysql-options  (list "-P 3308"))
	      )
	  )
       )

      ;(setq sql-mysql-options nil)

       (if (eq ok 1)
           (progn
           (sql-mysql)))
)

(defun db-dev-local()       (interactive) (db-conn-local "dev"   "vjust" ) )
(defun db-sqlite()       (interactive) (progn
					 (setq sql-database  "db.sqlite3") 
					 (sql-sqlite) 
					 )) 

(defun db-dev-3309()       (interactive) (db-conn-local "clone"   "vjust" ) )

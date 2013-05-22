CREATE OR REPLACE TRIGGER ioft_update_users_view
INSTEAD OF INSERT
ON role_permission_view
FOR EACH ROW
DECLARE
 x INTEGER;
BEGIN
  SELECT COUNT(*)
  INTO x
  FROM permission_code
  WHERE pcode = :NEW.pcode;

  IF x = 0 THEN
    INSERT INTO permission_code
    (pcode, pcode_description, mod_user_id, mod_user_date)
    VALUES
    (:NEW.pcode, 'New Code', USER, SYSDATE);
  END IF;

  SELECT COUNT(*)
  INTO x
  FROM dept_code
  WHERE dept_code = :NEW.dept_code;

  IF x = 0 THEN
	    INSERT INTO dept_code
	    (dept_code, dept_name)
	    VALUES
	    (:NEW.dept_code, 'New Dept');
	  END IF;

	  INSERT INTO user_role
	  (dept_code, pcode, mod_user_id)
	  VALUES
	  (:NEW.dept_code, :NEW.pcode, 'Morgan');

	  INSERT INTO test
	  (test)
	  VALUES
	  ('Z');
END ioft_insert_role_perm;
/

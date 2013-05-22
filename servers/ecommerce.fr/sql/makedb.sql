connect internal
startup nomount
set echo on
spool makedb.log
create database ecomfr
        maxinstances 1
        maxlogfiles  8
        datafile '$ORACLE_HOME/dbs/ecomfr_syst_01.dbf' size 40M reuse
        logfile
                '$ORACLE_HOME/dbs/ecomfr_redo_01.dbf' size 1M reuse,
                '$ORACLE_HOME/dbs/ecomfr_redo_02.dbf' size 1M reuse,
                '$ORACLE_HOME/dbs/ecomfr_redo_03.dbf' size 1M reuse;
@$ORACLE_HOME/rdbms/admin/catalog.sql
create tablespace rollback
        datafile '$ORACLE_HOME/dbs/ecomfr_roll_01.dbf' size 8.5M reuse;
create tablespace temp
        datafile '$ORACLE_HOME/dbs/ecomfr_temp_01.dbf' size 5M reuse 
        temporary;
create tablespace users
        datafile '$ORACLE_HOME/dbs/ecomfr_user_01.dbf' size 10M reuse;
create rollback segment r1 tablespace rollback
        storage ( optimal 5M );
alter rollback segment r1 online;
connect system/manager
@$ORACLE_HOME/rdbms/admin/catdbsyn.sql
connect internal
@$ORACLE_HOME/rdbms/admin/catproc.sql
connect system/manager
@$ORACLE_HOME/sqlplus/admin/pupbld.sql
spool off
exit

connect / as sysdba
create user toto identified by toto;
grant connect to toto;
grant resource to toto;
grant create view, create synonym, create materialized view to toto;
grant public database link on toto;
create public database link ecommerce.us connect to toto identified by toto using 'alias';
connect toto/toto
select SYSDATE from DUAL@ecommerce.us;

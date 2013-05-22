create user toto identified by toto;
grant connect to toto;
grant resource to toto;
grant create view, create synonym, create materialized view to toto;
grant create database link to toto;
create public database link ecommerce.fr connect to toto identified by toto using 'alias';
connect toto/toto
select SYSDATE from DUAL@ecommerce.fr;

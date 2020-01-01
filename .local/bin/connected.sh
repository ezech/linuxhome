#!/bin/sh

if [ "$1" != "" ]
then
    export ORACLE_SID=$1
fi

sqlplus / as sysdba <<EOF
SET PAGESIZE 0
SET NEWPAGE 0
SET SPACE 0
SET LINESIZE 1000
SET ECHO OFF
SET FEEDBACK OFF
SET VERIFY OFF
SET HEADING OFF
SET MARKUP HTML OFF SPOOL OFF
SET COLSEP ' '
column username Format a25
column machine  Format a40
column osuser   Format a30
select username, machine, osuser, program  from v\$session where username is not NULL order by username;
EOF



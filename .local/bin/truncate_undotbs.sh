export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/12.1.0/dbhome_1
export CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
PATH=$ORACLE_HOME/bin:$ORACLE_HOME/OPatch
export PATH=$PATH:/usr/sbin:/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/home/oracle/bin

export ORACLE_SID=FANCYDB

sqlplus /nolog <<EOF
connect / as sysdba
CREATE UNDO TABLESPACE undotbs2 DATAFILE '/u01/app/oracle/oradata/FANCYDB/undotbs02.dbf' SIZE 2M REUSE AUTOEXTEND ON;
ALTER SYSTEM SET UNDO_TABLESPACE = undotbs2;
DROP TABLESPACE undotbs1;
EOF

rm $ORACLE_BASE/oradata/$ORACLE_SID/undotbs01.dbf

sqlplus /nolog <<EOF
connect / as sysdba
CREATE UNDO TABLESPACE undotbs1 DATAFILE '/u01/app/oracle/oradata/FANCYDB/undotbs01.dbf' SIZE 2M REUSE AUTOEXTEND ON;
ALTER SYSTEM SET UNDO_TABLESPACE = undotbs1;
DROP TABLESPACE undotbs2;
EOF
rm $ORACLE_BASE/oradata/$ORACLE_SID/undotbs02.dbf


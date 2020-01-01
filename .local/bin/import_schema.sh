#!/bin/sh

if [ $# -ne 4 ]; then
  echo "Usage is: $0 SERVICE_NAME SchemaName dump-filename.dmp OldSchemaName"
  exit 1
fi
SERVICE_NAME=$1
SCHEMA_NAME=$2
DUMP_FILE=$3
OLD_SCHEMA_NAME=$4

if [ ! -f "/u01/exp_imp/${DUMP_FILE}" ]; then
  echo "File /u01/exp_imp/${DUMP_FILE} doesn't exist"
  exit 2
fi


echo "Killing all sessions of user ${SCHEMA_NAME} in database ${SERVICE_NAME}"

sqlplus /nolog <<EOF
connect sys/manager12@${SERVICE_NAME} as sysdba
alter user ${SCHEMA_NAME} identified by a account unlock;
begin
  for x in ( select Sid, Serial#, username from v\$session where username = '${SCHEMA_NAME}' ) loop
    execute immediate 'Alter System Kill Session '''|| x.Sid || ',' || x.Serial# || ''' IMMEDIATE';
  end loop;
end;
/
EOF
sleep 5
echo "Dropping user $2"
echo "Please mind that it'll look like it hanged on 'SQL> ' screen - but be patient - it's working"
sqlplus /nolog <<EOF
connect sys/manager12@${SERVICE_NAME} as sysdba
drop user ${SCHEMA_NAME} cascade;
create user ${SCHEMA_NAME} identified by a account unlock;
GRANT "JAVADEBUGPRIV", "JAVAIDPRIV", "JAVASYSPRIV", "JAVAUSERPRIV", "JAVA_ADMIN", "JAVA_DEPLOY" to ${SCHEMA_NAME};
GRANT IMP_FULL_DATABASE, EXP_FULL_DATABASE to ${SCHEMA_NAME};
GRANT UNLIMITED TABLESPACE TO ${SCHEMA_NAME};
GRANT EXECUTE ON "SYS"."DBMS_CRYPTO" TO ${SCHEMA_NAME};
GRANT READ, WRITE ON DIRECTORY "SYS"."EXP_IMP" TO ${SCHEMA_NAME};
/
EOF

#echo "Debug exit" && exit 7
echo "Importing file /u01/exp_imp/${DUMP_FILE} to schema schema ${SCHEMA_NAME}"
IMPLOG=IMPDP_${SERVICE_NAME}_${SCHEMA_NAME}_`date +%Y%m%d%H%M`.log
impdp ${SCHEMA_NAME}/a@${SERVICE_NAME} DIRECTORY=EXP_IMP DUMPFILE=${DUMP_FILE} LOGFILE=$IMPLOG REMAP_SCHEMA=${OLD_SCHEMA_NAME}:${SCHEMA_NAME} transform=OID:n

sqlplus /nolog <<EOF
connect sys/manager12@${SERVICE_NAME} as sysdba
alter user ${SCHEMA_NAME} identified by ${SCHEMA_NAME} account unlock;
/
EOF

echo "Recovering original password for ${SCHEMA_NAME} (it was same as login, right?)"
echo "To check for problems view the log file:"
echo "less /u01/exp_imp/$IMPLOG"

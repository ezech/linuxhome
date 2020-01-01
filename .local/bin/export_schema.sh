#!/bin/sh

if [ $# -ne 2 ]; then
  echo "Usage is: $0 SID SchemaName"
  exit 1
fi
echo "Killing all sessions of user $2 in database $1"

export ORACLE_SID=$1
sqlplus /nolog <<EOF
connect / as sysdba
alter user $2 identified by a account unlock;
begin
  for x in ( select Sid, Serial#, username from v\$session where username = '$2' ) loop
    execute immediate 'Alter System Kill Session '''|| x.Sid || ',' || x.Serial# || ''' IMMEDIATE';
  end loop;
end;
/
EOF


echo "Exporting schema to file: /u01/exp_imp/EXPDP_${1}_${2}_`date +%Y%m%d%H%M`.dmp"
expdp $2/$2@$1 \
  DIRECTORY=EXP_IMP \
  DUMPFILE=EXPDP_${1}_${2}_$(date +%Y%m%d%H%M).dmp \
  LOGFILE=EXPDP_${1}_${2}_$(date +%Y%m%d%H%M).log \
  SCHEMAS=$2 \
  EXCLUDE=statistics \
  FLASHBACK_TIME=systimestamp

sqlplus /nolog <<EOF
connect / as sysdba
alter user $2 identified by $2 account unlock;
/
EOF

echo "Recovering original password for $2 (it was same as login, right?)"


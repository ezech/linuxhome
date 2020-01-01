#!/bin/sh

if [ $# -ne 2 ]; then
  echo "Usage is: $0 SID UserName"
  exit 1
fi
echo "Killing all sessions of user $2 in database $1"

export ORACLE_SID=$1

sqlplus /nolog <<EOF
connect / as sysdba
begin
  for x in ( select Sid, Serial#, username from v\$session where username = '$2' ) loop  
    execute immediate 'Alter System Kill Session '''|| x.Sid || ',' || x.Serial# || ''' IMMEDIATE';  
  end loop;  
end;
/
EOF


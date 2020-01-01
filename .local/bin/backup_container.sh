#!/bin/sh

export ORACLE_BASE="/u01/app/oracle"
export ORACLE_HOME="/u01/app/oracle/product/12.1.0/dbhome_1"
export ORACLE_SID=CLM
export CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib:/usr/lib64
export PATH=$ORACLE_HOME/bin:$ORACLE_HOME/OPatch:$PATH:$HOME/.local/bin:$HOME/bin:/u01/agent/agent_13.2.0.0.0/bin
export TEMPDIR=/tmp
export TMP=/tmp


dir_backup_destination="/backup"
pdb_file_postfix="_$(date +%Y%m%d%H%M%S).pdb"

if [ $# -ne 1 ]; then
  echo "Usage is: $0 container_name"
  exit 1
fi

pdb=$1
file_pdb="$dir_backup_destination/${pdb}$pdb_file_postfix"
echo "Backing up $1 to $file_pdb"

sqlplus /nolog <<EOF
connect / as sysdba
alter  pluggable database $pdb close immediate;
alter  pluggable database $pdb unplug into '$file_pdb';
drop   pluggable database $pdb keep datafiles;
create pluggable database $pdb using '$file_pdb';
alter  pluggable database $pdb open;
EOF

echo "Work on $pdb finished."


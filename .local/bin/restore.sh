#!/bin/sh

export ORACLE_BASE="/u01/app/oracle"
export ORACLE_HOME="/u01/app/oracle/product/12.1.0/dbhome_1"
export ORACLE_SID=CLM
export CLASSPATH=$ORACLE_HOME/JRE:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib:/usr/lib64
export PATH=$ORACLE_HOME/bin:$ORACLE_HOME/OPatch:$PATH:$HOME/.local/bin:$HOME/bin:/u01/agent/agent_13.2.0.0.0/bin
export TEMPDIR=/tmp
export TMP=/tmp

pdb=portabledb4
file_pdb="/backup/portabledb4_20190101235959.pdb"


echo "Starting backup of $pdb at $(date +%H:%M:%S)"
sqlplus /nolog <<EOF
connect / as sysdba
create pluggable database $pdb using '$file_pdb';
alter pluggable database $pdb open;
EOF

echo "Done"


#!/bin/sh

machine_name=machinewithdbs
log_file=/backup/backup_dbs_script_$(date +%Y.%d).log
current_date=$(date +%Y%m%d)

# clean first
rm /backup/*pdb >> $log_file 2>&1

function log(){ 
  NOW=$(date +%Y-%m-%d-%H:%M:%S)
  echo "[${NOW}] $@"
  echo "[${NOW}] $@" >> $log_file
}

for pdb in db1 db2 db3 db4
do
    log "Starting backup of $pdb at $(date +%H:%M:%S)"
    /home/oracle/bin/backup_container.sh $pdb
    log "Finished at $(date +%H:%M:%S)"
done


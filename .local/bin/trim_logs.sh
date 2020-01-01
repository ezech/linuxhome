for sid in $(grep dbhome_1:Y /etc/oratab | awk -F : '{print $1}')
do
    find /u01/app/oracle/admin/$sid/adump/${sid}_*.aud -mtime +7 -exec rm {} \;
done

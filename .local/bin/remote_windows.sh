name_host=$(basename $0 | sed 's/.sh//')

# in this file all required informations for connection to win-host
file_secrets=~/.ssh/${name_host}.secrets
dir_secrets=$(dirname $file_secrets)

# if no secrets file is present, try to recreate it
if [ ! -f $file_secrets ] 
then
    echo "No secrets for $name_host - creating empty one at $file_secrets"
    [ ! -d $dir_secrets ] && mkdir -p $dir_secrets || echo "dir $dir_secrets exists"
    [ $? -ne 0 ] && echo "Error creating directory $dir_secrets - rethink your life." && exit 10
    echo "name_login=\"your_login\"" >> $file_secrets
    echo "name_domain=\"windows_or_ad_domain\"" >> $file_secrets
    echo "name_password=\"secret_password\"" >> $file_secrets
    echo "File created, now you need to encrypt it with gpg2"
    echo "like:"
    echo "gpg2 -r \"John Doe\" -e $file_secrets"
    echo "mv $file_secrets.gpg $file_secrets"
    exit 5
fi
#source "gpg2 -qd $file_secrets |"
. <(gpg2 -dq $file_secrets)

#geometry=1600x900
geometry=1200x700

dir_shared="~/Shared_RDP_Directory/$name_host"
[ ! -d $dir_shared ] && mkdir -p $dir_shared
[ ! -d $dir_shared ] && echo "Problem with shared dir, exiting." && exit 1

echo "Connecting to $name_host as $name_login on $name_domain domain."
xfreerdp /cert-tofu +fonts /jpeg \
  /drive:Shared,$dir_shared /size:$geometry \
  /u:$name_login@$name_domain /p:$name_password /v:$name_host

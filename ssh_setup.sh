#!/bin/sh
date=`date +"%Y%m%d_%b%d%y"`
shortservername=`hostname -s`
whoami=`whoami`

echo 'Source server name: ' $shortservername

if [ -e ~/.ssh/id_rsa ]
then
        echo 'RSA keys already exist. Continuing...'
else
        echo 'Creating RSA keys...'
        ssh-keygen -t rsa

        if [ -e serverlist.txt ]
        then
                for server in `cat serverlist.txt`
                do
                        #echo $whoami
                        ssh-copy-id $whoami@$server
                done
        fi

fi

for server in `cat serverlist.txt`
do
        echo '###VVV#### ON SERVER: ' $server ' #######VVV######' $1;
        if [ $# -gt 0 ]
        then
                ssh $server $1
        else
                #echo 'telnet '  $server ' 443 ';
                #telnet $server 443;
                #ssh $server /tmp/firewalls.sh
                ssh $whoami@$server ls
        fi
        echo '###^^^#### END:       ' $server ' #######^^^######' $1;
done

echo 'Thank you. Come again. ' ${date}


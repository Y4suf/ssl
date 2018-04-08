#!/bin/bash
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;

 red='\e[1;31m'
               green='\e[0;32m'
               NC='\e[0m'
			   
               echo "Connecting to Orang-Ganteng.com..."
               sleep 0.5
               
			   echo "Checking Permision..."
               sleep 0.5
               
			   echo -e "${green}Permission Accepted...${NC}"
               sleep 1
			   
              
flag=0
	
#iplist="ip.txt"

wget --quiet -O iplist.txt https://raw.githubusercontent.com/Y4suf/ssl/master/ip.txt

#if [ -f iplist ]
#then

iplist="iplist.txt"

lines=`cat $iplist`
#echo $lines

for line in $lines; do
#        echo "$line"
        if [ "$line" = "$myip" ];
        then
                flag=1
        fi

done

if [ $flag -eq 0 ]
then
   echo  "Maaf, hanya IP @ Password yang terdaftar sahaja boleh menggunakan script ini!
Hubungi: Orang Ganteng | Wa 0895703796928"

rm -f /root/iplist.txt

rm -f /root/debian7.sh

rm -f /root/.bash_history && history -c

   exit 1
fi

apt-get install stunnel4

wget -O /etc/stunnel/stunnel.conf "https://raw.githubusercontent.com/Y4suf/ssl/master/stunnel.conf"

openssl genrsa -out key.pem 2048

openssl req -new -x509 -key key.pem -out cert.pem -days 1095

cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4

/etc/init.d/stunnel4 restart

clear
echo -e "_____________________________"
echo -e "SUKSES EA BOS INSTALASINYA"
echo -e "Port SSL/TLS Default : 443"
echo -e "By Orang Ganteng | Wa 0895703796928"
echo -e "_____________________________"

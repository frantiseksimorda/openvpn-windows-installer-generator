#!/bin/bash
# need p7zip-full package on Ubuntu
# after generating client certificate:
# ./easyrsa gen-req client nopass
# and after signing client certificate:
#echo "yes" | ./easyrsa sign-req client $1
key_dir="/etc/openvpn/server/keys"
easy_rsa_dir="/etc/openvpn/server/easy-rsa"
#client_name="company"

mkdir "$key_dir/$1/"                                                               # create user dir
cp "$easy_rsa_dir/pki/issued/$1.crt" "$key_dir/$1/"                                 # copy certificate
cp "$easy_rsa_dir/pki/private/$1.key" "$key_dir/$1/"                                 # copy key
cp -r /etc/openvpn/server/source_dir/* "$key_dir/$1/"                                # copy config, certificates, .exe installer, 

mv "$key_dir/$1/$1.crt" "$key_dir/$1/client.crt"
mv "$key_dir/$1/$1.key" "$key_dir/$1/client.key"

cd $key_dir
7z a $1.7z $(find "$key_dir/$1" -type f)

cat $easy_rsa_dir/7zS.sfx $easy_rsa_dir/config.txt $1.7z > $1"_vpn.exe"

#!/bin/bash
# after generating client certificate:
# ./easyrsa gen-req client nopass
# and after signing client certificate:
# easyrsa sign-req client client1
# 
key_dir="/etc/openvpn/server/keys/"
easy_rsa_dir="/etc/openvpn/server/easy-rsa/"
client_name="company_x"

mkdir "$key_dir$1/"                                                               # create user dir
cp "$easy_rsa_dir/pki/issued/$1.csr" "$key_dir/$1/"                                 # copy certificate
cp "$easy_rsa_dir/pki/private/$1.key" "$key_dir$1/"                                 # copy key
cp -r /etc/openvpn/server/source_dir/* "$key_dir/$1/"                                # copy config, certificates, .exe installer, 

mv "$key_dir$1/$1.csr" "$key_dir$1/$client_name.csr"
mv "$key_dir$1/$1.key" "$key_dir$1/$client_name.key"

cd $key_dir
7z a $1.7z $(find "$key_dir$1" -type f)

cat 7zS.sfx config.txt $1.7z > $1"_vpn.exe"

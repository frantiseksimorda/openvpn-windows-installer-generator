# openvpn-windows-installer-generator
1. setup openvpn server
2. pull/download 
3. create your config.txt to customize setup and save in key_dir:
    ```;!@Install@!UTF-8!  
    Title="OpenVPN"  
    BeginPrompt="Do you want to install the OpenVPN?"  
    InstallPath="%TEMP%"  
    RunProgram="setup.bat"  
    ;!@InstallEnd@!```
4. Copy 7zS.sfx into key_dir
5. create setup.bat which will do the installation, needs to be in the source_dir and later in archive wirh ca.crt, client key and crt, openvpn-exe-installer, client.ovpn config and ta.key it it was generated:  
    ```
    openvpn-install-2.4.12-I601-Win10.exe /S  
    mkdir %homepath%\OpenVPN\Config  
    copy "*" "%homepath%\OpenVPN\Config"  
    timeout /T 10
    ```
6. ./easyrsa gen-req client nopass
7. run this script with one argument: name of client you put when generating

# Docker-Ubuntu-Unity-DotNetTools

Dockfile for Ubuntu with Unity desktop environment and noVNC. 

This **Image/Dockerfile** aims to create a container for **Ubuntu 16.04** with **Unity Desktop** and using **TightVNCServer**, **noVNC**, **Ngrok(Optional)** which allow user use browser to log in into this container.


## How to use?

You can build this **Dockerfile** yourself:

```
docker = build -t "bistormllc/ubuntu-novnc-dotnet" .
```

Or, just pull the **image**:

```
docker = pull bistormllc/ubuntu-novnc-dotnet
```

The default usage of this image is:

```
docker = run -itd -p 80:6080 bistormllc/ubuntu-novnc-dotnet
```

Wait for a few seconds for services to start, then you can access http://localhost/vnc.html to see this screen:

![alt text](https://github.com/bistormllc/Docker-Ubuntu-Unity-DotNetTools/raw/master/noVNC.png "vnc.html")


### Password

By default, the ubuntu user **password** will be created randomly. To find the password, please using the following command:

```
docker = exec $CONTAINER_ID cat /home/ubuntu/password.txt
```

You can use this password to log into this container.

After log in, you should be able to see this screen:

![alt text](https://github.com/bistormllc/Docker-Ubuntu-Unity-DotNetTools/raw/master/desktop.png "Unity desktop")


## Arguments

This image contains 3 input argument:

1. Password

   You can set your own user password as you like:
   ```
   docker = run -itd -p 80:6080 -e PASSWORD=$YOUR_PASSWORD bistormllc/ubuntu-novnc-dotnet
   ```
   Now, you can user your own password to log in.

2. Sudo

   In default, the user **ubuntu** will not be the sudoer, but if you need, you can use this command:
   ```
   docker run -itd -p 80:6080 -e SUDO=yes bistormllc/ubuntu-novnc-dotnet
   ```

   This command will grant the **sudo** to user **ubuntu**.

   And use **SUDO=YES**, **SUDO=Yes**, **SUDO=Y**, **SUDO=y** are also supported.

   To check that sudo is working, when you open **xTerm** it should show following message:
   ```
   To run a command as administrator (user "root"), use "sudo <command>".
   See "man sudo_root" for details.
   ```

   ![alt text](https://github.com/bistormllc/Docker-Ubuntu-Unity-DotNetTools/raw/master/sudo.png "sudo")

   **Caution!!** allow your user as sudoer may cause security issues, use it carefully.

3. Ngrok

   [Ngrok](https://ngrok.com/) can be used to deploy localhost to the internet.

   If you need to use this image across the internet, Ngrok is what you need.

   To enable Ngrok, use following command:

   ```
   docker run -itd -p 80:6080 -e NGROK=yes bistormllc/ubuntu-novnc-dotnet
   ```

   And find the link address:

   ```
   docker exec $CONTAINER_ID cat /home/ubuntu/ngrok/Ngrok_URL.txt
   ```

   **NGROK=YES**, **NGROK=Yes**, **NGROK=Y**, **NGROK=y** are also supported.

    **Caution!!** this may also cause security issues, use it carefully.


## Screen size

The default setting of screen size is 1600x900.

You can change screen by using following command, this will change screen size to 1024x768:

```
docker = exec $CONTAINER_ID sed -i "s|-geometry 1600x900|-geometry 1024x768|g" /etc/supervisor/conf.d/supervisor.conf
docker = restart $CONTAINER_ID
```


## Issues

Can't work properly with gnome-terminal, use XTerm to place it.

Some components of Unity may not work properly with vncserver.

# Docker-Ubuntu-Unity-DotNetTools

This Docker builder repository was forked from https://github.com/chenjr0719/Docker-Ubuntu-Unity-noVNC
The Dockerfile builds **FROM** this original Dockerhub image: chenjr0719/ubuntu-unity-novnc

We created a Lab to get started on your first ASP .NET Core C# Angular app
https://docs.google.com/presentation/d/1d0NNMruQ0KNzpyjVBYnf9PqcG_p1K1djQDudgmXApIs

## Description
Dockfile for Ubuntu with Unity desktop environment accessible via noVNC, with Firefox, .NET Core and Visual Studio Code. 

Not fully baked: 
* Docker Machine pre-installed for creating images of projects
* NVM for switching between different NodeJS versions

### A note on pre-installed packages 
The build of this Docker image implements three .deb files:
* VS Studio Code 1.11.2 for amd64: code_1.11.2-1492070517_amd64.deb
* Docker CE 17.04 for amd64: docker-ce_17.04.0-ce-0-ubuntu-xenial_amd64
* TigerVNC is installed as a .deb via the original chenjr0719/ubuntu-unity-novnc image

**Where we could make efforts**, .deb files are validated during the build to prevent binary hacks.

This **Image/Dockerfile** creates a container for **Ubuntu Xenial 16.04** with **Unity Desktop** and using **TightVNCServer**, **noVNC**, **Ngrok(Optional)** 
which allows HTML5 browsers to log in into this container and collaboratively write .NET Core applications.


## How to use?

To create an immediately-accessible development environment container with **SUDO** access and **Ngrok** enabled, run:
```
$ docker-compose up -d
```
*see the docker-compose.yml file for login and port information*

### Note
* For security reasons, the Docker Compose file pushes the NoVNC connection to port 8181 on the Docker Host
* The Docker Compose file creates a volume map of the cloned directory to /var/www for working with files on the Docker host
* Wait for a few seconds for services to start, then access http://localhost:8181/vnc.html to see the screen below, 
click the *Connect* button, then enter *'ubuntu8181'* as the password:
![alt text](https://github.com/bistormllc/Docker-Ubuntu-Unity-DotNetTools/raw/master/noVNC.png "vnc.html")

### Accessing tools
* Terminator and Xterm terminals and Visual Studio code are accessible by searching within Unity's app search
* Firefox is bookmarked to the docking bar of Unity
* npm, yo, dotnet and webpack should all be accessible via commandline

## DIY
You can build this **Dockerfile** yourself:

```
$ docker build -t "bistormllc/ubuntu-novnc-dotnet" .
```

## From DockerHub
Or, just pull the **image**:

```
$ docker pull bistormllc/ubuntu-novnc-dotnet
```

The default usage of this image is:

```
$ docker run -d -p 80:6080 bistormllc/ubuntu-novnc-dotnet
```

Wait for a few seconds for services to start, then you can access http://localhost/vnc.html to see this screen:

![alt text](https://github.com/bistormllc/Docker-Ubuntu-Unity-DotNetTools/raw/master/noVNC.png "vnc.html")


### Password

By default, the ubuntu user **password** will be created randomly. To find the password, please using the following command:

```
$ docker exec $CONTAINER_ID cat /home/ubuntu/password.txt
```

You can use this password to log into this container.

After log in, you should be able to see this screen:

![alt text](https://github.com/bistormllc/Docker-Ubuntu-Unity-DotNetTools/raw/master/desktop.png "Unity desktop")


## Arguments

This image contains 3 input argument:

1. Password

   You can set your own user password as you like:
   ```
   $ docker run -d -p 80:6080 -e PASSWORD=$YOUR_PASSWORD bistormllc/ubuntu-novnc-dotnet
   ```
   Now, you can user your own password to log in.

2. Sudo

   In default, the user **ubuntu** will not be the sudoer, but if you need, you can use this command:
   ```
   docker run -d -p 80:6080 -e SUDO=yes bistormllc/ubuntu-novnc-dotnet
   ```

   This command will grant the **sudo** to user **ubuntu**.

   And use **SUDO=YES**, **SUDO=Yes**, **SUDO=Y**, **SUDO=y** are also supported.

   To check that sudo is working, when you open **xTerm** it should show following message:
   ```
   To run a command as administrator (user "root"), use "sudo <command>".
   See "man sudo_root" for details.
   ```

   ![alt text](https://github.com/bistormllc/Docker-Ubuntu-Unity-DotNetTools/raw/master/sudo.png "sudo")

   **Caution!!** allowing your users access as sudoer may cause security issues.  Please use it carefully.

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

* Can't work properly with gnome-terminal, use XTerm to place it.
* Some components of Unity may not work properly with vncserver.
* Twitter: @BiStormLLC for more cool stuff or @babelfeed for support 

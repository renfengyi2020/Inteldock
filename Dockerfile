#intel docker file by RFY
FROM debian
#create i386 docker
RUN dpkg --add-architecture i386
#update before anything
RUN apt update

RUN DEBIAN_FRONTEND=noninteractive apt install wine qemu-kvm *zenhei* xz-utils dbus-x11 curl firefox-esr gnome-system-monitor mate-system-monitor  git xfce4 xfce4-terminal tightvncserver wget   -y

RUN wget https://github.com/novnc/noVNC/archive/refs/tags/v1.2.0.tar.gz

RUN tar -xvf v1.2.0.tar.gz

RUN mkdir  $HOME/.vnc

RUN echo 'Rfy930725' | vncpasswd -f > $HOME/.vnc/passwd

RUN echo '/bin/env  MOZ_FAKE_NO_SANDBOX=1  dbus-launch xfce4-session'  > $HOME/.vnc/xstartup

RUN chmod 600 $HOME/.vnc/passwd

RUN chmod 755 $HOME/.vnc/xstartup

RUN echo 'whoami ' >>/Rfy930725.sh

RUN echo 'cd ' >>/Rfy930725.sh
#set screen resolution
RUN echo "su -l -c 'vncserver :2000 -geometry 1280x720' "  >>/Rfy930725.sh

RUN echo 'cd /noVNC-1.2.0' >>/Rfy930725.sh

RUN echo './utils/launch.sh  --vnc localhost:7900 --listen 8900 ' >>/Rfy930725.sh

RUN chmod 755 /Rfy930725.sh
#name the port
EXPOSE 8900

CMD  /Rfy930725.sh

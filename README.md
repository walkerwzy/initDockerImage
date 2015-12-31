# initDockerImage
used for digitalocean vps.

I write this script is conflict the docker's princeple which one container one funciton, but I just want when I run a new image of digitalocan, I can quickly have these functions works:

+ apache
+ shadowsocks
+ aria2
+ aria2-webui

so...

## install & build

    git clone https://github.com/walkerwzy/initDockerImage.git mydocker
    cd mydocker/
    sudo docker build -t walker/do .
    bash run.sh

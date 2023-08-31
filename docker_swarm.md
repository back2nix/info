#### Видео

- https://www.youtube.com/watch?v=tSQf0erYOHs
- https://www.youtube.com/watch?v=8TuKJDG0VWM
- https://www.youtube.com/watch?v=s8FBbzgmj6w
- https://www.youtube.com/watch?v=t_Tzzucx-oQ

#### multipass

```
multipass launch --name master1 --mem 2G --disk 30G --cpus 2
multipass launch --name worker1 --mem 1G --disk 10G --cpus 1
multipass launch --name worker2 --mem 4G --disk 30G --cpus 4
multipass list
multipass shell master1
multipass delete master1 worker1 worker2
multipass purge

sudo apt update
sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get install \
         ca-certificates \
         curl \
         gnupg \
         lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo docker run hello-world

sudo wget https://github.com/docker/compose/releases/download/v2.6.1/docker-compose-linux-x86_64 -O /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose

docker swarm join --token SWMTKN-1-3iwv3ujqtrhue5wf479euxkp2ik14miy44sw74zweikqyg335h-9r3zgn50obthxgpyydehkzah9 10.177.11.27:2377
```

#### swarm

```
sudo docker swarm init
sudo docker service ls
sudo docker node ls
```

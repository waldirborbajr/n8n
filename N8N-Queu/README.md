
## Download Manifest

curl -L https://downloads.portainer.io/ce2-20/portainer-agent-stack.yml -o portainer-agent-stack.yml

docker stack deploy -c portainer-agent-stack.yml portainer

## Swarm

docker swarm init --advertise-addr IP_DO_MASTER
docker promote nodeX # promover para VICE_MASTER

docker swarm join --token SWMTKN-1-0bts0kp693npxlzxa83ofnh8owsx4k43l31vxfcx9eu73lgslh-8bf120dx0reaqhcnmy21st27e 10.224.145.42:2377

## Deploy Stack

docker stack deploy -c portainer.yaml portainer

## Network create

docker network create --driver=overlay agent_network
docker network create --driver=overlay traefik_public

docker stop portainer
docker start portainer

# Update

## Standalone

docker stop portainer

docker container prune -f

docker pull portainer/portainer-ce:2.20.3

docker run -d -p 8000:8000 -p 9443:9443 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.20.3

## Swarm

docker service ls

docker pull portainer/portainer-ce:2.20.3
docker service update --image portainer/portainer-ce:2.20.3 --publish-add 9000:9000 --force portainer_portainer

docker pull portainer/agent:2.20.3
docker service update --image portainer/agent:2.20.3 --force portainer_agent 

# DNS

sudo lsof -nP -iTCP -iUDP -sTCP:LISTEN

## Edit line as below

sudo nano /etc/systemd/resolved.conf

DNSStubListener=no

sudo systemctl restart systemd-resolved



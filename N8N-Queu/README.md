docker swarm init --advertise-addr IP_DO_MASTER
docker promote nodeX # promover para VICE_MASTER

docker swarm join --token SWMTKN-1-4vmgzh2e0eji0d255p6j203p4hgyo5tygi0gc0k60ngpf4bica-1vz2vfr880kx7wgyg9yukh1hd 10.224.145.221:2377

docker stack deploy -c portainer.yaml portainer

docker network create --driver=overlay agent_network
docker network create --driver=overlay traefik_public

docker stop portainer
docker start portainer

# Update

## Standalone

docker pull portainer/portainer-ce:2.20.3

docker run -d -p 8000:8000 -p 9443:9443 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.20.3

## Swarm

docker pull portainer/portainer-ce:2.20.3

docker service update --image portainer/portainer-ce:2.20.3 --publish-add 9443:9443 --force portainer_portainer

docker swarm init

docker swarm join --token SWMTKN-1-4vmgzh2e0eji0d255p6j203p4hgyo5tygi0gc0k60ngpf4bica-1vz2vfr880kx7wgyg9yukh1hd 10.224.145.221:2377

docker stack deploy -c portainer.yaml portainer

docker network create --driver=overlay agent_network
docker network create --driver=overlay traefik_public

docker stop portainer
docker start portainer



# docker-swarmproxy
Docker Image used for Swarm > 1.12. Routes traffic from Ingress Mesh to scaled replicas.

## Example
We assume we have a webapp with multiple instances running. For performance reasons we need more instances than we have worker nodes, so we cannot bind one webapp instance on each node on port 80.

__We need our own overlay network with the swarm:__
`docker network create --driver overlay myswarmnet`

We create a new network called `myswarmnet` using the `overlay` network driver.

__Fire up our webapp workers with a demo image (simple PHP7 container listening on port 80):__
`docker service create --name mywebapp --network myswarmnet --replicas 10 toughiq/phptest`

We create a new service called `mywebapp`, connect it to our network `myswarmnet` and start with `10` replicas.

__Now we start our proxy, one one each worker node:__
`docker service create --name myproxy --network myswarmnet --mode global -p 80:80 --env DEST=mywebapp --env DESTPORT=80 toughiq/swarmproxy`

We create our `myproxy`service, connect it to our `myswarmnet` network, use `global` mode to assign one instance per node and export port `80` to port `80`. We also assign two environment variables to tell the proxy, where to route the traffic: 
`DEST=mywebapp` and `DESTPORT=80`

__Default Environment variables:__
They might be overwritten if needed:
`SRC=0.0.0.0` and `SRCPORT=80`

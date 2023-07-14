# soroban-preview-docker
Docker images to support Soroban Preview's setup.

See published images in DockerHub: https://hub.docker.com/r/esteblock/soroban-preview/tags

# Usage
In this exemple we'll use Preview 10 (see https://soroban.stellar.org/docs/reference/releases)

Usually you would like not only to compile and test contracts, but also to deploy them using a quickstart node. Hence, in this example we will also run the stellar/quickstart container in the same docker network.

Note: Check your stellar/quickstart hash

1. C reate a common docker network
```
docker network create soroban-network
```

2. Run the stellar/quickstart container related to your preview (in this case preview 10)
```bash
docker run --rm -ti \
  --platform linux/amd64 \
  --name stellar \
  --network soroban-network \
  -p 8000:8000 \
  stellar/quickstart:soroban-dev@sha256:ed57f7a7683e3568ae401f5c6e93341a9f77d8ad41191bf752944d7898981e0c \
  standalone \
  --enable-soroban-rpc \
  --protocol-version 20 
```

3. Run the `esteblock/soroban-preview:10`. We will use the tag 10 for preview 10 :)
```bash
currentDir=$(pwd)
docker run --volume  ${currentDir}:/workspace \
           --name soroban-preview-10 \
           --interactive \
           --tty \
           -p 8001:8000 \
           --detach \
           --ipc=host \
           --network soroban-network \
           soroban-preview:10
```

Here we are calling the contanier `soroban-preview-10`. In this way you can have different containers with different preview versions in a same machine.

4. Execute your script inside the `soroban-preview-10` container. Here, instead of using http://localhost:8000, to call the quickstart container you just need to call `stellar:8000`, becase `stellar` is the name of the quickstart container that shares the same docker network with the `soroban-preview-10` container
```
docker exec soroban-preview-7 ./my_soroban_cli_script.sh MY_ARGS
```

## Open a soroban-preview terminal:

Sometimes all is easier if we open a terminal inside the soroban-preview container.
In order to do this easier, in your project create a file called `run.sh` and paste:

```bash
# run.sh
docker exec -it soroban-preview-10 bash
```

Next, you will just do 

1.- `bash run .sh`
2.- Inside the terminal, run all your scripts! Go and deploy those contracts!

___
___
# Publish image to Docker hub
```
cd preview_10
bash build.sh
docker push esteblock/soroban-preview:10
```
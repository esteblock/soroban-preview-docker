# soroban-preview-docker
Docker images to support Soroban Preview's setup.

# Usage
In this exemple we'll use Preview 7 (see https://soroban.stellar.org/docs/reference/releases)
In order to run an script using the preview:7 setup, you need to also run the stellar/quickstart container in the same docker network

1. (only once) create a common docker network
```
docker network create soroban-network
```
2. Run the stellar/quickstart container related to your preview (in this case preview 7)
```
docker run --rm -ti \
  --platform linux/amd64 \
  --name stellar \
  --network soroban-network \
  -p 8000:8000 \
  stellar/quickstart:soroban-dev@sha256:81c23da078c90d0ba220f8fc93414d0ea44608adc616988930529c58df278739 \
  standalone \
  --enable-soroban-rpc \
  --protocol-version 20 
```
3. Run the soroban-preview container
```
currentDir=$(pwd)
docker run --volume  ${currentDir}:/workspace \
           --name soroban-preview-7 \
           --interactive \
           --tty \
           -p 8001:8000 \
           --detach \
           --ipc=host \
           --network soroban-network \
           soroban-preview:7
```
4. Execute your script inside the soroban-preview container. Here, instead of using http://localhost:8000, to call the quickstart container you just need to call `stellar:8000`, becase "stellar" is the name of the quickstart container:
```
docker exec soroban-preview-7 ./my_soroban_cli_script.sh MY_ARGS
```

## Example:
In this example, we will wrap an asset using soroban-cli v0.6.0 (Preview 7)
```
cd example
./quickstart.sh standalone # this will run both quickstart and preview containers
docker exec soroban-preview-7 ./initialize.sh standalone #wrap
```


## Publish image to Docker hub
```
cd preview_7
bash build.sh
docker push esteblock/soroban-preview:7
```
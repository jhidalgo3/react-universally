.PHONY: image

IMAGE=docker-eb-example
CONTAINER=docker-eb-example-container

image: Dockerfile
	docker build -t $(IMAGE) .

# `make dev`
# spins up container for local development
dev: image
	-docker kill $(CONTAINER) 2> /dev/null
	-docker rm $(CONTAINER) 2> /dev/null
	docker run \
		--name $(CONTAINER) \
		--rm \
		-v `pwd`:/usr/src/app \
		-v /usr/src/app/node_modules/ \
		-p 3000:3000 \
		-it \
		$(IMAGE) \
		dev

# `make bash`
# connects to running docker container and provides bash access
bash:
	docker exec -it $(CONTAINER) /bin/bash
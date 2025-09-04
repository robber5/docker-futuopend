IMAGE ?= futuopend:amd64
CONTAINER ?= futuopend

build:
	echo "building docker image"
	docker buildx build --platform linux/amd64 -t $(IMAGE) --load .

run:
	echo "running docker image"
	docker run -d --name $(CONTAINER) \
		--env-file .env \
		-p 11111:11111 \
		$(IMAGE)
	
verify_code:
	echo "inputting phone verify code"
	docker exec $(CONTAINER) opendctl.sh ${CODE}

stop:
	echo "stopping docker container"
	docker stop $(CONTAINER) || true

clean:
	echo "cleaning up"
	docker rm -f $(CONTAINER) || true
	docker rmi $(IMAGE) || true
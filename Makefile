FUTU_OPEND_VERSION ?= 9.3.5308
IMAGE ?= futuopend:$(FUTU_OPEND_VERSION)
CONTAINER ?= futuopend

# 检测当前系统架构
ARCH := $(shell uname -m)

build:
	@echo "当前系统架构: $(ARCH)"
	@echo "FutuOpenD 版本: $(FUTU_OPEND_VERSION)"
ifeq ($(ARCH),x86_64)
	@echo "检测到 AMD64 架构，本地构建"
	docker buildx build --build-arg FUTU_OPEND_VERSION=$(FUTU_OPEND_VERSION) -t $(IMAGE) --load .
else
	@echo "检测到非 AMD64 架构 ($(ARCH))，执行跨平台构建"
	docker buildx build --platform linux/amd64 --build-arg FUTU_OPEND_VERSION=$(FUTU_OPEND_VERSION) -t $(IMAGE) --load .
endif

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
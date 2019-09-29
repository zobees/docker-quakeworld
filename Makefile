.PHONY: builder build buildershell shell clean

PROJECT=quakeworld
IMAGE=zobees/$(PROJECT)
BUILD_IMAGE=$(IMAGE)-build
BUILD_DIR=$(PWD)/build/mount
BUILD_MOUNT=/qw-build
DEST_DIR=$(PWD)/files/qw
DEST_MOUNT=/qw-dest

build: builder
	docker build -t $(IMAGE) .

builder:
	docker build -t $(BUILD_IMAGE) build
	docker run --rm -it -v $(BUILD_DIR):$(BUILD_MOUNT) -v $(DEST_DIR):$(DEST_MOUNT) $(BUILD_IMAGE)

buildershell:
	docker build -t $(BUILD_IMAGE) build
	docker run --rm -it -v $(BUILD_DIR):$(BUILD_MOUNT) -v $(DEST_DIR):$(DEST_MOUNT) $(BUILD_IMAGE) bash -l

clean:
	-@docker rmi $(BUILD_IMAGE)
	-@docker rmi $(IMAGE)
	rm -rf $(DEST_DIR)

default: build
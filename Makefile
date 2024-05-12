include env

all:
	podman build --build-arg KERNEL_VERSION=${KERNEL_VERSION} --build-arg DTK_IMAGE=${DTK_IMAGE} --build-arg RHCOS_IMAGE=${RHCOS_IMAGE} -t quay.io/jdhirst/r8125-kmod:0.0.1 .

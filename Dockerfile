ARG DTK_IMAGE
ARG RHCOS_IMAGE

FROM ${DTK_IMAGE} as builder
ARG KERNEL_VERSION

WORKDIR /build/

ADD src /build/src

WORKDIR /build/src

RUN make all install KVER=${KERNEL_VERSION}

FROM ${RHCOS_IMAGE}
ARG KERNEL_VERSION

COPY --from=builder /etc/driver-toolkit-release.json /etc/
COPY --from=builder /lib/modules/${KERNEL_VERSION}/kernel/drivers/net/ethernet/realtek/r8125*.ko /usr/lib/modules/${KERNEL_VERSION}/

# This is needed to autoload the module at boot time.
RUN depmod -a "${KERNEL_VERSION}" && echo simple_kmod > /etc/modules-load.d/simple_kmod.conf

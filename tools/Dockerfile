FROM alpine

ENV KUBE_LATEST_VERSION="v1.23.2"
ENV HELM_LATEST_VERSION="v3.8.0"

ARG TARGETARCH
ENV TARGETARCH=${TARGETARCH:-amd64}

RUN apk add --update ca-certificates \
 && apk add -t deps \
 && apk add --update curl \
 && export ARCH="$(uname -m)" && if [[ ${ARCH} == "x86_64" ]]; then export ARCH="amd64"; elif [[ ${ARCH} == "aarch64" ]]; then export ARCH="arm64"; fi && curl -L https://dl.k8s.io/release/${KUBE_LATEST_VERSION}/bin/linux/${ARCH}/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && curl -k -O https://get.helm.sh/helm-${HELM_LATEST_VERSION}-linux-${TARGETARCH}.tar.gz \
 && tar -xf helm-${HELM_LATEST_VERSION}-linux-${TARGETARCH}.tar.gz \
 && mv linux-${TARGETARCH}/helm /usr/local/bin \
 && apk del --purge deps \
 && rm /var/cache/apk/*

WORKDIR /root
ENTRYPOINT ["kubectl"]
CMD ["help"]
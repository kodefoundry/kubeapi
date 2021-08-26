FROM alpine:3.14 as builder
RUN apk add --no-cache curl
ARG arg
RUN apk add curl \
&& if [[ -z $arg ]]; then VER=$(curl https://storage.googleapis.com/kubernetes-release/release/stable.txt); else VER=$arg; fi \
&& wget  https://storage.googleapis.com/kubernetes-release/release/$VER/bin/linux/amd64/kubectl
FROM alpine:3.14
COPY --from=builder /kubectl /usr/local/bin/
RUN chmod +x /usr/local/bin/kubectl
EXPOSE 8001
#ENTRYPOINT ["/usr/local/bin/kubectl", "proxy"]

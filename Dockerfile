FROM ubuntu AS build

RUN \
  apt-get update && \
  apt-get install -y ldc gcc dub zlib1g-dev libssl-dev && \
  rm -rf /var/lib/apt/lists/*

COPY . /tmp
ENV DC=ldc2
WORKDIR /tmp

RUN dub -v build

FROM ubuntu

RUN \
  apt-get update && \
  apt-get install -y libphobos2-ldc-shared-dev libphobos2-ldc-shared98 zlib1g libssl-dev && \
  rm -rf /var/lib/apt/lists/*

COPY --from=build /tmp/deploy /

EXPOSE 8080

ENTRYPOINT ["/deploy"]
FROM golang:1.23 AS builder

ARG DRONE_TAG=latest

RUN apt-get update && apt-get install -y \
  make \
  && rm -rf /var/lib/apt/lists/*

COPY . /app/

WORKDIR /app
RUN go generate ./...
RUN make scenes

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
  ca-certificates \
  ffmpeg \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/scenes /bin/scenes

WORKDIR /app
COPY public /app/public
COPY migrations /app/migrations

CMD ["/bin/scenes"]

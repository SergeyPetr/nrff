# Stage 1 — Debian с пакетным менеджером
FROM debian:bookworm-slim AS builder

RUN apt-get update \
 && apt-get install -y --no-install-recommends ffmpeg curl ca-certificates \
 && rm -rf /var/lib/apt/lists/*


# Stage 2 — официальный n8n (distroless)
FROM docker.n8n.io/n8nio/n8n:latest

USER root

# Копируем бинарники ffmpeg и curl
COPY --from=builder /usr/bin/ffmpeg /usr/bin/ffmpeg
COPY --from=builder /usr/bin/ffprobe /usr/bin/ffprobe
COPY --from=builder /usr/bin/curl /usr/bin/curl
COPY --from=builder /etc/ssl/certs /etc/ssl/certs

RUN chown -R node:node /home/node/.n8n

USER node

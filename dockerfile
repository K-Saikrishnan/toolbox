ARG NGINX_VERSION=alpine3.22
ARG PNPM_VERSION=12.5.1

# ======================================================================================================================

FROM ghcr.io/pnpm/pnpm:${PNPM_VERSION} AS builder
COPY --from=ghcr.io/casey/just:1.58.0 /just /usr/local/bin/

ENV NODE_ENV=production

WORKDIR /app

COPY package.json pnpm-*.yaml .justfile ./

RUN --mount=type=cache,target=/root/.pnpm_cache just install_docker

COPY . .

RUN just build

# ======================================================================================================================

FROM nginxinc/nginx-unprivileged:${NGINX_VERSION} AS runner

COPY nginx.conf /etc/nginx/nginx.conf

COPY --chown=nginx:nginx --from=builder /app/dist/*/browser /usr/share/nginx/html

USER nginx

EXPOSE 8080

ENTRYPOINT ["nginx", "-c", "/etc/nginx/nginx.conf"]
CMD ["-g", "daemon off;"]

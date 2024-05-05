##### DEPENDENCIES

# ! Select linux/arm64 or linux/amd64 based on your platform
# ! in my case I have a M3 Macbook Pro with Apple M3 chip so I use linux/arm64
# ! but if you are not using any ARM Macbook then use linux/amd64
# FROM --platform=linux/amd64 node:20-alpine AS deps
FROM --platform=linux/arm64 node:20-alpine AS deps
RUN apk add --no-cache libc6-compat openssl
WORKDIR /app

# Install Prisma Client - remove if not using Prisma
#COPY prisma ./

# Install dependencies based on the preferred package manager

COPY package.json yarn.lock* package-lock.json* pnpm-lock.yaml\* ./

RUN \
    if [ -f yarn.lock ]; then yarn --frozen-lockfile; \
    elif [ -f package-lock.json ]; then npm ci; \
    elif [ -f pnpm-lock.yaml ]; then yarn global add pnpm && pnpm i; \
    else echo "Lockfile not found." && exit 1; \
    fi

##### BUILDER

# ! Select linux/arm64 or linux/amd64 based on your platform
# ! in my case I have a M3 Macbook Pro with Apple M3 chip so I use linux/arm64
# ! but if you are not using any ARM Macbook then use linux/amd64
# FROM --platform=linux/amd64 node:20-alpine AS builder
FROM --platform=linux/arm64 node:20-alpine AS builder
ARG DATABASE_URL
ARG NEXT_PUBLIC_CLIENTVAR
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

ENV NEXT_TELEMETRY_DISABLED 1

RUN \
    if [ -f yarn.lock ]; then SKIP_ENV_VALIDATION=1 yarn build; \
    elif [ -f package-lock.json ]; then SKIP_ENV_VALIDATION=1 npm run build; \
    elif [ -f pnpm-lock.yaml ]; then yarn global add pnpm && SKIP_ENV_VALIDATION=1 pnpm run build; \
    else echo "Lockfile not found." && exit 1; \
    fi

##### RUNNER

# ! Select linux/arm64 or linux/amd64 based on your platform
# ! in my case I have a M3 Macbook Pro with Apple M3 chip so I use linux/arm64
# ! but if you are not using any ARM Macbook then use linux/amd64
# FROM --platform=linux/amd64 gcr.io/distroless/nodejs20-debian12 AS runner
FROM --platform=linux/arm64 gcr.io/distroless/nodejs20-debian12 AS runner
WORKDIR /app

ENV NODE_ENV production

ENV NEXT_TELEMETRY_DISABLED 1

COPY --from=builder /app/next.config.js ./
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./package.json

COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/.next/static ./.next/standalone/static
COPY --from=builder /app/.next/types ./.next/standalone/types

EXPOSE 3000
ENV PORT 3000

CMD ["./.next/standalone/server.js"]

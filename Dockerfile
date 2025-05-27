# ------------------------
# ⚙️ Base Stage
# ------------------------
FROM node:24-slim AS base

# Set build-time environment variable
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

# System dependencies (for native modules)
RUN apt-get update && apt-get install -y \
  git \
  curl \
  build-essential \
  python3 \
  && rm -rf /var/lib/apt/lists/*

# Enable pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

WORKDIR /app

# Copy package manager files first
COPY package.json pnpm-lock.yaml ./

# Install dependencies
# - Install dev deps only in dev mode
RUN if [ "$NODE_ENV" = "development" ]; then \
  pnpm install --frozen-lockfile; \
  else \
  pnpm install --frozen-lockfile --prod; \
  fi

# ------------------------
# 🛠 Builder (for production)
# ------------------------
FROM base AS builder

COPY . .

RUN pnpm build


# ------------------------
# 🧪 Development Runtime
# ------------------------
FROM base AS dev

COPY . .

CMD ["pnpm", "dev"]


# ------------------------
# 🚀 Production Runtime
# ------------------------
FROM node:20-slim AS prod

# Enable pnpm again (optional at runtime)
RUN corepack enable && corepack prepare pnpm@latest --activate

WORKDIR /app

# Copy only runtime files from builder
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package.json /app/pnpm-lock.yaml ./
COPY --from=builder /app/node_modules ./node_modules

ENV NODE_ENV=production

CMD ["node", "dist/main"]

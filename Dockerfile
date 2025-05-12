# Base Node.js image
FROM node:20-alpine AS base

# Install pnpm
RUN corepack enable && corepack prepare pnpm@9.11.0 --activate

# Set working directory
WORKDIR /app

# Build stage
FROM base AS build

# Copy package.json and pnpm-lock.yaml
COPY package.json pnpm-lock.yaml ./

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy the rest of the application
COPY . .

# Build the application
RUN pnpm build

FROM base AS dev

ENV NODE_ENV=development

COPY --from=build /app/node_modules /app/node_modules

EXPOSE 3000

CMD ["pnpm", "dev", "--hostname", "0.0.0.0", "--port", "3000"]

# Production stage
FROM base AS production

# Set environment variables
ENV NODE_ENV=production

# Copy built application from build stage
COPY --from=build /app/.output /app/.output
COPY --from=build /app/public /app/public

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["node", ".output/server/index.mjs"]
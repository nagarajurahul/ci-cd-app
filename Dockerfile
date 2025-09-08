# FROM node:24-alpine
# WORKDIR /app
# COPY app/package*.json ./
# RUN npm install
# COPY app/ .
# EXPOSE 3000
# CMD ["node", "index.js"]

# Use official lightweight Node.js LTS image
FROM node:24-alpine AS base

# Set working directory inside container
WORKDIR /app

# Install dependencies separately for caching, avoid using npm install
COPY app/package*.json ./
RUN npm ci --omit=dev

# Copy application source
COPY app/ .

# Add a non-root user for security
RUN addgroup -S nodejs && adduser -S nodeuser -G nodejs

# Use non-root user
USER nodeuser

# Expose application port
EXPOSE 3000

# Healthcheck (optional but good practice)
# HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
#   CMD wget -qO- http://localhost:3000/health || exit 1

# Run the app
CMD ["node", "index.js"]

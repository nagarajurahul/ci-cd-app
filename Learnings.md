🔑 Best Practices for a Node.js Dockerfile

1. Use Official Node Base Images

Always start from an official node:<version> image (e.g., node:20-alpine).

Prefer Alpine (lightweight) or Distroless (secure, minimal) for production.

2. Multi-Stage Builds

Builder stage: install dependencies, compile TypeScript or build frontend assets.

Runtime stage: copy only the built app + required node_modules.

3. Layer Caching Optimization

Copy package*.json first → run npm ci or yarn install → then copy app source.
(This way dependencies are cached unless they change.)

4. Security Hardening

Run as a non-root user.

Drop unnecessary packages.

Use npm ci instead of npm install for reproducible builds.

Avoid leaving .env or secret files in the image.

5. Observability & Health

Expose only the needed port.

Add a HEALTHCHECK instruction to detect container issues.

6. Minimize Attack Surface

Use .dockerignore to exclude logs, .git, node_modules (if building inside container).

Avoid latest tags — pin Node.js version.
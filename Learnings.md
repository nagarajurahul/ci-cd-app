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



New Learnings

pinning and using minimal lts base versions for docker images

npm ci vs npm install

running container as non-root user

Working directory is app/ folder

Installing eslint through package.json

Double-quotes are more standard

const js = require("@eslint/js"); -> old style -> requires adding sourceType: "commonjs" in lint

vs

import js from "@eslint/js"; -> new style called ESM -> requires adding { "type": "module" } in package.json and sourceType: "module" in eslint

also adding eslint-plugin for console error

You need to install everything through npm i -> to update packages

no no -> turn off imports


Trivy

- You can also have a template
- Provide imageref or scanref
- various formats available
- enabling permissions for sarif upload
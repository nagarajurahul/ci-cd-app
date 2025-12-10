// const express = require("express");
// const app = express();
// app.get("/", (req, res) => res.send("Hello from CI/CD pipeline, NodeJS, Docker, GitHub Actions, Helm Charts, ArgoCD, ArgoCD Image Updater, Kubernetes!"));
// app.listen(3000, () => console.log("App running on port 3000"));

import express from "express";

const app = express();
app.get("/", (req, res) =>
  res.send(
    "Hello from Home Lab Server - 120"
  )
);
app.listen(3000, () => console.log("App running on port 3000"));

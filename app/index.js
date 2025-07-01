const express = require('express');
const app = express();
app.get('/', (req, res) => res.send('Hello from CI/CD pipeline, Great learning and grateful for it! Here I come, from my K8s server - node2 and argocd and image updater -bupdate 2!'));
app.listen(3000, () => console.log('App running on port 3000'));

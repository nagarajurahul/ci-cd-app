const express = require('express');
const app = express();
app.get('/', (req, res) => res.send('Hello from CI/CD pipeline and GitHub workflow 2!'));
app.listen(3000, () => console.log('App running on port 3000'));

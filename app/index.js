const express = require('express');
const app = express();
app.get('/', (req, res) => res.send('Hello from CI/CD pipeline, Great learning and grateful for it! Here I come, from EC2 again-testing in the nigh 2t!'));
app.listen(3000, () => console.log('App running on port 3000'));

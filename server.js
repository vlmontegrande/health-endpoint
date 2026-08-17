import express from 'express';

import { spawn } from 'node:child_process';
import { once } from 'node:events';

const port = process.env.PORT || 8080;

const app = express();

app.get('/', async function(req, res) {
  const script = spawn('./server-health.sh');

  script.stdout.on('data', (data) => {
    res.header('Content-Type', 'application/json');
    res.send(data);
  });

  script.stderr.on('data', (data) => {
    console.error(`stderr: ${data}`);
  });

  const [code] = await once(script, 'close');

  console.log(`server health script exited with code ${code}`);
});

app.listen(port, () => console.log(`Running on port ${port}!`));

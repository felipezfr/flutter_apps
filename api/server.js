console.log('Arquivo server.js executou com sucesso!');

// Constantes
const port = process.env.API_PORT || 3000;
const host = process.env.API_HOST || '0.0.0.0';

// usar o express
const express = require('express');
const app = express();
app.use(express.json()); // para tratar json

// usar o momgo
require('./server/banco/mongo');
// Usar as rotas
const routes = require('./server/routes/index');
app.use(routes);

app.listen(port, host, function () {
  console.log(`API executando na porta ${port}`);
});

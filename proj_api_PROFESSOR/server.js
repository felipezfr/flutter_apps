console.log('Arquivo server.js executou com sucesso!');
require("dotenv").config();
// usar o express
const express = require('express');

const app = express();
app.use(express.json()); // para tratar json

// usar o momgo
require('./server/banco/mongo');
// Usar as rotas
const routes = require('./server/routes/index');
app.use(routes);

// definir porta para a API de serviço
const port = process.env.API_PORT;

app.listen(port, () => {
   return console.log('API executando na porta ' + port);
});

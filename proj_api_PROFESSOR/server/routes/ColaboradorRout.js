const express = require('express');
const routes = express.Router();
const controle = require('../controller/ProjetoCont');


routes.route('/').get(controle.listar);
routes.route('/').post(controle.incluir);
routes.route('/').put(controle.alterar);
routes.route('/:id').delete(controle.excluir);
routes.route('/:id').get(controle.obterPeloId);
routes.route('/filtro/:filtro').get(controle.filtrar);

module.exports = routes;

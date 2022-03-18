const { Router } = require('express');
const routes = Router();
const usuarioRout = require('./UsuarioRout');
routes.use('/api/usuarios', usuarioRout);
module.exports = routes;

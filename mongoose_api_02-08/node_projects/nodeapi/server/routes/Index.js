const { Router } = require("express");
const routes = Router();
const usuarioRout = require("./UsuarioRout");
const atividadeRout = require("./AtividadeRout");
const projetoRout = require("./ProjetoRout");
const colaboradorRout = require("./ColaboradorRout");


routes.use("/api/usuarios", usuarioRout);
routes.use("/api/atividades", atividadeRout);
routes.use("/api/projetos", projetoRout);
routes.use("/api/colaboradores", colaboradorRout);



module.exports = routes;
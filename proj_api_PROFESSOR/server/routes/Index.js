const { Router } = require("express");
const jwt = require("jsonwebtoken");
const routes = Router();

// Liberar origens para requisições
var cors = require('cors');
routes.use(cors({origin: '*'}));
//routes.use(cors({origin: 'http://localhost:3001'}));


const loginRout = require("./LoginRout");
routes.use("/api", loginRout);

/*
routes.use(function (req, res, next) { // interceptar as requisições a validar o token
    try {
        const token = req.header("x-auth-token");
        if (!token) return res.status(403).send(
            { message: 'Não possui token de autenticação. Acesso não autorizado!' });
        jwt.verify(token, process.env.JWT_PRIV_KEY, function (err, decoded) {
            if (err) return res.status(500).send({
                auth: false,
                message: 'Token inválido. Acesso não autorizado!'
            });
            // estando tudo certo guarda no request para uso posterior
            req.userId = decoded._id;
            req.userName = decoded.nome;
            next();
        });
    } catch (error) {
        res.status(400).send("Erro no token de autenticação!");
    }
});
*/


const usuarioRout = require("./UsuarioRout");
const atividadeRout = require("./AtividadeRout");
const projetoRout = require("./ProjetoRout");
const colaboradorRout = require("./ColaboradorRout");


routes.use("/api/usuarios", usuarioRout);
routes.use("/api/atividades", atividadeRout);
routes.use("/api/projetos", projetoRout);
routes.use("/api/colaboradores", colaboradorRout);



module.exports = routes;
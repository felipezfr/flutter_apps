const Usuario = require('../model/UsuarioSchema');
const bcrypt = require("bcrypt");

module.exports = {
    listar: async (req, res) => {
        await Usuario.find((err, objetos) => {
            (err ? res.status(400).send(err) : res.status(200).json(objetos));
        }).sort({ nome: 1 }); // -1 decrescente 1 crescente
    },
    incluir: async (req, res) => {
        let obj = new Usuario(req.body);
        await obj.save((err, obj) => {
            (err ? res.status(400).send(err) : res.status(200).json(obj));
        });
    },
    alterar: async (req, res) => {
        let obj = new Usuario(req.body);
        await Usuario.updateOne({ _id: obj._id }, obj, function (err) {
            (err ? res.status(400).send(err) : res.status(200).json(obj));
        });
    },
    excluir: async (req, res) => {
        await Usuario.deleteOne({ _id: req.params.id }, function (err) {
            (err ? res.status(400).send(err) : res.status(200).json("message:ok"));
        });
    },
    obterPeloId: async (req, res) => {
        const obj = await Usuario.findOne({ _id: req.params.id }, function (err) {
            if (err)
                res.status(400).send(err);
        });
        res.status(200).json(obj);
    },
    filtrar: async (req, res) => {
        const objetos = await Usuario.find({
            $or: [
                { nome: { $regex: req.params.filtro, $options: "i" } },
                { email: { $regex: req.params.filtro, $options: "i" } },
            ],
        }, function (err) {
            if (err)
                res.status(400).send(err);
        }).sort({ nome: -1 }); // -1 decrescente 1 crescente
        res.json(objetos);
    },
    alterarSenha: async (req, res) => {
        let obj = new Usuario(req.body);
        const salt = await bcrypt.genSalt(Number(process.env.BCRYPT_SALT));
        obj.senha = await bcrypt.hash(obj.senha, salt);
        await Usuario.updateOne({ _id: obj._id }, obj, function (err) {
            (err ? res.status(400).send(err) : res.status(200).json(obj));
        });
    },
    login: async (req, res) => {
        const obj = await Usuario.findOne({ email: req.body.email }, function (err) {
            if (err)
                res.status(400).send(err);
        });
        if (!obj)
            res.status(401).send("Email inválido");
        //se passar daqui precisasom validar a senha
        const valido = await bcrypt.compare(req.body.senha, obj.senha);
        if (!valido) {
            res.status(401).send("Senha inválida");
        }
        // se estiver tudo certo, gerar um token e enviar para o cliente
        const token = obj.generateAuthToken();
        res.send(token);
        res.status(200).json(obj);
    },

    logout: async (req, res) => {
        res.status(200).send({ token: null });
    }

};


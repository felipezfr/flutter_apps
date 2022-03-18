const Projeto = require('../model/ProjetoSchema');

module.exports = {
    listar: async (req, res) => {
        await Projeto.find((err, objetos) => {
            (err ? res.status(400).send(err) : res.status(200).json(objetos));
        }).populate('responsavel').sort({ titulo: 1 }); // -1 decrescente 1 crescente

    },
    //Busca somente os projetos com responsavel igual o usuario logado 
    listarID: async (req, res) => {
        const objetos = await Projeto.find({
            responsavel: req.params.filtro
        }, function (err) {
            if (err)
                res.status(400).send(err);
        }).populate('responsavel').sort({ titulo: -1 }); // -1 decrescente 1 crescente
        res.json(objetos);
    },
    incluir: async (req, res) => {
        let obj = new Projeto(req.body);
        await obj.save((err, obj) => {
            (err ? res.status(400).send(err) : res.status(200).json(obj));
        });
    },
    alterar: async (req, res) => {
        let obj = new Projeto(req.body);
        console.log(obj)
        await Projeto.updateOne({ _id: obj._id }, obj, function (err) {
            (err ? res.status(400).send(err) : res.status(200).json(obj));
        });
    },
    excluir: async (req, res) => {
        await Projeto.deleteOne({ _id: req.params.id }, function (err) {
            (err ? res.status(400).send(err) : res.status(200).json("message:ok"));
        });
    },
    obterPeloId: async (req, res) => {
        const obj = await Projeto.findOne({ _id: req.params.id }, function (err) {
            if (err)
                res.status(400).send(err);
        });
        res.status(200).json(obj);
    },
    filtrar: async (req, res) => {
        const objetos = await Projeto.find({
            $or: [
                { titulo: { $regex: req.params.filtro, $options: "i" } },
                { descricao: { $regex: req.params.filtro, $options: "i" } },
            ],
        }, function (err) {
            if (err)
                res.status(400).send(err);
        }).populate('responsavel').sort({ titulo: -1 }); // -1 decrescente 1 crescente
        res.json(objetos);
    },
};


const Atividade = require('../model/AtividadeSchema');

module.exports = {
    listar: async (req, res) => {
        await Atividade.find((err, objetos) => {
            (err ? res.status(400).send(err) : res.status(200).json(objetos));
        }).populate('responsavel').populate('projeto').sort({ titulo: 1 }); // -1 decrescente 1 crescente
    },
    listarID: async (req, res) => {
        // const {id: responsavel_id} = res.body
        const objetos = await Atividade.find({
            projeto: req.params.filtro
        }, function (err) {
            if (err)
                res.status(400).send(err);
        }).populate('responsavel').populate('projeto').sort({ titulo: -1 }); // -1 decrescente 1 crescente
        res.json(objetos);

        // const atividades = await Atividade.find((err) => {
        //     if (err) res.status(400).send(err)
        // }).populate('responsavel').populate('projeto').sort({ titulo: 1 }); // -1 decrescente 1 crescente

        // var atvsFiltrados = [];
        // atividades.forEach(atividade => {
        //     if (atividade.responsavel._id == req.params.filtro) {
        //         atvsFiltrados.push(atividade)
        //     }
        // });
        // console.log("atividades")
        // res.status(200).json(atvsFiltrados);
    },
    incluir: async (req, res) => {
        let obj = new Atividade(req.body);
        await obj.save((err, obj) => {
            (err ? res.status(400).send(err) : res.status(200).json(obj));
        });
    },
    alterar: async (req, res) => {
        let obj = new Atividade(req.body);
        await Atividade.updateOne({ _id: obj._id }, obj, function (err) {
            (err ? res.status(400).send(err) : res.status(200).json(obj));
        });
    },
    excluir: async (req, res) => {
        await Atividade.deleteOne({ _id: req.params.id }, function (err) {
            (err ? res.status(400).send(err) : res.status(200).json("message:ok"));
        });
    },
    obterPeloId: async (req, res) => {
        const obj = await Atividade.findOne({ _id: req.params.id }, function (err) {
            if (err)
                res.status(400).send(err);
        });
        res.status(200).json(obj);
    },
    filtrar: async (req, res) => {
        const objetos = await Atividade.find({
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


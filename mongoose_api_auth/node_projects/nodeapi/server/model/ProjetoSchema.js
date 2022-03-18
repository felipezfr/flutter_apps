const mongoose = require("mongoose");

const ProjetoSchema = new mongoose.Schema({
    titulo: { type: String, required: true },
    descricao: { type: String, required: true},
    dataInicio: { type: Date },
    dataTermino: { type: Date },
    nomeDemandante: { type: String },
    responsavel: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Usuario',
        required: true
    }
});

module.exports = mongoose.model("Projeto", ProjetoSchema);
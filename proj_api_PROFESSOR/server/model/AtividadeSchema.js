const mongoose = require("mongoose");

const AtividadeSchema = new mongoose.Schema({
    titulo: { type: String, required: true },
    descricao: { type: String, required: true},
    dataInicio: { type: Date },
    dataTermino: { type: Date },
    horas: { type: String },
    responsavel: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Usuario',
        required: true
    },
    projeto: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Projeto',
        required: true
    }
});

module.exports = mongoose.model("Atividade", AtividadeSchema);
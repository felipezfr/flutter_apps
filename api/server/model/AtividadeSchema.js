const mongoose = require('mongoose');

const AtividadeSchema = new mongoose.Schema({
  titulo: { type: String, required: true, unique: true },
  descricao: { type: String, required: true },
  dataInicio: { type: Date },
  dataTermino: { type: Date },
  usuario: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Usuario',
    require: true,
  },
});

module.exports = mongoose.model('Atividade', AtividadeSchema);

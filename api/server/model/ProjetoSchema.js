const mongoose = require('mongoose');

const ProjetoSchema = new mongoose.Schema({
  titulo: { type: String, required: true, unique: true },
  descricao: { type: String, required: true },
  dataInicio: { type: Date },
  dataTermino: { type: Date },
  nomeDemandante: { type: String, required: true },
  usuario: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Usuario',
    require: true,
  },
});

module.exports = mongoose.model('Projeto', ProjetoSchema);

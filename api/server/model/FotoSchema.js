const mongoose = require('mongoose');
const UsuarioSchema = new mongoose.Schema({
  nome: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  celular: String,
  senha: String,
  dataHoraCad: { type: Date },
});
module.exports = mongoose.model('Usuario', UsuarioSchema);

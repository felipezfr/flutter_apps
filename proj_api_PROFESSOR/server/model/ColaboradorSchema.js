const mongoose = require("mongoose");

const ColaboradorSchema = new mongoose.Schema({
    
    usuario: {
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

module.exports = mongoose.model("Colaborador", ColaboradorSchema);
console.log('Arquivo server.js executou com sucesso!');

// usar o express
const express = require('express');
const app = express();
app.use(express.json()); // tratar json

// conexão com mongoBD
//const MongoClient = require('mongodb').MongoClient;
//const ObjectId = require('mongodb').ObjectId;
const uri = "mongodb://admin:admin@localhost:27017/meuteste?authSource=meuteste";

const mongoose = require('mongoose');
mongoose.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true });


const db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', function () {
   // we're connected!
   // subir serviço da api na porta 4000 
   app.listen(4000, function () {
      console.log('API rodando na porta 4000');
      console.log('Testar por http://localhost:4000');
   })

});

const AnimalSchema = new mongoose.Schema({
   nome: { type: String, required: true, unique: true },
   tipo: String,
   idade: { type: Number, required: true },
}, { collection: 'animais' });

const Animal = mongoose.model('Animal', AnimalSchema);


// prerarar para responder ao GET
app.get('/', (req, res) => {
   res.send('Atendida a requisição GET!!');
});

app.get('/animais', (req, res) => {
   //res.send('retornar animais');
   Animal.find(function (err, results) {
      if (err) throw err;
      res.json(results);
   })
});
//inserir
app.post('/animais', (req, res, next) => {
   const obj = new Animal(req, body);
   obj.save((errm, obj) =>{
      if (err) throw err;
      res.json({ success: "Incluído com sucesso." });
   })
});




console.log('Arquivo server.js executou com sucesso!');

// usar o express
const express = require('express');
const app = express();
app.use(express.json()); // tratar json

// conexão com mongoBD
const MongoClient = require('mongodb').MongoClient;
const ObjectId = require('mongodb').ObjectId;
const uri = "mongodb://admin:admin@localhost:27017/meuteste?authSource=meuteste";


MongoClient.connect(uri, (err, client) => {
   if (err)
      return console.log(err);

   db = client.db('atividade');
   // subir serviço da api na porta 3000 
   app.listen(3001, function () {
      console.log('API rodando na porta 3000');
      console.log('Testar por http://localhost:3000');
   });
});

// prerarar para responder ao GET
app.get('/', (req, res) => {
   res.send('Atendida a requisição GET!!');
});

app.get('/usuario', (req, res) => {
   //res.send('retornar usuario');
   db.collection('usuario').find().toArray((err, results) => {
      if (err) return console.log(err);
      res.json(results);
   });
});
//inserir
app.post('/usuario', (req, res, next) => {
   db.collection('usuario').insertOne(req.body, (err, result) => {
      if (err) throw err;
      res.json({ success: "Incluído com sucesso." });
   })
});
//alterar
app.put('/usuario', (req, res) => {
   var id = ObjectId(req.body._id);
   var newvalues = {
      $set: {
         nome: req.body.nome,
         email: req.body.email,
         senha: req.body.senha,
         celular: req.body.celular,
      }
   };
   db.collection('usuario').updateOne(
      { _id: id },
      newvalues,
      (err, result) => {
         if (err) throw err;
         if (result.modifiedCount < 1)
            return res.json({ aviso: "Nada alterado." });
         res.json({ success: "Alterado com sucesso." });
      })
});

//exclusão
app.delete('/usuario/:id', (req, res) => {
   var id = ObjectId(req.params.id);
   db.collection('usuario').deleteOne({ _id: id }, (err, result) => {
      if (err) throw err;
      if (result.deletedCount < 1)
         return res.json({ aviso: "Nada excluído." });
      res.json({ success: "Excluído com sucesso." });
   });
});

//get pelo id
app.get('/usuario/:id', (req, res) => {
   var id = ObjectId(req.params.id);
   db.collection('usuario').findOne({ _id: id }, (err, result) => {
      if (err) throw err;
      res.json(result);
   });
});

//get com filtro
app.get('/usuario/filtro/:valor', (req, res) => {
   db.collection('usuario').find({
      $or: [
         { nome: { $regex: req.params.valor, $options: "i" } },
         { email: { $regex: req.params.valor, $options: "i" } },
      ],
   }).toArray((err, results) => {
      if (err) throw err;
      res.json(results);
   });
});
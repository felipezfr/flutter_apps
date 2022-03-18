const mongoose = require('mongoose');

// Constantes
const uri = process.env.MONGO_URL_DATABASE;

mongoose.connect(uri, {
  // useUnifiedTopology: true,
  // useCreateIndex: true,
  // useFindAndModify: false,
  // useNewUrlParser: true,
});

const mongoose = require("mongoose");
const uri = "mongodb://admin:admin@localhost:27017/meuteste?authSource=usuarios";

mongoose.connect(uri, {
    useUnifiedTopology: true,
    useCreateIndex: true,
    useFindAndModify: false,
    useNewUrlParser: true,
});

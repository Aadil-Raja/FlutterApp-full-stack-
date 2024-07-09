const mongoose = require("mongoose");

mongoose.connect("mongodb://0.0.0.0:27017/flutterapp", {
    useNewUrlParser: true,
    useUnifiedTopology: true
})
.then(() => {
    console.log("MongoDB connected");
})
.catch((error) => {
    console.log('MongoDB connection failed:', error);
});

const newSchema = new mongoose.Schema({
    email: {
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true
    }
});

const collection = mongoose.model("sigin", newSchema);

module.exports = collection;

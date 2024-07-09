const express = require("express");
const app = express();
const mongo=require("./mongo");
const cors=require("cors");
const bodyParser=require("body-parser");
app.use(cors());
app.use(bodyParser.urlencoded({extended:true}))
app.use(bodyParser.json());


app.use('/',require('./router'))

app.get('/', (req, res) => {
    res.send("hello worldddddd");
});

app.listen(5000, () => {
    console.log("server listening");
});

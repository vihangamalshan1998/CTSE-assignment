const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const cors = require("cors");
const dotenv = require("dotenv");

const app = express();
require("dotenv").config();
//Port number
const PORT = process.env.PORT || 8070;

app.use(cors());
app.use(bodyParser.json());

//Call the mongodb url
const URL = process.env.MONGODB_URL;

mongoose.connect(URL, {
    useCreateIndex: true,
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useFindAndModify: false
})

//Check the MongoDB connection
const connection = mongoose.connection;
connection.once("open", () => {
    console.log("MongoDB Connection success!");
})

//import routes
const flowersRouter = require("./routes/flowers");
const userRouter = require('./routes/user.js');
const diseaseRouter = require('./routes/disease.js');
const fertilizerRouter = require('./routes/fertilizerRoute');

//calling routes
app.use("/flowers",flowersRouter);
app.use("/users",userRouter);
app.use("/diseases",diseaseRouter);
app.use("/fertilizer",fertilizerRouter);

app.listen(PORT, () => {
    console.log("Server is up and running")
})

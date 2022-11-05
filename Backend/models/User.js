const mongoose = require('mongoose');

const Schema = mongoose.Schema;
//User Schema
const userSchema = new Schema({
    userName : {
        type : String,
        required: false
    },
    firstName:{
        type : String,
        required: false
    },
    lastName:{
        type : String,
        required: false
    },
    password:{
        type : String,
        required: false
    },
    userType:{
        type : String,
        required: false
    }

});

const Users = mongoose.model("Users",userSchema);

module.exports = Users;
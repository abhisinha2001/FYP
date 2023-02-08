const express = require('express');
const mongoose = require('mongoose');
const config = require('dotenv').config();
const app = express();

const PASSWORD = process.env.PASSWORD

mongoose.set('strictQuery',false);
mongoose.connect(`mongodb+srv://admin:`+PASSWORD+`@cluster0.tzrbc9a.mongodb.net/?retryWrites=true&w=majority`)
.then(()=>app.listen(3000))
.then(()=>console.log("Connected to Database"))
.catch((err)=>console.log(err));

app.get('/',(req,res)=>{
    res.send('We are at home');
})
//Routes


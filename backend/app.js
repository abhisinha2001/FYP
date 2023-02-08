const express = require('express');
const mongoose = require('mongoose');
const app = express();

mongoose.set('strictQuery',false);
mongoose.connect('mongodb+srv://admin:Something12345@cluster0.tzrbc9a.mongodb.net/?retryWrites=true&w=majority')
.then(()=>app.listen(3000))
.then(()=>console.log("Connected to Database"))
.catch((err)=>console.log(err));

app.get('/',(req,res)=>{
    res.send('We are at home');
})
//Routes


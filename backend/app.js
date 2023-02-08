const express = require('express');

const app = express();

app.get('/',(req,res)=>{
    res.send('We are at home');
})
//Routes

app.listen(3000);
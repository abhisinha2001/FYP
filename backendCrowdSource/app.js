const express = require("express");
const fileUpload = require("express-fileupload");

const app = express();

app.use(fileUpload());

// app.use(fileUpload({limits:{fileSize:10000000},abortOnLimit:true}))

app.use(express.static('public'));

app.post('/upload',(req,res)=>{
    const {image} = req.files;
    if(!image) return res.sendStatus(400);

    image.mv(__dirname+'/upload/'+image.name);
    res.sendStatus(200);

});

app.get('/',(req,res)=>{
    res.send("We are at home");
})
app.listen(3000);

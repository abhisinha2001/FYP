const express = require('express');
const sizeof = require('object-sizeof')
const mongoose = require('mongoose');
const fs = require('fs');
const {Schema} =mongoose;
const { generateApiKey } = require('generate-api-key');
const { start } = require('repl');
const config = require('dotenv').config();
const app = express();


const PASSWORD = process.env.PASSWORD

const currLat = 53.330822;
const currLong =  -6.258903;

mongoose.set('strictQuery',false);
mongoose.connect(`mongodb+srv://admin:`+PASSWORD+`@cluster0.tzrbc9a.mongodb.net/?retryWrites=true&w=majority`)
.then(()=>app.listen(3000))
.then(()=>console.log("Connected to Database"))
.catch((err)=>console.log(err));

const cctvSchema = new Schema({
        "cctv_id": Number,
        "cctv_road": String,
        "lat": Number,
        "long": Number,
        "policy_url": String,
        "Phone": String,
        "Email": String,
        "photos": [String],
        "permissions":{
            "retention":String,
            "storage":Boolean,
            "facial_recognition":Boolean
        }
})
const cctvOrignialSchema = new Schema({
    "_id":Number,
      "SiteID": Number,
      "Site_Description_Cap": String,
      "Lat": Number,
      "Long": Number
})

const cctv = mongoose.model('cctv',cctvSchema);

const cctv_orginal = mongoose.model('cctv_original',cctvOrignialSchema);

function putData(){
    fs.readFile('./data_original.json','utf-8',(err,data)=>{
        if(err){
            console.log(err);
            return;
        }
        const jsonData = JSON.parse(data);
        cctv_orginal.insertMany(jsonData)
    .then(function(){
        console.log("Data Inserted") // Success
    }).catch(function(error){
        console.log(error)      // Failure
    });
    });
}
function calcDistance(lat1,lat2,long1,long2){
    long1 =  long1 * Math.PI / 180;
    long2 = long2 * Math.PI / 180;
    lat1 = lat1 * Math.PI / 180;
    lat2 = lat2 * Math.PI / 180;
   
        // Haversine formula
        let dlon = long2 - long1;
        let dlat = lat2 - lat1;
        let a = Math.pow(Math.sin(dlat / 2), 2)
                 + Math.cos(lat1) * Math.cos(lat2)
                 * Math.pow(Math.sin(dlon / 2),2);
               
        let c = 2 * Math.asin(Math.sqrt(a));
   
        // Radius of earth in kilometers. Use 3956
        // for miles
        let r = 6371;
   
        // calculate the result
        return(c * r);
}

//Routes

app.get('/requestAPIKey',(req,res)=>{
    const key = generateApiKey();
    //add key to database after data controller verification.
    res.send(key);
})


app.post('/allcctvinformation',(req,res)=>{
    fs.readFile('./data_modified.json','utf-8',(err,data)=>{
        if(err){
            console.log(err);
            return;
        }
        const jsonData = JSON.parse(data);
    cctv.insertMany(jsonData).
    then(function(){
    console.log("Data inserted")
    res.sendStatus(200)  // Success
}).catch(function(error){
    console.log(error)      // Failure
});

})
    
    
})

app.post('/cctvinformation',(req,res)=>{
    if(req.body.apiKey!=null){
        //Check if databse containes API key and validate insert.
    }
    else{
        res.sendStatus(401);
    }
})
app.get('/getnearbyOriginal',(req,res)=>{
    finalResult=[];
    // currLat = req.query.lat;
    // currlong = req.quesry.long;
    let startTime = Date.now();
    cctv_orginal.find().then((result)=>{
        for(let index in result){
            lat1 = result[index]['Lat'];
            long1 = result[index]['Long'];
            distance = calcDistance(lat1,currLat,long1,currLong);
            if(distance<=1){
                finalResult.push(result[index]);
            }
        }
        res.send(finalResult);
        console.log(sizeof(finalResult)+" Bytes");
    }).catch((err)=>{
        console.log(err);
    });
    let endTime = Date.now();
    console.log("Elapsed Time: "+(endTime-startTime));
})
app.get('/getnearby',(req,res)=>{
    finalResult=[];
    // currLat = req.query.lat;
    // currlong = req.quesry.long;
    cctv.find().then((result)=>{
        for(let index in result){
            lat1 = result[index]['lat'];
            long1 = result[index]['long'];
            distance = calcDistance(lat1,currLat,long1,currLong);
            if(distance<=1){
                finalResult.push(result[index]);
            }
        }
        res.send(finalResult);
    }).catch((err)=>{
        console.log(err);
    });
    
    

})

app.get('/allCCTVOriginal',(req,res)=>{
let startTime = Date.now();
    cctv_orginal.find().then((result)=>{
        res.send(result)
        console.log(sizeof(result)+" Bytes")
}).catch((err)=>{
    console.log(err)
})
let endTime = Date.now();
    console.log("Elapsed Time: "+(endTime-startTime));
})

app.get('/allcctvs',(req,res)=>{
    cctv.find().then((result)=>{
        res.send(result)
}).catch((err)=>{
    console.log(err)
})
})

app.get('/',(req,res)=>{
    res.send('We are at home');
})

// putData();

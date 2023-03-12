const express = require('express');
const mongoose = require('mongoose');
const {Schema} =mongoose;
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

const cctv = mongoose.model('cctv',cctvSchema);

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

// cctv.insertMany(
//     [
//         {
//          "cctv_id": 39,
//          "cctv_road": "Harcourt St ",
//          "lat": 53.333965,
//          "long": -6.263233,
//          "policy_url": "https:\/\/www.cctvireland.ie\/pub\/pdf\/Garda-Guidlines-on-CCTV-in-Ireland.pdf",
//          "Phone": "01 6663805",
//          "Email": "",
//          "photos": null,
//          "permissions": {"retention":"28","storage":true,"facial_recognition":false}
//         },
//         {
//          "cctv_id": 52,
//          "cctv_road": "Parnell St ",
//          "lat": 53.350357,
//          "long": -6.266422,
//          "policy_url": "https:\/\/www.odce.ie\/Portals\/0\/Documents\/Functions\/ODCE_Policy_on_CCTV_June_2019.pdf",
//          "Phone": "",
//          "Email": "info@odce.ie",
//          "photos": null,
//          "permissions": {"retention":"60","storage":false,"facial_recognition":false}
//         },
//         {
//          "cctv_id": 203,
//          "cctv_road": "Richmond St South",
//          "lat": 53.330227,
//          "long": -6.264374,
//          "policy_url": "https:\/\/www.richmond.gov.uk\/cctv",
//          "Phone": "020 8831 6001",
//          "Email": "",
//          "photos": null,
//          "permissions": {"retention":"28","storage":true,"facial_recognition":true}
//         },
//         {
//          "cctv_id": 204,
//          "cctv_road": "Ranelagh Rd",
//          "lat": 53.330338,
//          "long": -6.259884,
//          "policy_url": "https:\/\/www.ranelagh.bonitas.org.uk\/wp-content\/uploads\/Ranelagh-Privacy-Notice-Parents-Carers-2.pdf",
//          "Phone": "0303 123 1113",
//          "Email": "",
//          "photos": null,
//          "permissions": {"retention":"30","storage":true,"facial_recognition":true}
//         },
//         {
//          "cctv_id": 218,
//          "cctv_road": "Charlemont Place ",
//          "lat": 53.330822,
//          "long": -6.258903,
//          "policy_url": "https:\/\/www.claytonhotelcharlemont.com\/privacy-statement\/",
//          "Phone": "+353 (0)1 960 6700",
//          "Email": "res.charlemont@claytonhotels.com",
//          "photos": null,
//          "permissions": {"retention":"90","storage":true,"facial_recognition":false}
//         },
//         {
//          "cctv_id": 237,
//          "cctv_road": "Merrion Sq North  \/ Merrion Sq West",
//          "lat": 53.341104,
//          "long": -6.250811,
//          "policy_url": "https:\/\/www.nationalgallery.ie\/what-we-do\/governance\/privacy-and-data-protection\/privacy-notice",
//          "Phone": "+ 353 1 661 5133",
//          "Email": "",
//          "photos": null,
//          "permissions": {"retention":"60","storage":true,"facial_recognition":true}
//         },
//         {
//          "cctv_id": 276,
//          "cctv_road": "Stephen's Green ",
//          "lat": 53.337704,
//          "long": -6.262714,
//          "policy_url": "https:\/\/stephensgreen.com\/privacy-policy\/",
//          "Phone": "+353 (01) 4780888",
//          "Email": "info@stephensgreen.com",
//          "photos": null,
//          "permissions": {"retention":"120","storage":true,"facial_recognition":true}
//         },
//         {
//          "cctv_id": 282,
//          "cctv_road": "Dawson Street",
//          "lat": 53.341327,
//          "long": -6.258309,
//          "policy_url": "https:\/\/www.ria.ie\/sites\/default\/files\/royal-irish-academy-dp-policy-cctv-v3-september-2021.pdf",
//          "Phone": "00 353 1 6762570",
//          "Email": "dataprotection@ria.ie",
//          "photos": null,
//          "permissions": {"retention":"365","storage":true,"facial_recognition":true}
//         },
//         {
//          "cctv_id": 286,
//          "cctv_road": "College Green ",
//          "lat": 53.344643,
//          "long": -6.259576,
//          "policy_url": "https:\/\/www.tcd.ie\/about\/policies\/cctv-policy.php#systems",
//          "Phone":"",
//          "Email": "dataprotection@tcd.ie",
//          "photos": null,
//          "permissions": {"retention":"120","storage":true,"facial_recognition":true}
//         },
//         {
//          "cctv_id": 289,
//          "cctv_road": "Pearse St ",
//          "lat": 53.345669,
//          "long": -6.257446,
//          "policy_url": "https:\/\/www.pearsestreetphysio.com\/privacy-notice",
//          "Phone": "+353 (0761) 104 800",
//          "Email": "info@dataprotection.ie",
//          "photos": null,
//          "permissions": {"retention":"60","storage":true,"facial_recognition":true}
//         }
//        ]
    
//     ).then(function(){
//     console.log("Data inserted")  // Success
// }).catch(function(error){
//     console.log(error)      // Failure
// });

//Routes

app.post('/cctvinformation',(req,res)=>{
    
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



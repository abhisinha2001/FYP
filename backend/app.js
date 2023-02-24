const express = require('express');
const mongoose = require('mongoose');
const {Schema} =mongoose;
const config = require('dotenv').config();
const app = express();

const PASSWORD = process.env.PASSWORD

mongoose.set('strictQuery',false);
mongoose.connect(`mongodb+srv://admin:`+PASSWORD+`@cluster0.tzrbc9a.mongodb.net/?retryWrites=true&w=majority`)
.then(()=>app.listen(3000))
.then(()=>console.log("Connected to Database"))
.catch((err)=>console.log(err));

const cctvSchema = new Schema({
        "cctv_id": Number,
        "cctc_road": String,
        "lat": Number,
        "long": Number,
        "policy_url": String,
        "Phone": String,
        "Email": String,
        "photos": [String],
        "permissions":[String]
})

const cctv = mongoose.model('cctv',cctvSchema);

// cctv.insertMany(
    
//     [
//         {
//          "cctv_id": 39,
//          "cctc_road": "Harcourt St ",
//          "lat": 53.333965,
//          "long": -6.263233,
//          "policy_url": "https:\/\/www.cctvireland.ie\/pub\/pdf\/Garda-Guidlines-on-CCTV-in-Ireland.pdf",
//          "Phone": "01 6663805",
//          "Email": null,
//          "photos": null,
//          "permissions": null
//         },
//         {
//          "cctv_id": 52,
//          "cctc_road": "Parnell St ",
//          "lat": 53.350357,
//          "long": -6.266422,
//          "policy_url": "https:\/\/www.odce.ie\/Portals\/0\/Documents\/Functions\/ODCE_Policy_on_CCTV_June_2019.pdf",
//          "Phone": null,
//          "Email": "info@odce.ie",
//          "photos": null,
//          "permissions": null
//         },
//         {
//          "cctv_id": 203,
//          "cctc_road": "Richmond St South",
//          "lat": 53.330227,
//          "long": -6.264374,
//          "policy_url": "https:\/\/www.richmond.gov.uk\/cctv",
//          "Phone": "020 8831 6001",
//          "Email": null,
//          "photos": null,
//          "permissions": null
//         },
//         {
//          "cctv_id": 204,
//          "cctc_road": "Ranelagh Rd",
//          "lat": 53.330338,
//          "long": -6.259884,
//          "policy_url": "https:\/\/www.ranelagh.bonitas.org.uk\/wp-content\/uploads\/Ranelagh-Privacy-Notice-Parents-Carers-2.pdf",
//          "Phone": "0303 123 1113",
//          "Email": null,
//          "photos": null,
//          "permissions": null
//         },
//         {
//          "cctv_id": 218,
//          "cctc_road": "Charlemont Place ",
//          "lat": 53.330822,
//          "long": -6.258903,
//          "policy_url": "https:\/\/www.claytonhotelcharlemont.com\/privacy-statement\/",
//          "Phone": "+353 (0)1 960 6700",
//          "Email": "res.charlemont@claytonhotels.com",
//          "photos": null,
//          "permissions": null
//         },
//         {
//          "cctv_id": 237,
//          "cctc_road": "Merrion Sq North  \/ Merrion Sq West",
//          "lat": 53.341104,
//          "long": -6.250811,
//          "policy_url": "https:\/\/www.nationalgallery.ie\/what-we-do\/governance\/privacy-and-data-protection\/privacy-notice",
//          "Phone": "+ 353 1 661 5133",
//          "Email": null,
//          "photos": null,
//          "permissions": null
//         },
//         {
//          "cctv_id": 276,
//          "cctc_road": "Stephen's Green ",
//          "lat": 53.337704,
//          "long": -6.262714,
//          "policy_url": "https:\/\/stephensgreen.com\/privacy-policy\/",
//          "Phone": "+353 (01) 4780888",
//          "Email": "info@stephensgreen.com",
//          "photos": null,
//          "permissions": null
//         },
//         {
//          "cctv_id": 280,
//          "cctc_road": "St. Stephen's Green",
//          "lat": 53.33989,
//          "long": -6.260723,
//          "policy_url": "https:\/\/stephensgreen.com\/privacy-policy\/",
//          "Phone": "+353 (01) 4780888",
//          "Email": "info@stephensgreen.com",
//          "photos": null,
//          "permissions": null
//         },
//         {
//          "cctv_id": 282,
//          "cctc_road": "Dawson Street",
//          "lat": 53.341327,
//          "long": -6.258309,
//          "policy_url": "https:\/\/www.ria.ie\/sites\/default\/files\/royal-irish-academy-dp-policy-cctv-v3-september-2021.pdf",
//          "Phone": "00 353 1 6762570",
//          "Email": "dataprotection@ria.ie",
//          "photos": null,
//          "permissions": null
//         },
//         {
//          "cctv_id": 286,
//          "cctc_road": "College Green ",
//          "lat": 53.344643,
//          "long": -6.259576,
//          "policy_url": "https:\/\/www.tcd.ie\/about\/policies\/cctv-policy.php#systems",
//          "Phone": null,
//          "Email": "dataprotection@tcd.ie",
//          "photos": null,
//          "permissions": null
//         },
//         {
//          "cctv_id": 289,
//          "cctc_road": "Pearse St ",
//          "lat": 53.345669,
//          "long": -6.257446,
//          "policy_url": "https:\/\/www.pearsestreetphysio.com\/privacy-notice",
//          "Phone": "+353 (0761) 104 800",
//          "Email": "info@dataprotection.ie",
//          "photos": null,
//          "permissions": null
//         },
//         {
//          "cctv_id": 306,
//          "cctc_road": "Parnell Street ",
//          "lat": 53.35097,
//          "long": -6.264767,
//          "policy_url": "https:\/\/www.odce.ie\/Portals\/0\/Documents\/Functions\/ODCE_Policy_on_CCTV_June_2019.pdf",
//          "Phone": null,
//          "Email": "info@odce.ie",
//          "photos": null,
//          "permissions": null
//         },
//         {
//          "cctv_id": 319,
//          "cctc_road": "Batchlors Walk ",
//          "lat": 53.34711,
//          "long": -6.261015,
//          "policy_url": "https:\/\/councilmeetings.dublincity.ie\/documents\/s25397\/231%20Liffey%20Street%20Part%208.pdf",
//          "Phone": null,
//          "Email": null,
//          "photos": null,
//          "permissions": null
//         },
//         {
//          "cctv_id": 385,
//          "cctc_road": "Ranelagh Rd",
//          "lat": 53.324798,
//          "long": -6.253885,
//          "policy_url": "http:\/\/www.rmds.ie\/policies\/rmds-policy-data-protection\/",
//          "Phone": "+353 (0)761 104 800&nbsp;",
//          "Email": "info@dataprotection.ie",
//          "photos": null,
//          "permissions": null
//         },
//         {
//          "cctv_id": 405,
//          "cctc_road": "Grand Canal Street Upper",
//          "lat": 53.337185,
//          "long": -6.23472,
//          "policy_url": "https:\/\/www.grandcanalhotel.ie\/en\/privacy-policy\/",
//          "Phone": "+353 1 646 1000",
//          "Email": "reservations@grandcanalhotel.com",
//          "photos": null,
//          "permissions": null
//         }
//        ]).then(function(){
//     console.log("Data inserted")  // Success
// }).catch(function(error){
//     console.log(error)      // Failure
// });

//Routes

app.post('/cctvinformation',(req,res)=>{
    
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



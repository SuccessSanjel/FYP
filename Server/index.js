//Imports from packages
const express = require('express');
const mysql2 = require('mysql2');
const sequelize = require('sequelize');
const cloudinary = require('cloudinary').v2;
//imports from other files
const signupRouter = require("./routes/signup");
const dbconfig = require("./dbconfig").dbconfig;
const sqconfig = require("./dbconfig").sqconfig;



const User = require("./models/users");
const Patient = require("./models/patients");
const Doctor = require("./models/doctors");
const Admin = require("./models/admin");
const Appointment = require("./models/appointment");
const Timing  = require("./models/timings");


const adminRouter = require('./routes/admin')
const signinRouter = require("./routes/signin");
const addUserRouter = require("./routes/add_users");
const patientRouter = require("./routes/patientRouter");
const globalRouter = require("./routes/globalRouter");


//initializations
const PORT = 5000;
const app = express();



// synchronize the database
sqconfig.sync().then(() => {
    console.log('Database synchronized');
  }).catch((err) => {
    console.error('Error syncing database:', err);
  });

//middleware
app.use(express.json());
app.use(signupRouter);
app.use(signinRouter);
app.use(addUserRouter);
app.use(adminRouter);
app.use(patientRouter);
app.use(globalRouter);




app.listen(PORT,"0.0.0.0",()=>{
    console.log(`connected at port ${PORT}`);
    dbconfig.connect((err)=>{
        if(err) throw err;
        console.log("Database connected");
    })
    sqconfig.authenticate()
  .then(() => {
    console.log('Connection has been established successfully.');
  })
  .catch((error) => {
    console.error('Unable to connect to the database:', error);
  });
})
const bcrypt = require('bcryptjs');
const { Op } = require('sequelize');
const express = require('express');
const sequilize = require('sequelize');



const jwt = require('jsonwebtoken');
const admin = require("../middlewares/admin");
const auth = require("../middlewares/auth")


const User = require("../models/users");
const doctor = require("../models/doctors");
const adminmodel = require("../models/admin");
const patient = require("../models/patients");
const timing = require("../models/timings");
const Timings = require('../models/timings');
const Appointment = require('../models/appointment');




const adminRouter = express.Router();

adminRouter.get('/admin/get-users',admin, async (req, res) => {
    try {
      const users = await User.findAll();
      res.json(users);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });

  adminRouter.post("/admin/delete-user", admin, async (req, res) => {
    try {
      const { userId } = req.body;
      const user = await User.findOne({ where: { userId } });
      if (!user) {
        return res.status(404).json({ error: "User not found" });
      }
  
      const role = user.role;
      let deletedRows = 0;
  
      if (role === "Admin") {
        deletedRows = await adminmodel.destroy({ where: { userId } });
      } else if (role === "Doctor") {

        const Doctor = await doctor.findOne({ where: { userId } });
        if (!Doctor) {
          return res.status(404).json({ error: "Doctor not found" });
        }
        const doctorId = Doctor.doctorId;
        deletedRows = await Appointment.destroy({where:{doctorId}});
        deletedRows = await timing.destroy({ where: { doctorId } });
        deletedRows = await doctor.destroy({ where: { userId } });

      } else if (role === "Patient") {
        const Patient = await patient.findOne({ where: { userId } });
        const patientId = Patient.patientId
        deletedRows = await Appointment.destroy({where:{patientId}})
        deletedRows = await patient.destroy({ where: { userId } });
      }
      await User.destroy({ where: { userId } });
      if (deletedRows) {
        
        res.json({ message: "User and associated data deleted successfully" });
      } else {
        res.status(404).json({ error: "No associated data found for user" });
      }
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });

adminRouter.post("/admin/:doctorId/add-times", async(req,res)=>{
  try{
    const Doctor = await doctor.findOne({
      where: { doctorId: req.params.doctorId },
    });
    if (!Doctor) {
      return res.status(404).send('Doctor not found');
    }

    // Create the timing record
    const Timing = await timing.create({
      doctorId: req.params.doctorId,
      day: req.body.day,
      starttime: req.body.starttime,
      endtime: req.body.endtime,
    });

    return res.status(201).json(Timing);
  }
  catch (e){
    res.status(500).json({ error: e.message });
  }
});

adminRouter.get("/admin/:id/user-detail", admin, async (req, res) => {
  try {
    const { id } = req.params;
    const user = await User.findOne({
      where: { userID: id }
    });

    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    if (user.role === "Patient") {
      const Patient = await patient.findOne({
        where: { userID: id }
      });
      return res.status(200).json(Patient);
    } else if (user.role === "Doctor") {
      const Doctor = await doctor.findOne({
        where: { userID: id }
      });
      return res.status(200).json(Doctor);
    } else {
      return res.status(400).json({ error: "Invalid user role" });
    }
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.get("/:id/timings",auth, async(req,res)=>{
  try{
      const {id } = req.params;
      const timing = await Timings.findAll({
        where:{doctorId: id}
      });
      if(!timing){
        return res.status(404).json({ error: "timing not found" });
      }
      return res.status(200).json(timing);
  }
  catch(e){
    res.status(500).json({ error: e.message });
  }
})

adminRouter.get("/get-appointments", async (req, res) => {
  try {
    const appointments = await Appointment.findAll();
    res.status(200).json(appointments);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


module.exports = adminRouter;
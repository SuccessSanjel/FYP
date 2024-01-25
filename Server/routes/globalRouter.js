const bcrypt = require('bcryptjs');
const { Op } = require('sequelize');
const express = require('express');
const sequelize = require('../dbconfig').sqconfig;

const jwt = require('jsonwebtoken');

const auth = require("../middlewares/auth")
const Admin = require("../models/admin");
const User = require("../models/users");
const Doctor = require("../models/doctors");
const Patient = require ("../models/patients");


const globalRouter = express.Router();

globalRouter.put('/api/update/:id', async (req, res) => {
    const { id } = req.params;
    const { fullName, gender, dateOfBirth, email, phone, role, userimage, specialization, experience, education, fees, height, weight, bloodGroup, allergies, medicalHistory, currentMedication,} = req.body;
  
    try {
      const user = await User.findOne({ where: { userId: id } });
      if (!user) {
        return res.status(404).json({ message: 'User not found' });
      }
  
      // check if the fields are different before updating
      
if (fullName !== undefined && fullName !== user.fullName && fullName !== '') {
    user.fullName = fullName;
  }
  if (gender !== undefined && gender !== user.gender && gender !== '') {
    user.gender = gender;
  }
  if (dateOfBirth !== undefined && dateOfBirth !== user.dateOfBirth && dateOfBirth !== '') {
    user.dateOfBirth = dateOfBirth;
  }
  if (email !== undefined && email !== user.email && email !== '') {
    user.email = email;
  }
  if (phone !== undefined && phone !== user.phone && phone !== '') {
    user.phone = phone;
  }
  if (role !== undefined && role !== user.role && role !== '') {
    user.role = role;
  }
  if (userimage !== undefined && userimage !== user.userimage && userimage !== '') {
    user.userimage = userimage;
  }
      // update the user
      await user.save();
  
      // if user is a doctor, update the doctor table too
      if (user.role === 'Doctor') {
        const doctor = await Doctor.findOne({ where: { userId: id } });
        if (!doctor) {
          return res.status(404).json({ message: 'Doctor not found' });
        }
        if (specialization !== undefined && specialization !== doctor.specialization && specialization !== '') {
          doctor.specialization = specialization;
        }
        if (experience !== undefined && experience !== doctor.experience && experience !== '') {
          doctor.experience = experience;
        }
        if (education !== undefined && education !== doctor.education && education !== '') {
          doctor.education = education;
        }
        if (fees !== undefined && fees !== doctor.fees && fees !== '') {
          doctor.fees = fees;
        }

        await doctor.save();
      }
      if (user.role === 'Patient') {
        const patient = await Patient.findOne({ where: { userId: id } });
        if (!patient) {
          return res.status(404).json({ message: 'Patient not found' });
        }
        if (height !== undefined && height !== patient.height && height !== '') {
          patient.height = height;
        }
        if (weight !== undefined && weight !== patient.weight && weight !== '') {
          patient.weight = weight;
        }
        if (bloodGroup !== undefined && bloodGroup !== patient.bloodGroup && bloodGroup !== '') {
          patient.bloodGroup = bloodGroup;
        }
        if (allergies !== undefined && allergies !== patient.allergies && allergies !== '') {
          patient.allergies = allergies;
        }
        if (medicalHistory !== undefined && medicalHistory !== patient.medicalHistory && medicalHistory !== '') {
          patient.medicalHistory = medicalHistory;
        }
        if (currentMedication !== undefined && currentMedication !== patient.currentMedication && currentMedication !== '') {
          patient.currentMedication = currentMedication;
        }
      
        await patient.save();
      }
  
      res.status(200).json({ message: 'User updated successfully' });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Server error' });
    }
  });

module.exports = globalRouter;
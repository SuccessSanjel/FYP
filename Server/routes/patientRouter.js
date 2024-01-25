const bcrypt = require('bcryptjs');
const { Op } = require('sequelize');
const express = require('express');
const sequilize = require('sequelize');



const jwt = require('jsonwebtoken');

const auth = require("../middlewares/auth")
const admin = require("../models/admin");
const user = require("../models/users");
const doctor = require("../models/doctors");
const patient = require ("../models/patients");
const Timings = require('../models/timings');
const Appointment = require("../models/appointment");


const patientRouter = express.Router();

patientRouter.get('/api/get-doctors', auth, async (req, res) => {
    try {
      const doctors = await doctor.findAll({
        include: [{
          model: user,
          where: { role: 'Doctor' },
          attributes: ['fullname', 'email','phone','dateOfBirth','gender'],
        }]
      });
      res.json(doctors);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });

  
  patientRouter.get('/api/:timeId/gettimes', async (req, res) => {
    try {
      const { timeId } = req.params;
      
      const timing = await Timings.findOne({ where: { timingID: timeId } });
      
      const doctorID = timing.doctorId;
      
      const tzOffset = 345; // set the time zone offset for Nepal
  
      const today = new Date();
      const nextWeek = new Date(today.getTime() + 7 * 24 * 60 * 60 * 1000);
      const dayIndex = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'].indexOf(timing.day);
      
      const dates = [];
      for (let i = 0; i < 7; i++) {
        const date = new Date(nextWeek.getFullYear(), nextWeek.getMonth(), nextWeek.getDate() - nextWeek.getDay() + dayIndex + (i * 7));
        date.setTime(date.getTime() + (tzOffset * 60 * 1000)); // set the time zone offset for Nepal
        dates.push(date.toISOString().slice(0, 10));
      }
      
      const appointments = await Appointment.findAll({
        where: {
          doctorId: doctorID,
          date: { [Op.in]: dates }
        }
      });
  
      const availableTimes = [];
      for (let i = 0; i < dates.length; i++) {
        const availableDate = dates[i];
        const startTime = new Date(availableDate + " " + timing.starttime);
        const endTime = new Date(availableDate + " " + timing.endtime);
        const timeSlots = getTimeSlots(startTime, endTime, 30); // get 30-minute time slots between start and end time
        const bookedTimes = appointments
          .filter(appointment => appointment.date === availableDate)
          .map(appointment => appointment.time);
        const availableTimeSlots = timeSlots.filter(timeSlot => !bookedTimes.includes(timeSlot));
        
        // check if there are any booked times for this date
        if (bookedTimes.length > 0) {
          // loop through the available time slots for this date
          for (let j = 0; j < availableTimeSlots.length; j++) {
            const availableTimeSlot = availableTimeSlots[j];
            // if the booked time is present in the available time slots, remove it
            if (bookedTimes.includes(availableTimeSlot)) {
              availableTimeSlots.splice(j, 1);
              j--; // decrement the loop counter since we just removed an element
            }
          }
        }
        
        // add the date and available time slots to the result
        availableTimes.push({ date: availableDate, times: availableTimeSlots });
      }
      
      res.json({ availableTimes });
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
  

  
  function getTimeSlots(startTime, endTime, interval) {
    const timeSlots = [];
    let currentTime = startTime;
    while (currentTime < endTime) {
      timeSlots.push(currentTime.toTimeString().slice(0, 5));
      currentTime = new Date(currentTime.getTime() + interval * 60 * 1000);
    }
    return timeSlots;
  }
  
  patientRouter.post('/api/post-appointment', auth, async (req, res) => {
    try {
      const { date, time, doctorId, patientId } = req.body;
  
      // Check if patient already has an active appointment
      const existingAppointment = await Appointment.findOne({
        where: { patientId, status: 'Booked' }
      });
      if (existingAppointment) {
        return res.status(400).json({ msg: 'You already have an active appointment' });
      }
  
      const appointment = new Appointment({
        doctorId,
        patientId,
        date,
        time,
      });
      const savedAppointment = await appointment.save();
      res.json(savedAppointment);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });

  patientRouter.get('/api/:patientId/get-appointments', async (req, res) => {
    try {
      const { patientId } = req.params;
  
      const appointments = await Appointment.findAll({
        where: {
          patientId,
          status: 'Booked', // Filter appointments with status 'Booked'
        },
      });
  
      res.status(200).json(appointments);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
  
  patientRouter.put('/api/appointments/:appointmentId/cancel', async (req, res) => {
    try {
      const { appointmentId } = req.params;
  
      // Find the appointment by ID
      const appointment = await Appointment.findByPk(appointmentId);
  
      if (!appointment) {
        return res.status(404).json({ error: 'Appointment not found' });
      }
  
      // Update the appointment's status to 'Cancelled'
      appointment.status = 'Cancelled';
      await appointment.save();
  
      res.status(200).json({ message: 'Appointment cancelled successfully' });
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
  
  
  module.exports = patientRouter;
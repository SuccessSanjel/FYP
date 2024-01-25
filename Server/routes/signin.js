const bcrypt = require('bcryptjs');
const { Op } = require('sequelize');
const express = require('express');
const User = require("../models/users");
const Patient = require("../models/patients");
const jwt = require('jsonwebtoken');

const auth = require("../middlewares/auth")

const signinRouter = express.Router();

signinRouter.post("/api/signin", async (req, res) => {
    try{
        const {email, password} = req.body;

        const user = await User.findOne({ where: { email } });
        if(!user) {
            return res.status(400).json({msg: "User With This Email Does Not Exist."});

        }
        const isMatch= await bcrypt.compare(password, user.password);
        if(!isMatch){
            return res.status(400).json({msg: "incorrect password."});

        }

        const token = jwt.sign({id: user.userId}, "passwordKey")
        res.json({ token, ...user.toJSON() })

    }
    catch (e) {
        res.status(500).json({ error: e.message });
      }
  });

  signinRouter.post("/tokenIsValid", async (req, res) => {
    try {
        const token = req.header("x-auth-token");
        if (!token) return res.json(false);
        const verified = jwt.verify(token, "passwordKey");
        if (!verified) return res.json(false);
        const user = await User.findOne({ where: { userId: verified.id } });
        if (!user) return res.json(false);
        res.json(true);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

  signinRouter.get('/', auth, async (req, res) => {
    try {
        const user = await User.findOne({ where: { userId: req.user } });
        res.json({ ...user.toJSON(), token: req.token });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});


signinRouter.get('/patients', auth, async (req, res) => {
    try {
      // Get the user from the database
      const user = await User.findOne({ where: { userId: req.user } });
  
      // If the user is a patient, get their patient data
      if (user.role === 'Patient') {
        const patient = await Patient.findOne({ where: { userId: req.user } });
        res.json(patient.toJSON());
      } else {
        res.status(401).json({ error: 'Not authorized to access this resource' });
      }
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
module.exports = signinRouter;
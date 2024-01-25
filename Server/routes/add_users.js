const bcrypt = require('bcryptjs');
const { Op } = require('sequelize');
const express = require('express');


const User = require("../models/users");
const admin = require('../middlewares/admin');
const doctor = require("../models/doctors");
const patient = require("../models/patients");
const adminmodel = require("../models/admin");
const cloudinary = require('cloudinary').v2;
const multer = require('multer');
const upload = multer({ dest: 'uploads/' });

cloudinary.config({
  cloud_name: "dzq8p4sez",
  api_key: "716351627816454",
  api_secret: "nC6DY_O2rNFAKPBkJcH-WBoAx-s"
});


const addUserRouter = express.Router();

addUserRouter.post("/admin/adduser",upload.single('userimage'), admin, async (req, res) => {
  try {
    const { fullName, email, password, phone,role,dateOfBirth,gender } = req.body;
    const userimage = req.file;
    // Check if user with the same email or phone already exists
    const existingUser = await User.findOne({ where: { [Op.or]: [{ email }, { phone }] } });
    if (existingUser) {
      if (existingUser.email === email) {
        return res.status(400).json({ msg: "User with same email already exists!" });
      } else {
        return res.status(400).json({ msg: "User with same phone number already exists!" });
      }
    }

    let user = new User({
      fullName,
      email,
      password,
      phone,
      role,
      dateOfBirth,
      gender,
    });
    // If a userimage file is provided, upload it to Cloudinary
    if (userimage) {
      const cloudinaryUploadResult = await cloudinary.uploader.upload(userimage.path);

      // Save the unique image ID from Cloudinary in the user model
      user.userimage = cloudinaryUploadResult.public_id;
    }
    user = await user.save();
    res.json(user);
    
    
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

addUserRouter.post("/adduser", async (req, res) => {
  try {
    const { fullName, email, password, phone,role,dateOfBirth,gender } = req.body;

    // Check if user with the same email or phone already exists
    const existingUser = await User.findOne({ where: { [Op.or]: [{ email }, { phone }] } });
    if (existingUser) {
      if (existingUser.email === email) {
        return res.status(400).json("User with same email already exists!");
      } else {
        return res.status(400).json("User with same phone number already exists!" );
      }
    }

    let user = new User({
      fullName,
      email,
      password,
      phone,
      role,
      dateOfBirth,
      gender,
    });
    res.json(user);
    user = await user.save();
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});



module.exports = addUserRouter;
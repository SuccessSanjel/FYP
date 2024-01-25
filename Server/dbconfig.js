const mysql2 = require('mysql2');
const sequilize = require('sequelize');

const dbconfig = mysql2.createConnection({
    host: "localhost",
    database: "hamro_doctor",
    user: "root",
    password: "test123",
})

const sqconfig = new sequilize({
    dialect: 'mysql',
    database: 'hamro_doctor',
    host: 'localhost',
    username: 'root',
    password: 'test123',
    sync: true,
})



module.exports = {
    dbconfig: dbconfig,
    sqconfig: sqconfig
  };
const { Model, DataTypes, STRING } = require('sequelize');
const sequelize = require('../dbconfig').sqconfig;
const User = require('./users');
const Patient = require('./patients');
const Doctor = require('./doctors');

class Appointment extends Model {}

Appointment.init(
    {
        appointmentId:{
            type: DataTypes.STRING,
            primaryKey: true,
        },
        doctorId:{
            type: DataTypes.STRING,
            allowNull:false,
        },
        patientId:{
            type: DataTypes.STRING,
            allowNull:false,
        },
        date:{
            type: DataTypes.STRING,
            allowNull:false,
        },
        time:{
            type: DataTypes.STRING,
            allowNull:false,
        },
        status:{
            type:DataTypes.STRING,
            allowNull:false,
            defaultValue: 'Booked',
            validate: {
              notEmpty: true,
              isIn: [['Booked', 'Finished', 'Cancelled']],
            },
        },
        paymenttype:{
            type:DataTypes.STRING,
            allowNull:false,
            defaultValue: 'Cash',
            validate: {
              notEmpty: true,
              isIn: [['Cash', 'Online']],
            },
        },

    },
    {
        sequelize,
        timestamps: false,
        modelName: 'appointments',
        hooks: {
            beforeCreate: async (appointment, options) => {
                const max = await sequelize.query("SELECT COALESCE(MAX(CAST(SUBSTR(appointmentId, 3) AS UNSIGNED)), 0) AS maxappointmentid FROM appointments;", { type: sequelize.QueryTypes.SELECT });
                const newId = `AP${String(parseInt(max[0].maxappointmentid) + 1).padStart(4, '0')}`;
                appointment.appointmentId = newId;
              },
              
        },
      }
);

Appointment.belongsTo(Doctor,{foreignKey:'doctorId'
});

Appointment.belongsTo(Patient,{foreignKey:'patientId'
});

module.exports = Appointment;
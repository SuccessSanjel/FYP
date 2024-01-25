const { Model, DataTypes } = require('sequelize');
const sequelize = require('../dbconfig').sqconfig;
const User = require('./users');
const Patient = require('./patients');
const Doctor = require("./doctors");

class Timings extends Model{}

Timings.init(
    {
        timingId:{
            type:DataTypes.STRING,
            primaryKey: true,
        },
        doctorId: {
            type: DataTypes.STRING,
            allowNull: false,
            references: {
              model: 'doctors',
              key: 'doctorId'
            }
          },
        day:{
            type:DataTypes.ENUM('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'),
            allowNull: false,
        },
        starttime:{
            type:DataTypes.STRING,
            allowNull:false
        },
        endtime:{
            type:DataTypes.STRING,
            allowNull:false
        }
        
    },
    {
        sequelize,
        timestamps: false,
        modelName: 'timings',
        hooks: {
          beforeCreate: async (timings, options) => {
            // Generate doctor ID
            const max = await sequelize.query("SELECT COALESCE(MAX(CAST(SUBSTR(timingID, 3) AS UNSIGNED)), 0) AS maxUserId FROM timings;", { type: sequelize.QueryTypes.SELECT });
            const newId = `TT${String(parseInt(max[0].maxUserId) + 1).padStart(4, '0')}`;
            timings.timingId = newId;
            
          },
        },
    }
);

Timings.belongsTo(Doctor, { foreignKey: 'doctorId' });

module.exports= Timings;
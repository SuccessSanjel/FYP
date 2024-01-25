const { Model, DataTypes } = require('sequelize');
const sequelize = require('../dbconfig').sqconfig;
const User = require('./users');
const Patient = require('./patients');

class Doctor extends Model {}

Doctor.init(
  {
    doctorId: {
      type: DataTypes.STRING,
      primaryKey: true,
    },
    specialization: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    experience: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    education: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    fees: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: 0.0,
    },
    rating: {
      type: DataTypes.STRING,
      allowNull: true,
      defaultValue: 0.0,
    },

  

    // add any additional doctor data here
  },
  {
    sequelize,
    modelName: 'doctors',
    timestamps:false,
    hooks: {
      beforeCreate: async (doctor, options) => {
        // Generate doctor ID
        const max = await sequelize.query("SELECT COALESCE(MAX(CAST(SUBSTR(doctorId, 3) AS UNSIGNED)), 0) AS maxUserId FROM doctors;", { type: sequelize.QueryTypes.SELECT });
        const newId = `DT${String(parseInt(max[0].maxUserId) + 1).padStart(4, '0')}`;
        doctor.doctorId = newId;
        
      },
    },
  }
);

Doctor.belongsTo(User, { foreignKey: 'userId', });


User.afterCreate(async (user, options) => {
  if (user.role === 'Doctor') {
    await Doctor.create({
      userId: user.userId,
      userimage: user.userimage,
      // add any additional doctor data here
    });
  }
});

module.exports = Doctor;
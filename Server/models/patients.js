const { Model, DataTypes } = require('sequelize');
const sequelize = require('../dbconfig').sqconfig;
const User = require('./users');

class Patient extends Model {}

Patient.init(
  {
    patientId: {
      type: DataTypes.STRING,
      primaryKey: true,
    },
    height: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    weight: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    bloodGroup: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    allergies: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    medicalHistory: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    currentMedication: {
      type: DataTypes.STRING,
      allowNull: true,
    },

    // add any additional patient data here
  },
  {
    sequelize,
    timestamps: false,
    modelName: 'patients',
    hooks: {
      beforeCreate: async (patient, options) => {
        // Generate patient ID
        // const count = await Patient.count();
        // patient.patientId = `PT${String(count + 1).padStart(4, '0')}`;
        
        const max = await sequelize.query("SELECT COALESCE(MAX(CAST(SUBSTR(patientId, 3) AS UNSIGNED)), 0) AS maxUserId FROM patients;", { type: sequelize.QueryTypes.SELECT });
        const newId = `PT${String(parseInt(max[0].maxUserId) + 1).padStart(4, '0')}`;
        patient.patientId = newId;
        
         
      },
    },
  }
);


Patient.belongsTo(User, { foreignKey: 'userId' });


User.afterCreate(async (user, options) => {
  if (user.role === 'Patient') {
    await Patient.create({
      userId: user.userId,
      userimage: user.userimage,
    });
  }
});

module.exports = Patient;
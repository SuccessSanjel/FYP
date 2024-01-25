const { Model, DataTypes } = require('sequelize');

const bcrypt = require('bcryptjs');
const sequelize = require("../dbconfig").sqconfig;

class User extends Model {}

User.init(
  {
    userId: {
      type: DataTypes.STRING,
      primaryKey: true,
    },
    fullName: {
      type: DataTypes.STRING,
      allowNull: false,
      validate: {
        notEmpty: true,
      },
    },

    gender: {
      type: DataTypes.ENUM('Male', 'Female', 'Other'),
      allowNull: false,
    },
    dateOfBirth: {
      type: DataTypes.DATEONLY,
      allowNull: false,
    },

    password: {
        type: DataTypes.STRING,
        allowNull: false,
        validate: {
          notEmpty: true,
          isPasswordValid(value) {
            const regex = /^(?=.*\d)(?=.*[a-zA-Z]).{7,}$/;
            if (!regex.test(value)) {
              throw new Error('Password must be at least 7 characters long and contain at least one letter and one number');
            }
          }
        },
      },
      email: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: {
          args: true,
          msg: "Email address already in use!",
        },
        validate: {
          isEmail: {
            args: true,
            msg: "Invalid email address!",
          },
          contains: {
            args: ["@"],
            msg: "Email address must contain @ symbol!",
          },
        },
      },
      phone: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true,
        validate: {
          isNumeric: true,
          isLength: {
            args: [10],
            msg: "Phone Number must be in 10 length"
          },
          containsOnlyDigits: function(value) {
            if (!/^\d+$/.test(value)) {
              throw new Error('Phone Number must contain only digits');
            }
          }
        }
      },

    role: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: 'Patient',
      validate: {
        notEmpty: true,
        isIn: [['Patient', 'Doctor', 'Admin']],
      },
    },

    userimage:{
      type: DataTypes.STRING,
      allowNull: true,
    },

  },
  {
    sequelize,
    timestamps: false,
    modelName: 'users',
    hooks: {
      beforeCreate: async (user, options) => {
        // Generate user ID
        // const count = await User.count();
        // user.userId = `US${String(count + 1).padStart(4, '0')}`;
        const max = await sequelize.query("SELECT COALESCE(MAX(CAST(SUBSTR(userId, 3) AS UNSIGNED)), 0) AS maxUserId FROM users;", { type: sequelize.QueryTypes.SELECT });
        const newId = `US${String(parseInt(max[0].maxUserId) + 1).padStart(4, '0')}`;
        user.userId = newId;
        // Hash password
        const hashedPassword = await bcrypt.hash(user.password, 8);
        user.password = hashedPassword;
      },
    },
  }
);

module.exports = User;
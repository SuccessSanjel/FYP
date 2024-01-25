const { Model, DataTypes } = require('sequelize');
const sequelize = require('../dbconfig').sqconfig;
const User = require('./users');


class Admin extends Model{}
Admin.init(
    {
        adminId:{
            type:DataTypes.STRING,
            primaryKey: true,
        },
    },
    {
        sequelize,
        timestamps: false,
        modelName: 'admins',
        hooks: {
          beforeCreate: async (admin, options) => {
            // Generate doctor ID
            const max = await sequelize.query("SELECT COALESCE(MAX(CAST(SUBSTR(adminId, 3) AS UNSIGNED)), 0) AS maxUserId FROM admins;", { type: sequelize.QueryTypes.SELECT });
            const newId = `AD${String(parseInt(max[0].maxUserId) + 1).padStart(4, '0')}`;
            admin.adminId = newId;
          },
        },
      }
);
Admin.belongsTo(User,{foreignKey:'userId'});

User.afterCreate(async(user, options)=>{
    if(user.role==='Admin'){
        await Admin.create({
            userId:user.userId,
        })
    }
})
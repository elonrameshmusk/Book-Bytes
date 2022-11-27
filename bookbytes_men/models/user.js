import mongoose from 'mongoose';
import shelfSchema from './shelf.js';
import bcrypt from 'bcrypt';
const userSchema = mongoose.Schema({
    email:{
        type: String,
        require: true,
        unique: true
    },
    password:{
        type: String,
        require: true
    },
    shelves: [
        shelfSchema
    ]
});
userSchema.pre('save', function(next){
    var user = this;
    if(this.isModified('password')||this.isNew){
        bcrypt.genSalt(10, function(err, salt){
            if(err){
                return next(err);
            }
            bcrypt.hash(user.password, salt, function(err, hash){
                if(err){
                    return next(err);
                }
                user.password = hash;
                next();
            })
        })
    }
    else{
        return next();
    }
});
userSchema.methods.comparePassword = function(passw, cb){
    bcrypt.compare(passw, this.password, function(err, isMatch){
        if(err){
            return cb(err);
        }
        cb(null, isMatch);
    })
}
const User = mongoose.model('User', userSchema);
export default User;
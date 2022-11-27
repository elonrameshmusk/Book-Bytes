import passport from 'passport';
import User from '../models/user.js';
import dbConfig from './dbconfig.js';
var JwtStrategy = passport.Strategy;
var ExtractJwt = passport.ExtractJwt;
var func = function(passport){
    var opts = {};
    opts.secretOrKey = dbConfig.secret;
    opts.jwtFromRequest = ExtractJwt.fromAuthHeaderWithScheme('jwt');
    passport.use(new JwtStrategy(opts, function(jwt_payload, done){
        User.find({
            id: jwt_payload.id
        }, function(err ,user){
            if(err){
                return done(err, false);
            }
            if(user){
                return done(null, user);
            }
            else{
                return done(null, false);
            }
        })
    }))
}
export default passport;


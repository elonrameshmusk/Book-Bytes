import mongoose from 'mongoose';
import dbConfig from './dbconfig.js';
const connectDB = async() => {
    try{
        const conn = await mongoose.connect(dbConfig.database, {
            useNewUrlParser: true,
            useUnifiedTopology:true,
        });
        console.log(`MongoDB connected: ${conn.connection.host}`);
    }
    catch(err){
        console.log(err);
        process.exit(1);
    }
}
export default connectDB;
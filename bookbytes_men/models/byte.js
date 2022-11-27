import mongoose from 'mongoose';
const byteSchema = mongoose.Schema({
    heading: String,
    lines: String,
    learning: String
});
export default byteSchema;
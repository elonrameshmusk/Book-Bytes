import mongoose from 'mongoose';
import byteSchema from './byte.js';
const folderSchema = mongoose.Schema({
    name: {
        type: String,
        require: true
    },
    bytes: [
        byteSchema
    ]
});
export default folderSchema;
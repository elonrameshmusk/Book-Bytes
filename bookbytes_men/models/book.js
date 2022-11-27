import mongoose from 'mongoose';
import folderSchema from './folder.js';
const bookSchema = mongoose.Schema({
    id: {
        type: String,
        require: true
    },
    folders: [
        folderSchema
    ]
});
export default bookSchema;
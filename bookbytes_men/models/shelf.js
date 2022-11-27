import mongoose from 'mongoose';
import bookSchema from './book.js';
const shelfSchema = mongoose.Schema({
    name: {
        type: String,
    },
    books: [
        bookSchema
    ]
});
export default shelfSchema;
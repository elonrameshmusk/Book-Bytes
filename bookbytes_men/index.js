import express from 'express';
import morgan from 'morgan';
import cors from 'cors';
import bodyParser from 'body-parser';
import connectDB from './config/db.js';
import routes from './routes/index.js';
import func from './config/passport.js';

connectDB();
const app = express();
if(process.env.NODE_ENV === 'development'){
    app.use(morgan('dev'));
}
app.use(cors());
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());
app.use(routes);
app.use(func.initialize());

const PORT = process.env.PORT || 3000;
app.listen(PORT, console.log('server up and runnin\' at '+PORT));



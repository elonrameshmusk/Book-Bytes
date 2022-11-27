import express from 'express';
import functions from '../methods/actions.js';
const router = express.Router();
router.get('/', (req, res)=>{
    res.send('can get /');
})
router.post('/adduser', functions.addNewUser);
router.post('/authenticate', functions.authenticate);
router.get('/getinfo', functions.getinfo);
router.post('/addshelf', functions.addShelf);
router.get('/getshelves', functions.getShelves);
router.post('/addbook', functions.addBook);
router.get('/getbooks', functions.getBooks);
router.post('/addfolder', functions.addFolder);
router.get('/getfolders', functions.getFolders);
router.post('/addbyte', functions.addByte);
router.get('/getbytes', functions.getBytes);

export default router;
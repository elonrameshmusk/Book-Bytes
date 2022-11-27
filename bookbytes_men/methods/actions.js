import User from "../models/user.js";
import jwt from 'jwt-simple';
import dbConfig from '../config/dbconfig.js';

var functions = {
   
    addNewUser: function(req, res){
        if((!req.body.email)||(!req.body.password)){
            res.json({success: false, msg: 'Enter all fields'});
        }
        else{
            var newUser = User({
                email: req.body.email,
                password: req.body.password,
            });
            newUser.save(function(err, result){
                if(err){
                    res.json({success:false, msg:'User not saved'});
                }
                else{
                    var token = jwt.encode(result, dbConfig.secret);
                    res.json({success: true, token: token});
                }
            });
        }
    },
    authenticate: function(req, res){
        User.findOne({
            email: req.body.email
        }, function(err, user){
            if(err) return;
            if(!user){
                res.status(403).json({success: false, msg: 'user not there'});
            }
            else{
                user.comparePassword(req.body.password, function(err, isMatch){
                    if(isMatch && !err){
                        var token = jwt.encode(user, dbConfig.secret);
                        res.json({success: true, token: token});
                    }
                    else{
                        return res.status(403).json({success: false, msg: 'auth failed due to wrogn password'})
                    }
                })
            }
        })
    },
    getinfo: function(req,res){
        if(req.headers.authorization && req.headers.authorization.split(' ')[0]==='Bearer'){
            var token = req.headers.authorization.split(' ')[1];
            var decodertoken = jwt.decode(token, dbConfig.secret);
            return res.json({success: true, msg: 'hello '+decodertoken.email})
        }
        else{
            return res.json({success: false, msg: 'No headers'});
        }
    },
    addShelf: async function(req, res){
        var authorization = req.headers.authorization;
        var token = authorization.split(' ')[1];
        var decodertoken = await jwt.decode(token, dbConfig.secret);
        User.findOne({
            email: decodertoken.email
        }).then((user)=>{
            var shelfName = req.query.shelf;
        user.shelves.push({name: shelfName, books: []});
        user.save(function(err){
            if(err){
                res.json({success:false, msg:'not saved'});
            }
            else{
                res.json({success: true, msg: 'saved'}); 
            }
        });
        }).catch((err)=>{return});
        
    },
    getShelves: function(req, res){
        var token = req.headers.authorization.split(' ')[1];
        var decodertoken = jwt.decode(token, dbConfig.secret);
        User.findOne({email: decodertoken.email}, function(err, user){
        if(err){
            res.json({success:false});
        }
        else{
            var shelves = [];
        for(var i=0; i<user.shelves.length; i++){
            shelves.push(user.shelves[i].name);
        }
        res.json({success: true, shelves: shelves});
        }
    }).clone();  
    }, 
    addBook: async function(req, res){
        var authorization = req.headers.authorization;
        var token = authorization.split(' ')[1];
        var decodertoken = await jwt.decode(token, dbConfig.secret);
        User.findOne({
            email: decodertoken.email
        }).then((user)=>{
            var shelfName = req.query.shelf;
            var bookId = req.query.id;
            for(var i=0; i<user.shelves.length; i++){
                if(user.shelves[i].name===shelfName){
                    user.shelves[i].books.push({id: bookId, folders: []});
                    user.save(function(err){
                        if(err){
                            console.log(err);
                            res.json({success:false, msg:'book not saved'});
                        }
                        else{
                            res.json({success: true, msg: 'book saved'}); 
                        }
                    });
                    break;
                }
        }
        
        }).catch((err)=>{return});
        
        
    },
    getBooks: function(req, res){
        var done=0;
        var shelfName = req.query.shelf;
        var token = req.headers.authorization.split(' ')[1];
        var decodertoken = jwt.decode(token, dbConfig.secret);
        User.findOne({email: decodertoken.email}, function(err, user){
        if(err){
            res.json({success:false});
        }
        else{
            var books = [];
        for(var i=0; i<user.shelves.length; i++){
            if(user.shelves[i].name === shelfName){
                for(var j=0; j<user.shelves[i].books.length; j++){
                    books.push(user.shelves[i].books[j].id);
                }
                res.send({success: true, books: books});
                done = 1;
                break;
            }
            if(done==1) break;
        }
    }}).clone(); 
    },
    addFolder: async function(req, res){
        var token = req.headers.authorization.split(' ')[1];
            var decodertoken = jwt.decode(token, dbConfig.secret);
            User.findOne({email: decodertoken.email}, function(err, user){
            if(err){
                res.json({success:false});
            }
            else{
                var done=0;
                var shelfName = req.query.shelf;
                var bookId = req.query.id;
                var folderName = req.query.folder;
                for(var i=0; i<user.shelves.length; i++){
                    if(user.shelves[i].name === shelfName){
                        for(var j=0; j<user.shelves[i].books.length; j++){
                            if(user.shelves[i].books[j].id===bookId){
                                user.shelves[i].books[j].folders.push({name: folderName, bytes: []});
                                user.save(function(err){
                                    if(err){
                                        res.json({success:false, msg:'not saved'});
                                    }
                                    else{
                                        res.json({success: true, msg: 'saved'}); 
                                    }
                                });
                                done = 1;
                                break;
                            }
                        }
                    }
                    if(done==1) break;
                } 
            }
        }).clone(); 
        
    },
    getFolders: async function(req, res){
            var token = req.headers.authorization.split(' ')[1];
            var decodertoken = jwt.decode(token, dbConfig.secret);
            User.findOne({email: decodertoken.email}, function(err, user){
            if(err){
                res.json({success:false});
            }
            else{
                var done=0;
        var shelfName = req.query.shelf;
        var bookId = req.query.id;
        var folders=[];
        for(var i=0; i<user.shelves.length; i++){
            if(user.shelves[i].name===shelfName){
                for(var j=0; j<user.shelves[i].books.length; j++){
                    if(user.shelves[i].books[j].id === bookId){
                        for(var k=0; k<user.shelves[i].books[j].folders.length; k++){
                            folders.push(user.shelves[i].books[j].folders[k].name);
                        }
                        res.json({success: true, folders: folders});
                        done = 1;
                        break;
                    }
                }
            }
            if(done==1) break;
        }
            }
        }).clone();  
        
    },
    addByte: async function(req, res){
        var token = req.headers.authorization.split(' ')[1];
        var decodertoken = jwt.decode(token, dbConfig.secret);
        User.findOne({email: decodertoken.email}, function(err, user){
            if(err){
                res.json({success:false});
            }
            else{
                var done=0;
        var shelfName = req.query.shelf;
        var bookId = req.query.id;
        var folderName = req.query.folder;
        var heading = req.body.heading;
        var lines = req.body.lines;
        var learning = req.body.learning;
        for(var i=0; i<user.shelves.length; i++){
            if(user.shelves[i].name === shelfName){
                for(var j=0; j<user.shelves[i].books.length; j++){
                    if(user.shelves[i].books[j].id===bookId){
                        for(var k=0; k<user.shelves[i].books[j].folders.length; k++){
                            if(user.shelves[i].books[j].folders[k].name===folderName){
                                user.shelves[i].books[j].folders[k].bytes.push({ 
                                    heading: heading,
                                    lines: lines,
                                    learning: learning
                                });
                                user.save(function(err){
                                    if(err){
                                        res.json({success:false, msg:'not saved'});
                                    }
                                    else{
                                        res.json({success: true, msg: 'saved'}); 
                                    }
                                });
                                done = 1; 
                                break;
                            }
                        }
                    }
                    if(done==1) break;
                }
            }
            if(done==1) break;
        }
            }
        }).clone(); 
        
    },
    getBytes: async function(req, res){
        var token = req.headers.authorization.split(' ')[1];
        var decodertoken = jwt.decode(token, dbConfig.secret);
        User.findOne({email: decodertoken.email}, function(err, user){
        if(err){
            res.json({success:false});
        }else{
        var done = 0;
        var shelfName = req.query.shelf;
        var bookId = req.query.id;
        var folderName = req.query.folder;
        var bytes = [];
        for(var i=0; i<user.shelves.length; i++){
            if(user.shelves[i].name===shelfName){
                for(var j=0; j<user.shelves[i].books.length; j++){
                    if(user.shelves[i].books[j].id===bookId){
                        for(var k=0; k<user.shelves[i].books[j].folders.length; k++){
                            if(user.shelves[i].books[j].folders[k].name===folderName){
                                for(var l=0; l<user.shelves[i].books[j].folders[k].bytes.length; l++){
                                    bytes.push(user.shelves[i].books[j].folders[k].bytes[l]);
                                }
                                res.json({success:true, bytes: bytes});
                                done=1;
                                break;
                            }
                        }
                    }
                    if(done==1) break;
                }
            }
            if(done==1) break;
        }
    }
            
}).clone();
}   

}
export default functions;
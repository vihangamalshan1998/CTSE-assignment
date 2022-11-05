const router = require("express").Router();
let User = require('../models/User.js');

//add a new Flower
router.route("/addUser").post((req, res) => {
    const {userName,firstName,lastName,password,userType} = req.body;

    const newUser = new User({
        userName,
        firstName,
        lastName,
        password,
        userType
    });
    newUser.save().then(() =>{
        res.json("User Added Successfully")
    }).catch((err)=>{
        console.log(err);
    })
})
//login
router.route("/login").post((req,res)=>{
    const {userName,password} = req.body;
    User.find({userName:userName,password:password}).then((user =>{
        res.json(user);
    })).catch((err)=>{
        console.log(err);
    })
});
//get one user
router.route("/getUser/:userName").get((req,res)=>{
    let userName = req.params.userName;
    User.findOne({userName:userName}).then((user =>{
        res.json(user);
        
    })).catch((err)=>{
        console.log(err);
    })
});
//get all users
router.route("/").get((req,res)=>{
    User.find().then((users =>{
        res.json(users)
    })).catch((err)=>{
        console.log(err)
    })
})

//update User
router.route("/update/:userName").put(async (req, res)=>{
    let userName = req.params.userName;
    const {firstName, lastName, password} = req.body;

    const updateUser = {
        userName,
        firstName,
        lastName,
        password
    }
    let id = 0;
    await User.find({userName:userName}).then((user)=>{
        id = user[0].id;
    }).catch((err)=>{
        console.log(err);
    })
    if(id){
        const update = await User.findByIdAndUpdate(id, updateUser).then(()=> {
            res.status(200).send({status: "User updated"})
        }).catch((err)=>{
            console.log(err);
            res.status(500).send({status: "Error with updating data"});
    
        })
    }

})

//delete User
router.route("/delete/:userName").delete(async (req, res)=>{
    let userName= req.params.userName;
    let id = 0;
    await User.find({userName:userName}).then((user)=>{
        id = user[0].id;
        console.log(id)
    }).catch((err)=>{
        console.log(err);
    })
    if(id){
        const update = await User.findByIdAndDelete(id).then(()=> {
            res.status(200).send({status: "User Deleted!"})
        }).catch((err)=>{
            console.log(err);
            res.status(500).send({status: "Error with deleting user"});
    
        })
    }
})




module.exports = router;
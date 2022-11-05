const router = require("express").Router();
let Flower= require("../models/Flowers");


//add a new Flower
router.route("/addFlower").post((req, res) => {
    const flowerName = req.body.flowerName;
    const commonNames = req.body.commonNames;
    const description = req.body.description;

    const newFlower = new Flower({
        flowerName,
        commonNames,
        description
    })
    newFlower.save().then(() =>{
        res.json("Flower Added Successfully")
    }).catch((err)=>{
        console.log(err);
    })
})

//get all Flowers
router.route("/allFlowers").get((req,res)=>{
    Flower.find().then((flowers =>{
        res.json(flowers)
    })).catch((err)=>{
        console.log(err)
    })
})



//delete Flower
router.route("/delete/:id").delete(async (req, res)=>{
    let flowerId= req.params.id;
    await Flower.findByIdAndDelete(flowerId).then(()=>{
        res.status(200).send({status: "Flower Deleted Successfully"});
    }).catch((err)=>{
        console.log(err.message);
        res.status(500).send({status: "Error with delete ", flowererror: err.message});
    })
})

//get flower by name
router.route("/get/:flowerName").get(async (req, res)=>{
    let flowerName = req.params.flowerName;
    Flower.find({flowerName : flowerName}).then((flowers)=>{
        res.json(flowers)
    }).catch((err)=>{
        console.log(err);
    })
})

//delete flower by flower name
router.route("/deleteName/:flowerName").delete(async (req, res)=>{
    let flowerName= req.params.flowerName;
    await Flower.find({flowerName : flowerName}).then((flowers)=>{
        Flower.findByIdAndDelete(flowers[0]._id).then((flowers)=>{
                res.status(200).send({status: "Flower Deleted Successfully"});
            }).catch((err)=>{
                console.log(err.message);
                res.status(500).send({status: "Error with delete ", flowererror: err.message});
            })
    }).catch((err)=>{
        console.log(err);
    })
})

//update flower by flower name
router.route("/updateFlower/:flowerName").put(async (req, res)=>{
    let flowerName= req.params.flowerName;
    const {commonNames, description} = req.body;

    const updateFlower = {
        commonNames,
        description
    }
    await Flower.find({flowerName : flowerName}).then((flowers)=> {
        const update = Flower.findByIdAndUpdate(flowers[0]._id, updateFlower).then(() => {
            res.status(200).send({status: "FLower updated"})
        }).catch((err) => {
            console.log(err);
            res.status(500).send({status: "Error with updating data"});

        })
    })


})


module.exports = router;
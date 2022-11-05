const router = require("express").Router();
const disease = require("../models/Disease");


//add a new disease
router.route("/api/v1/add-disease").post((req, res) => {
    const diseaseName = req.body.diseaseName;
    const antidote = req.body.antidote;
    const description = req.body.description;

    const newDisease = new disease({
        diseaseName,
        antidote,
        description
    })
    newDisease.save().then(() => {
        res.json("Diseases Added Successfully")
    }).catch((err) => {
        console.log(err);
    })
})

//get all Diseases
router.route("/api/v1/findAllDiseases").get((req, res) => {
    disease.find().then((disease => {
        res.json(disease)
    })).catch((err) => {
        console.log(err)
    })
})

//delete Disease by id
router.route("/api/v1/delete/:id").delete(async (req, res) => {
    let diseaseId = req.params.id;
    await disease.findByIdAndDelete(diseaseId).then(() => {
        res.status(200).send({status: "Disease Deleted Successfully"});
    }).catch((err) => {
        console.log(err.message);
        res.status(500).send({status: "Error with delete ", diseaseError: err.message});
    })
})

//get flower by id
router.route("/api/v1/get/disease/:id").get(async (req, res) => {
    let id = req.params.id;
    disease.find({_id: id}).then((disease) => {
        res.json(disease)
    }).catch((err) => {
        console.log(err);
    })
})

//update disease by disease id
router.route("/api/v1/update-disease/:id").put(async (req, res) => {
    let id = req.params.id;
    const {diseaseName, antidote, description} = req.body;

    const updateDisease = {
        diseaseName,
        antidote,
        description
    }
    await disease.find({_id : id}).then((diseases) => {
        const update = disease.findByIdAndUpdate(diseases[0]._id, updateDisease).then(() => {
            res.status(200).send({status: "Disease updated"})
        }).catch((err) => {
            console.log(err);
            res.status(500).send({status: "Error with updating disease"});

        })
    })


})


module.exports = router;

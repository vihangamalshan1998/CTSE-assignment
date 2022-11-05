const router = require('express').Router()
const Fertilizer = require('../models/fertilizer')
const path = require('path')
const multer = require('multer')
const fs = require('fs')

//Multer for file storage
var storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/fertilizer')
  },
  filename: function (req, file, cb) {
    console.log(file.originalname)
    let today = new Date()
    let dd = String(today.getDate()).padStart(2, '0')
    let mm = String(today.getMonth() + 1).padStart(2, '0')
    let yyyy = today.getFullYear()
    const fileExt = path.extname(file.originalname)
    const fileText =
      Date.now() +
      '-' +
      file.originalname +
      '-' +
      dd +
      '-' +
      mm +
      '-' +
      yyyy +
      fileExt
    cb(null, fileText)
  },
})

var upload = multer({
  storage: storage,
})

//add new Fertilizer
router.route('/add').post((req, res) => {
  const { fertilizer_Name, fertilizer_code, weight, description } = req.body
  const newFertilizer = new Fertilizer({
    fertilizer_Name,
    fertilizer_code,
    weight,
    description,
  })
  newFertilizer
    .save()
    .then(() => {
      console.log('New Fertilizer Added')
      res.json('New Fertilizer Added')
    })
    .catch((err) => {
      console.log(err)
    })
})

//get all Fertilizer details
router.route('/GetAllFertilizer').get((req, res) => {
  Fertilizer.find({})
    .then((events) => {
      res.json(events)
    })
    .catch((err) => {
      console.log(err)
    })
})

//get Fertilizer details using Fertilizer id
router.route('/GetFertilizer/:id').get((req, res) => {
  let fertilizerID = req.params.id
  Fertilizer.findById(fertilizerID)
    .then((subject) => {
      res.json(subject)
    })
    .catch((err) => {
      console.log(err)
    })
})

//update only Fertilizer details without picture using Fertilizer id
router.route('/UpdateData/:id').put(async (req, res) => {
  let fertilizerID = req.params.id
  const { fertilizer_Name, fertilizer_code, weight, description } = req.body
  const updatefertilizer = {
    fertilizer_Name,
    fertilizer_code,
    weight,
    description,
  }
  const update = await Fertilizer.findByIdAndUpdate(
    fertilizerID,
    updatefertilizer,
  )
    .then(() => {
      res.status(200).send({ status: 'Fertilizer Updated' })
    })
    .catch((err) => {
      console.log(err)
      res.status(500).send({ status: 'Error with Updating data' })
    })
})

//update Fertilizer with new image
router
  .route('/updateWithImage/:id')
  .put(upload.single('picture'), (req, res) => {
    let fertilizerID = req.params.id
    const { fertilizer_Name, fertilizer_code, weight, description } = req.body
    const picture = req.file.filename
    const updatefertilizer = {
      fertilizer_Name,
      fertilizer_code,
      weight,
      picture,
      description,
    }
    const update = Fertilizer.findByIdAndUpdate(fertilizerID, updatefertilizer)
      .then(() => {
        res.status(200).send({ status: 'Fertilizer Updated' })
        // fs.unlink(
        //   'C:/Users/JontyRulz/Desktop/SPM-FINAL_BACKEND/uploads/teachers/' +
        //     picturename,
        //   function (err) {
        //     if (err) throw err
        //     console.log('File deleted!')
        //   },
        // )
      })
      .catch((err) => {
        console.log(err)
        res.status(500).send({ status: 'Error with Updating data' })
      })
  })

//delete the Fertilizer with file
router.route('/Delete/:id').delete(async (req, res) => {
  let fertilizerID = req.params.id
  await Fertilizer.findByIdAndDelete(fertilizerID)
    .then(() => {
      //   fs.unlink(
      //     'C:/Users/JontyRulz/Desktop/SPM-FINAL_BACKEND/uploads/teachers/' +
      //       filename,
      //     function (err) {
      //       if (err) throw err
      //       console.log('File deleted!')
      //     },
      //   )
      res.status(200).send({ status: 'Fertilizer Deleted' })
    })
    .catch((err) => {
      console.log(err)
      res.status(500).send({ status: 'Error with deleting data' })
    })
})
module.exports = router

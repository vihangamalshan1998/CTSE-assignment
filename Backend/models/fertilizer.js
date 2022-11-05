const mongoose = require('mongoose')

const Schema = mongoose.Schema
//fertilizer Schema
const fertilizerSchema = new Schema({
  fertilizer_Name: {
    type: String,
    required: true,
  },
  fertilizer_code: {
    type: String,
    required: true,
  },
  picture: {
    type: String,
    required: false,
  },
  weight: {
    type: String,
    required: false,
  },
  description: {
    type: String,
    required: false,
  },
})

const fertilizer = mongoose.model('Fertilizer', fertilizerSchema)

module.exports = fertilizer

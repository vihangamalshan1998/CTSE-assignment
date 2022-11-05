const mongoose = require('mongoose')

const Schema = mongoose.Schema
//diseases Schema
const diseaseSchema = new Schema({
  diseaseName: {
    type: String,
    required: true,
  },
  antidote: {
    type: String,
    required: false,
  },
  description: {
    type: String,
    required: false,
  },
})

const disease = mongoose.model('Disease', diseaseSchema)

module.exports = disease

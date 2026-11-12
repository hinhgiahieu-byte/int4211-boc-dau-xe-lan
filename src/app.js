const express = require('express');
const cors = require('cors');

const app = express();

//Middlewares
app.use(cors());
app.use(express.json());

//Health check route
app.get('api/health',  (red, res) => {
    res.status(200).json({
        status: 'OK',
        message: 'REST API is running',
        timestamp: new Date().toISOString(),
    })
})

//Catch 404 error



module.exports = app;
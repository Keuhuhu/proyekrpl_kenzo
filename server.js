const express = require('express');
const cors = require ("cors");
const mysql = require('mysql'); 
const router = require("./routes/user_routes.js");
const antrianRoute = require("./routes/antrian_routes.js");

const port = 3000
const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({extended: true}));
app.use("/antrian", antrianRoute);

//routing
app.use("/users", router);
app.use("/antrian", antrianRoute);

app.listen(port, () => {
    console.log (`Server berjalan di port ${port}`);
})







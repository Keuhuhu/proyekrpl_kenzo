const { Router } = require("express");

const { ambilAntrian, getStatusAntrian, checkUserAntrian, panggilSelanjutnya, getRiwayatAntrian, getAllRiwayat} = require("../controllers/userController.js");


const router = Router();

// Rute khusus Antrian
router.post("/", ambilAntrian);      
router.get("/status", getStatusAntrian); 
router.get("/check/:userId", checkUserAntrian);
router.post("/next", panggilSelanjutnya);
router.get("/history", getRiwayatAntrian);
router.get("/all-history", getAllRiwayat);

module.exports = router;
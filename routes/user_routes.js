const {Router} = require ("express");
const {getUsers, createUser, loginUser, getMyProfile, updateProfile, deleteUser, getJamOperasional, 
    updateJamOperasional, getAllRiwayat, loginAdmin, updateJadwalDokter, getJadwalDokter} = require("../controllers/userController.js");

// PUT http://localhost:3000/users/profile

const router = Router();

router.get("/", getUsers);
router.post("/", createUser);
router.post("/login", loginUser);
router.get("/profile", getMyProfile);
router.put("/profile", updateProfile);
router.delete("/profile", deleteUser);
router.get("/jam", getJamOperasional);
router.put("/jam", updateJamOperasional);
router.get("/all-history", getAllRiwayat);
router.post("/admin-login", loginAdmin);
router.get("/jadwal-dokter", getJadwalDokter); 
router.put("/jadwal-dokter", updateJadwalDokter);

module.exports = router; 
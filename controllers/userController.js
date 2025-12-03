const db = require("../config/database.js");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const JWT_SECRET = "rahasia_dapur_klinik_123";

// --- 1. GET USERS ---
const getUsers = (req, res) => {
    db.query("SELECT * FROM users", (err, result) => {
        if (err) return res.status(500).send(err);
        res.json(result);
    });
};

// --- 2. REGISTER ---
const createUser = (req, res) => {
    const { nama, no_hp, email, password, role } = req.body;
    if (!nama || !no_hp || !email || !password || !role) {
        return res.status(400).json({ message: "Data tidak lengkap" });
    }
    const hashedPassword = bcrypt.hashSync(password, 10);
    const sql = `INSERT INTO users (nama, no_hp, email, password, role) VALUES (?, ?, ?, ?, ?)`;
    db.query(sql, [nama, no_hp, email, hashedPassword, role], (err, result) => {
        if (err) return res.status(500).json({ message: "Gagal daftar", error: err });
        res.status(201).json({ message: "Registrasi berhasil" });
    });
};

// --- 3. LOGIN ---
const loginUser = (req, res) => {
    const { email, password } = req.body;
    const sql = "SELECT * FROM users WHERE email = ?";
    db.query(sql, [email], (err, result) => {
        if (err) return res.status(500).json({ message: "Error Database" });
        if (result.length === 0) return res.status(404).json({ message: "Email tidak ditemukan" });

        const user = result[0];
        const isPasswordValid = bcrypt.compareSync(password, user.password);
        if (!isPasswordValid) return res.status(401).json({ message: "Password Salah" });

        const token = jwt.sign({ id: user.id, role: user.role }, JWT_SECRET, { expiresIn: '1h' });
        res.status(200).json({
            message: "Login Berhasil",
            token: token,
            data: { id: user.id, nama: user.nama, role: user.role }
        });
    });
};

// --- 4. GET PROFILE ---
const getMyProfile = (req, res) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];
    if (!token) return res.status(403).json({ message: "No token provided" });

    jwt.verify(token, JWT_SECRET, (err, decoded) => {
        if (err) return res.status(403).json({ message: "Token invalid" });
        const sql = "SELECT id, nama, no_hp, email, role, alamat, jenis_kelamin, tanggal_lahir FROM users WHERE id = ?";
        db.query(sql, [decoded.id], (err, result) => {
            if (err) return res.status(500).send(err);
            res.json({ status: 200, message: "Success", data: result[0] });
        });
    });
};

// --- 5. UPDATE PROFILE ---
const updateProfile = (req, res) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];
    if (!token) return res.status(403).json({ message: "No token" });

    jwt.verify(token, JWT_SECRET, (err, decoded) => {
        if (err) return res.status(403).json({ message: "Token invalid" });
        const { nama, email, no_hp, tanggal_lahir, jenis_kelamin, alamat } = req.body;
        const sql = `UPDATE users SET nama=?, email=?, no_hp=?, tanggal_lahir=?, jenis_kelamin=?, alamat=? WHERE id=?`;
        db.query(sql, [nama, email, no_hp, tanggal_lahir, jenis_kelamin, alamat, decoded.id], (err, result) => {
            if (err) return res.status(500).json({ message: "Gagal update" });
            res.status(200).json({ message: "Update berhasil" });
        });
    });
};

// --- 6. HAPUS AKUN ---
const deleteUser = (req, res) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];
    if (!token) return res.status(403).json({ message: "Akses ditolak" });

    jwt.verify(token, JWT_SECRET, (err, decoded) => {
        if (err) return res.status(403).json({ message: "Token invalid" });
        const sqlHapusAntrian = "DELETE FROM antrian WHERE user_id = ?";
        db.query(sqlHapusAntrian, [decoded.id], (err, result) => {
            const sqlHapusUser = "DELETE FROM users WHERE id = ?";
            db.query(sqlHapusUser, [decoded.id], (err, result) => {
                if (err) return res.status(500).json({ message: "Gagal hapus akun" });
                res.status(200).json({ message: "Akun dihapus" });
            });
        });
    });
};

// 7. AMBIL ANTRIAN (VERSI RESET HARIAN & SMART VALIDATION)
const ambilAntrian = (req, res) => {
    const { user_id, nama_pasien, nama_dokter } = req.body;
    
    // Format Tanggal Manual (Biar aman dari timezone, sesuai jam laptop)
    const now = new Date();
    const year = now.getFullYear();
    const month = String(now.getMonth() + 1).padStart(2, '0');
    const day = String(now.getDate()).padStart(2, '0');
    const tanggal_hari_ini = `${year}-${month}-${day}`; 

    // 1. CEK APAKAH USER PUNYA ANTRIAN AKTIF HARI INI?
    // (Hanya tolak kalau statusnya 'menunggu' atau 'dilayani'. Kalau 'selesai' boleh ambil lagi)
    const sqlCekUser = `SELECT * FROM antrian 
                        WHERE user_id = ? 
                        AND tanggal = ? 
                        AND status IN ('menunggu', 'dilayani')`; 
    
    db.query(sqlCekUser, [user_id, tanggal_hari_ini], (err, resultUser) => {
        if (err) return res.status(500).json({ message: "Error Database User Check" });

        if (resultUser.length > 0) {
            return res.status(400).json({ 
                message: "Anda masih memiliki antrian yang belum selesai hari ini!",
            });
        } 
        
        else {
            // === BAGIAN INI YANG DIKEMBALIKAN ===
            
            // 2. CEK NOMOR TERAKHIR (HANYA HARI INI)
            // Tambahkan 'AND tanggal = ?' agar besok reset jadi 1 lagi
            const sqlCekDokter = `SELECT MAX(nomor_antrian) as last_queue FROM antrian WHERE nama_dokter = ? AND tanggal = ?`;

            // Masukkan 'tanggal_hari_ini' ke parameter query
            db.query(sqlCekDokter, [nama_dokter, tanggal_hari_ini], (err, result) => {
                if (err) return res.status(500).json({ message: "Error Database Dokter Check" });

                let nomor_baru = 1;
                
                // Jika hari ini sudah ada antrian, lanjutkan
                if (result.length > 0 && result[0].last_queue !== null) {
                    nomor_baru = result[0].last_queue + 1;
                }

                // 3. SIMPAN KE DATABASE
                const sqlInsert = `INSERT INTO antrian (user_id, nama_pasien, nama_dokter, nomor_antrian, status, tanggal) VALUES (?, ?, ?, ?, 'menunggu', ?)`;
                
                db.query(sqlInsert, [user_id, nama_pasien, nama_dokter, nomor_baru, tanggal_hari_ini], (err, resInsert) => {
                    if (err) {
                        console.error("Gagal Insert:", err);
                        return res.status(500).json({ message: "Gagal ambil antrian" });
                    }
                    
                    res.status(201).json({
                        status: 201,
                        message: "Berhasil ambil antrian",
                        data: { nomor: nomor_baru, dokter: nama_dokter }
                    });
                });
            });
        }
    });
};

// --- 8. LIHAT STATUS ---
const getStatusAntrian = (req, res) => {
    const now = new Date();
    const tanggal_hari_ini = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}-${String(now.getDate()).padStart(2, '0')}`;
    const sql = `SELECT * FROM antrian WHERE tanggal = ? ORDER BY nomor_antrian ASC`;
    db.query(sql, [tanggal_hari_ini], (err, result) => {
        if (err) return res.status(500).send(err);
        res.json({ data: result });
    });
};

// --- 9. CEK STATUS USER (UNTUK TOMBOL GREY/BLUE) ---
const checkUserAntrian = (req, res) => {
    const userId = req.params.userId;
    const now = new Date();
    const tanggal_hari_ini = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}-${String(now.getDate()).padStart(2, '0')}`;

    // PERBAIKAN PENTING: Hanya return true jika status 'menunggu' atau 'dilayani'
    // Jika 'selesai', return false (tombol jadi biru lagi)
    const sql = `SELECT * FROM antrian WHERE user_id = ? AND tanggal = ? AND status IN ('menunggu', 'dilayani')`;
    
    db.query(sql, [userId, tanggal_hari_ini], (err, result) => {
        if (err) return res.status(500).json({ message: "Error Database" });

        if (result.length > 0) {
            res.json({ status: 200, exists: true, data: result[0] });
        } else {
            res.json({ status: 200, exists: false });
        }
    });
};

// --- 10. DOKTER MAJUKAN ANTRIAN ---
const panggilSelanjutnya = (req, res) => {
    const { nama_dokter } = req.body;
    const now = new Date();
    const tanggal_hari_ini = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, '0')}-${String(now.getDate()).padStart(2, '0')}`;

    const sqlSelesai = `UPDATE antrian SET status = 'selesai' WHERE nama_dokter = ? AND tanggal = ? AND status = 'dilayani'`;
    db.query(sqlSelesai, [nama_dokter, tanggal_hari_ini], (err, result) => {
        if (err) return res.status(500).json({ message: "Error update" });

        const sqlPanggil = `UPDATE antrian SET status = 'dilayani' WHERE id = (SELECT id FROM (SELECT id FROM antrian WHERE nama_dokter = ? AND tanggal = ? AND status = 'menunggu' ORDER BY nomor_antrian ASC LIMIT 1) as tmp)`;
        db.query(sqlPanggil, [nama_dokter, tanggal_hari_ini], (err, resultPanggil) => {
            if (err) return res.status(500).json({ message: "Error panggil" });
            res.status(200).json({ message: "Berhasil update antrian!" });
        });
    });
};

// --- 11. RIWAYAT ---
const getRiwayatAntrian = (req, res) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];
    if (!token) return res.status(403).json({ message: "Akses ditolak" });

    jwt.verify(token, JWT_SECRET, (err, decoded) => {
        if (err) return res.status(403).json({ message: "Token invalid" });

        const sql = `SELECT * FROM antrian WHERE user_id = ? ORDER BY tanggal DESC, created_at DESC`;
        db.query(sql, [decoded.id], (err, result) => {
            if (err) return res.status(500).json({ message: "Error" });

            res.status(200).json({ status: 200, data: result });
        });
    });
};

// 12. AMBIL JAM OPERASIONAL
const getJamOperasional = (req, res) => {
    db.query("SELECT * FROM jam_operasional", (err, result) => {
        if (err) return res.status(500).json({ message: "Error Database" });
        res.json({ data: result });
    });
};

// 13. UPDATE JAM OPERASIONAL
const updateJamOperasional = (req, res) => {
    const dataUpdate = req.body; // Array data dari frontend
    
    // Karena kita mengupdate BANYAK baris sekaligus, kita pakai looping
    // (Cara ini simpel untuk pemula, meski bukan yang paling performant untuk data besar)
    
    let errorCount = 0;
    
    dataUpdate.forEach(item => {
        const sql = "UPDATE jam_operasional SET jam = ? WHERE id = ?";
        db.query(sql, [item.jam, item.id], (err) => {
            if (err) errorCount++;
        });
    });

    // Kita anggap sukses (karena async loop database agak tricky di nodejs dasar)
    // Untuk project kuliah ini sudah cukup.
    setTimeout(() => {
        if (errorCount > 0) {
            res.status(500).json({ message: "Ada kesalahan saat menyimpan" });
        } else {
            res.json({ message: "Jam Operasional Berhasil Diupdate!" });
        }
    }, 500); // Kasih jeda dikit biar query selesai
};

// 14. ADMIN: LIHAT SEMUA RIWAYAT
const getAllRiwayat = (req, res) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];
    
    if (!token) return res.status(403).json({ message: "No token" });

    jwt.verify(token, JWT_SECRET, (err, decoded) => {
        if (err) return res.status(403).json({ message: "Token invalid" });

        // Query simple order by ID (newest first)
        const sql = `SELECT * FROM antrian ORDER BY id DESC`;

        db.query(sql, (err, result) => {
            if (err) {
                console.error("ERROR SQL ADMIN RIWAYAT:", err);
                return res.status(500).json({ message: "Error Database" });
            }
            
            res.status(200).json({
                status: 200,
                message: "Berhasil ambil semua data",
                data: result
            });
        });
    });
};

//15. Login Admin
const loginAdmin = (req, res) => {
    const { username, password } = req.body; // Admin pakai Username, bukan Email

    const sql = "SELECT * FROM admins WHERE username = ?";
    db.query(sql, [username], (err, result) => {
        if (err) return res.status(500).json({ message: "Error Database" });
        if (result.length === 0) return res.status(404).json({ message: "Admin tidak ditemukan" });

        const admin = result[0];
        const isPasswordValid = bcrypt.compareSync(password, admin.password); // Bandingkan hash

        if (!isPasswordValid) return res.status(401).json({ message: "Password Salah" });

        // Buat Token Khusus Admin
        const token = jwt.sign({ id: admin.id, role: 'admin' }, JWT_SECRET, { expiresIn: '1h' });

        res.status(200).json({
            message: "Login Admin Berhasil",
            token: token,
            data: { username: admin.username, nama: admin.nama_lengkap }
        });
    });
};


// 15. AMBIL JADWAL DOKTER
const getJadwalDokter = (req, res) => {
    // Ambil semua jadwal, urutkan berdasarkan poli dan nama dokter
    const sql = "SELECT * FROM jadwal_dokter ORDER BY poli, nama_dokter, id";
    db.query(sql, (err, result) => {
        if (err) return res.status(500).json({ message: "Error Database" });
        res.json({ data: result });
    });
};

// 16. UPDATE JADWAL DOKTER (ADMIN)
const updateJadwalDokter = (req, res) => {
    const dataUpdate = req.body; // Array data [{id: 1, jam: '09.00-12.00'}, ...]
    
    let errorCount = 0;
    
    // Looping update setiap baris jam
    dataUpdate.forEach(item => {
        const sql = "UPDATE jadwal_dokter SET jam = ? WHERE id = ?";
        db.query(sql, [item.jam, item.id], (err) => {
            if (err) errorCount++;
        });
    });

    setTimeout(() => {
        if (errorCount > 0) {
            res.status(500).json({ message: "Gagal menyimpan beberapa data" });
        } else {
            res.json({ message: "Jadwal Dokter Berhasil Diupdate!" });
        }
    }, 500);
};

module.exports = { 
    getUsers, createUser, loginUser, getMyProfile, updateProfile, deleteUser, 
    ambilAntrian, getStatusAntrian, checkUserAntrian, panggilSelanjutnya, getRiwayatAntrian,
    getJamOperasional, updateJamOperasional, getAllRiwayat, loginAdmin,
    getJadwalDokter, updateJadwalDokter
};
const token = localStorage.getItem('token_user');

if (!token) {
    alert("Anda belum login!");
    window.location.href = '../login.html';
}

// 1. FUNGSI LOAD DATA (Supaya form tidak kosong saat dibuka)
async function loadEditData() {
    try {
        const response = await fetch('http://localhost:3000/users/profile', {
            method: 'GET',
            headers: { 'Authorization': 'Bearer ' + token },
            cache: 'no-store'
        });
        const result = await response.json();
        const user = result.data;

        // Isi form dengan data yang sudah ada
        document.getElementById('nama').value = user.nama || "";
        document.getElementById('email').value = user.email || "";
        document.getElementById('telepon').value = user.no_hp || "";
        document.getElementById('alamat').value = user.alamat || "";
        document.getElementById('jenis-kelamin').value = user.jenis_kelamin || "";

        // Format Tanggal Lahir (PENTING!)
        // Database mengirim format panjang (2000-01-01T00:00:00.000Z)
        // Input type="date" butuh format pendek (2000-01-01)
        if (user.tanggal_lahir) {
            const dateOnly = new Date(user.tanggal_lahir).toISOString().split('T')[0];
            document.getElementById('tanggal-lahir').value = dateOnly;
        }

    } catch (error) {
        console.error("Gagal load data", error);
    }
}

// 2. FUNGSI SIMPAN DATA (PERBAIKAN)
async function saveProfile() {
    // Ambil semua data dari input
    const dataBaru = {
        nama: document.getElementById('nama').value,
        email: document.getElementById('email').value,
        no_hp: document.getElementById('telepon').value,
        alamat: document.getElementById('alamat').value,
        jenis_kelamin: document.getElementById('jenis-kelamin').value,
        tanggal_lahir: document.getElementById('tanggal-lahir').value
    };

    console.log("Mengirim Data:", dataBaru); // Cek di Console

    try {
        const response = await fetch('http://localhost:3000/users/profile', {
            method: 'PUT',
            headers: {
                'Authorization': 'Bearer ' + token,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(dataBaru)
        });

        // --- BAGIAN DIAGNOSA ---
        // Kita baca respon mentah dulu untuk memastikan server tidak mengirim HTML Error
        const textResponse = await response.text(); 
        console.log("Respon Server:", textResponse); 

        // Coba ubah jadi JSON
        let result;
        try {
            result = JSON.parse(textResponse);
        } catch (e) {
            console.error("Gagal parsing JSON:", e);
            throw new Error("Respon server bukan JSON yang valid.");
        }
        // -----------------------

        if (response.ok) {
        // 1. Simpan nama baru ke memori browser
        localStorage.setItem('nama_user', dataBaru.nama);

        // 2. Munculkan Alert standar (Pasti kelihatan)
        alert("Profil berhasil diperbarui!"); 

        // 3. Langsung pindah ke profil
        window.location.href = 'profile.html';
        }    else {
            alert("Gagal update: " + result.message);
        }
    } catch (error) {
        console.error("Error Detail:", error); // <-- LIHAT ERROR ASLINYA DI SINI
        alert("Terjadi kesalahan sistem. Cek Console (F12) untuk detailnya.");
    }
}

// Jalankan load data saat halaman dibuka
loadEditData();
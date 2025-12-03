// Jalankan saat halaman dibuka
window.onload = function() {
    loadProfileDisplay();
};

async function loadProfileDisplay() {
    // 1. CEK TOKEN DI SAKU BROWSER
    const token = localStorage.getItem('token_user');

    // Debugging: Cek apakah token benar-benar ada?
    console.log("Token saat ini:", token);

    if (!token) {
        // Penyebab 1: Token memang kosong/belum login
        alert("Token tidak ditemukan! Anda harus login dulu.");
        window.location.href = 'login.html'; // Pastikan path ini benar
        return;
    }

    try {
        // 2. MINTA DATA KE SERVER
        const response = await fetch('http://localhost:3000/users/profile', {
            method: 'GET',
            headers: {
                'Authorization': 'Bearer ' + token
            },
            cache: 'no-store'
        });

        const result = await response.json();

        if (response.ok) {
            // === SUKSES ===
            const user = result.data;
            console.log("Data User:", user);

            document.getElementById('displayNama').textContent = user.nama || "";

            let infoText = "";
            if (user.jenis_kelamin) infoText += user.jenis_kelamin;
            if (user.tanggal_lahir) {
                const umur = hitungUmur(user.tanggal_lahir);
                if (infoText) infoText += " | "; 
                infoText += umur + " Tahun";
            }
            document.getElementById('displayInfo').textContent = infoText || "-";

            if (user.alamat) {
                document.getElementById('displayAlamat').textContent = user.alamat;
                document.getElementById('displayAlamat').style.color = "inherit"; 
                document.getElementById('displayAlamat').style.fontStyle = "normal";
            } else {
                document.getElementById('displayAlamat').textContent = "-";
            }

        } else {
            // === GAGAL (Token Kadaluarsa / Server Menolak) ===
            // Penyebab 2: Token ada tapi ditolak server
            console.log("Respon Server:", result);
            alert("Sesi habis atau Token Salah. Silakan login ulang.\nPesan Server: " + result.message);
            
            localStorage.clear();
            window.location.href = 'login.html';
        }

    } catch (error) {
        console.error("Error Koneksi:", error);
        alert("Gagal menghubungi server (Backend Mati atau Error).");
    }
}

function hitungUmur(tanggalLahir) {
    const today = new Date();
    const birthDate = new Date(tanggalLahir);
    let age = today.getFullYear() - birthDate.getFullYear();
    const monthDiff = today.getMonth() - birthDate.getMonth();
    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
        age--;
    }
    return age;
}
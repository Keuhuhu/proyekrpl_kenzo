// Jalankan saat halaman dibuka
document.addEventListener('DOMContentLoaded', () => {
    updateSemuaKartu();
    
    // Update otomatis tiap 3 detik (Real-time)
    setInterval(updateSemuaKartu, 3000);
});

// FUNGSI 1: Ambil Data Status Terbaru
async function updateSemuaKartu() {
    try {
        const response = await fetch('http://localhost:3000/antrian/status');
        const result = await response.json();
        const semuaAntrian = result.data;

        // Update Kartu per Dokter
        updateKartuDokter("Dr. Umum", semuaAntrian, "card-umum");
        updateKartuDokter("Dr. Gigi", semuaAntrian, "card-gigi");
        updateKartuDokter("Dr. Anak", semuaAntrian, "card-anak");

    } catch (error) {
        console.error("Gagal update status:", error);
    }
}

// FUNGSI 2: Update Tampilan Satu Kartu
function updateKartuDokter(namaDokter, dataSemua, cardId) {
    const card = document.getElementById(cardId);
    if (!card) return;

    // Filter data dokter ini
    const dataDokter = dataSemua.filter(item => item.nama_dokter === namaDokter);

    // Cari Nomor "Sekarang" (Sedang Dilayani)
    const dilayani = dataDokter.find(item => item.status === 'dilayani');
    const nomorSekarang = dilayani ? dilayani.nomor_antrian : "-";

    // Cari Nomor "Selanjutnya" (Menunggu paling depan)
    const menunggu = dataDokter
        .filter(item => item.status === 'menunggu')
        .sort((a, b) => a.nomor_antrian - b.nomor_antrian);
    
    const nomorSelanjutnya = menunggu.length > 0 ? menunggu[0].nomor_antrian : "-";

    // Update HTML
    card.querySelector('.nomor-sekarang').innerText = nomorSekarang;
    card.querySelector('.nomor-selanjutnya').innerText = nomorSelanjutnya;
}

// FUNGSI 3: Tombol Panggil (Action)
async function panggil(namaDokter) {

    try {
        const response = await fetch('http://localhost:3000/antrian/next', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ nama_dokter: namaDokter })
        });

        const result = await response.json();
        
        if (response.ok) {
            alert(result.message); // "Berhasil memanggil..."
            updateSemuaKartu(); // Langsung refresh tampilan
        } else {
            alert("Gagal: " + result.message);
        }

    } catch (error) {
        console.error(error);
        alert("Gagal koneksi ke server");
    }
}
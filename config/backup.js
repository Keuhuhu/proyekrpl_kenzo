const mysqldump = require('mysqldump');
const path = require('path');

const fileName = `backup_proyekrpl_${Date.now()}.sql`;

mysqldump({
    connection: {
        host: 'localhost',
        user: 'root',       
        password: '',        
        database: 'proyekrpl', 
    },
    dumpToFile: path.join(__dirname, fileName)
}).then(() => {
    console.log("Backup selesai! File disimpan sebagai:", fileName);
}).catch(err => {
    console.error("Gagal backup:", err);
});

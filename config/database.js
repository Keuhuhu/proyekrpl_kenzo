const mysql = require('mysql');

const db = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root', 
  password: '', 
  database: 'proyekrpl' 
});

db.connect((err) => {
  if (err) throw err;
  console.log('Database Terhubung');
});

module.exports = db; // <-- Ini kuncinya biar bisa dipinjam file lain
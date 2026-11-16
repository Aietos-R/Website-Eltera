const jwt = require('jsonwebtoken');

// 1. Satpam Pengecek Token (Wajib Login)
const verifyToken = (req, res, next) => {
  // Frontend biasanya mengirim token di Header dengan format: "Bearer eyJhbG..."
  const authHeader = req.header('Authorization');
  const token = authHeader && authHeader.split(' ')[1]; // Ambil tokennya saja tanpa kata "Bearer "

  if (!token) {
    return res.status(401).json({ message: 'Akses ditolak! Anda belum login.' });
  }

  try {
    // Mengecek keaslian "stempel hologram" menggunakan kunci rahasia di .env
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    
    // Jika asli, simpan isi KTP (payload) ke dalam request agar bisa dibaca oleh tujuan
    req.user = decoded; 
    
    // Perintah sakti agar Flutter diizinkan masuk ke rute tujuan
    next(); 
  } catch (err) {
    return res.status(403).json({ message: 'Token tidak valid atau sudah kadaluarsa!' });
  }
};

// 2. Satpam Pengecek Jabatan (Khusus Admin)
// Catatan: Ini WAJIB diletakkan setelah verifyToken
const verifyAdmin = (req, res, next) => {
  // req.user ini didapat dari hasil tangkapan Satpam pertama di atas
  if (req.user.role !== 'admin') {
    return res.status(403).json({ message: 'Akses ditolak! Halaman ini khusus Admin.' });
  }
  next();
};

// Ekspor kedua satpam ini agar bisa dipanggil di server.js
module.exports = { verifyToken, verifyAdmin };
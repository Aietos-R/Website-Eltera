require('dotenv').config();
const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');
const bcrypt = require('bcryptjs');

const jwt = require('jsonwebtoken');

const app = express();
app.use(cors());
app.use(express.json());

const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASS,
  port: process.env.DB_PORT,
});

//Jalur API (Endpoint) untuk Login
app.post('/api/login', async (req, res) => {
  const { email, password } = req.body;

  try {
    // Mencari user di tabel 'users' berdasarkan email
    const result = await pool.query('SELECT * FROM users WHERE email_user = $1', [email]);
    
    if (result.rows.length === 0) {
      return res.status(401).json({ message: 'Email tidak ditemukan' });
    }

    const user = result.rows[0];

    // Cek password (Di dunia nyata, password harus di-hash. Ini versi sederhana)
    const isMatch = await bcrypt.compare(password, user.password);

    if (!isMatch) {
      return res.status(401).json({ message: 'Password salah' });
    }

    const payload = {
      id_user: user.id_user,
      role: user.role || 'murid',
      nama_user: user.nama_user
    };

    const token = jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '1h' });

    res.json({ 
      message: 'Login berhasil',
      token: token,
      id_user: user.id_user, 
      role: user.role || 'murid',
      nama_user: user.nama_user
    });

  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Terjadi kesalahan pada server' });
  }
});

//untuk register
app.post('/api/register', async (req, res) => {
  // Kita tangkap keduanya untuk berjaga-jaga (jika Flutter mengirim 'notelp' atau 'notelp_user')
  const nama = req.body.nama;
  const email = req.body.email;
  const password = req.body.password;
  const notelp_user = req.body.notelp_user || req.body.notelp; 

  //Validasi Nomor Telepon
  if (!notelp_user) {
    return res.status(400).json({ message: 'Nomor telepon gagal diterima oleh server!' });
  }

  //Validasi Password (Minimal 8 karakter, wajib ada huruf dan angka)
  const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
  if (!passwordRegex.test(password)) {
    return res.status(400).json({ message: 'Password minimal 8 karakter, wajib mengandung huruf dan angka!' });
  }

  try {
    const cekEmail = await pool.query('SELECT * FROM users WHERE email_user = $1', [email]);
    if (cekEmail.rows.length > 0) {
      return res.status(400).json({ message: 'Email sudah terdaftar' });
    }

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    const tambahUser = await pool.query(
      'INSERT INTO users (nama_user, email_user, password, notelp_user) VALUES ($1, $2, $3, $4) RETURNING *',
      [nama, email, hashedPassword, notelp_user]
    );

    res.status(201).json({ message: 'Pendaftaran berhasil! Silakan login.' });

  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Terjadi kesalahan saat mendaftar' });
  }
});

const { verifyToken, verifyAdmin } = require('./middlewares/auth');

// B. Contoh rute khusus user yang sudah login (Semua role boleh masuk asal punya Token)
app.get('/api/profil-saya', verifyToken, async (req, res) => {
  try {
    // Karena sudah lewat verifyToken, data req.user sudah otomatis terisi
    res.json({ 
      message: `Halo ${req.user.nama_user}! Ini adalah area profilmu.`,
      id: req.user.id_user,
      jabatan: req.user.role
    });
  } catch (err) {
    res.status(500).json({ message: 'Terjadi kesalahan pada server' });
  }
});

// C. Contoh rute khusus Admin (Harus punya Token DAN role harus 'admin')
app.get('/api/admin/dashboard', verifyToken, verifyAdmin, async (req, res) => {
  try {
    res.json({ message: 'Selamat datang di Ruang Kendali Admin Eltera!' });
  } catch (err) {
    res.status(500).json({ message: 'Terjadi kesalahan pada server' });
  }
});

const PORT = process.env.SERVER_PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server Backend Eltera berjalan di http://localhost:${PORT}`);
});
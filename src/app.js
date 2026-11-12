const express = require('express');
const cors = require('cors');

const app = express();

// Middlewares cơ bản
app.use(cors());
app.use(express.json());

// Route kiểm tra trạng thái server (Health Check)
app.get('/api/health', (req, res) => {
  res.status(200).json({
    status: 'OK',
    message: 'Gym & Yoga REST API is running',
    timestamp: new Date().toISOString(),
  });
});

// Bắt lỗi 404 cho các endpoint không tồn tại[cite: 1]
app.use((req, res) => {
  res.status(404).json({ message: 'Endpoint không tồn tại' });
});

// Middleware xử lý lỗi tập trung (500 Internal Server Error)[cite: 1]
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ message: 'Lỗi hệ thống nội bộ' });
});

module.exports = app;
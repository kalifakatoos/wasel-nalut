// server.js — Wasel Nalut Backend (Express + Socket.io + Supabase)
import express from 'express';
import http from 'http';
import { Server } from 'socket.io';
import cors from 'cors';
import morgan from 'morgan';
import dotenv from 'dotenv';
import { createClient } from '@supabase/supabase-js';

// Load environment variables
dotenv.config();

const {
  PORT = 3000,
  NODE_ENV = 'development',
  SUPABASE_URL,
  SUPABASE_ANON_KEY,
  JWT_SECRET = 'wasel_nalut_secure_jwt_token_2026_super_key',
  MASTER_ADMIN_PIN = '7788'
} = process.env;

// Validate required env variables
if (!SUPABASE_URL || !SUPABASE_ANON_KEY) {
  console.error('❌ Missing SUPABASE_URL or SUPABASE_ANON_KEY in environment');
  process.exit(1);
}

// Initialize Supabase client
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// Initialize Express app
const app = express();
const server = http.createServer(app);

// Middleware
app.use(cors({
  origin: process.env.NODE_ENV === 'production'
    ? ['https://wasel-nalut.onrender.com']
    : ['http://localhost:3000', 'http://localhost:8080']
}));
app.use(express.json({ limit: '10mb' }));
app.use(morgan('combined'));
app.use(express.static('public'));

// Static web routes
import path from 'path';
import { fileURLToPath } from 'url';
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

app.get('/merchant', (req, res) => {
  res.sendFile(path.join(__dirname, 'public/merchant.html'));
});

app.get('/admin', (req, res) => {
  res.sendFile(path.join(__dirname, 'public/admin.html'));
});

// Initialize Socket.io
const io = new Server(server, {
  cors: {
    origin: process.env.NODE_ENV === 'production'
      ? ['https://wasel-nalut.onrender.com']
      : ['http://localhost:3000', 'http://localhost:8080'],
    methods: ["GET", "POST"]
  }
});

// --- REST API Routes ---

// Health check
app.get('/api/v1/health', (req, res) => {
  res.status(200).json({
    status: 'ok',
    timestamp: new Date().toISOString(),
    service: 'Wasel Nalut Backend',
    version: '1.0.0'
  });
});

// Store endpoint — fetches all open stores
app.get('/api/v1/stores', async (req, res) => {
  try {
    const { data, error } = await supabase
      .from('stores')
      .select('*')
      .eq('is_open', true);

    if (error) throw error;

    res.status(200).json({
      success: true,
      count: data.length,
      stores: data
    });
  } catch (err) {
    console.error('❌ GET /stores error:', err.message);
    res.status(500).json({
      success: false,
      error: 'Internal server error'
    });
  }
});

// Single store menu endpoint
app.get('/api/v1/stores/:id/menu', async (req, res) => {
  const { id } = req.params;

  try {
    // Fetch store details
    const { data: store, error: storeError } = await supabase
      .from('stores')
      .select('*')
      .eq('id', id)
      .single();

    if (storeError) throw storeError;
    if (!store || !store.is_open) {
      return res.status(404).json({ error: 'Store not found or closed' });
    }

    // Fetch products for this store
    const { data: products, error: productsError } = await supabase
      .from('products')
      .select('*')
      .eq('store_id', id)
      .eq('is_available', true);

    if (productsError) throw productsError;

    res.status(200).json({
      success: true,
      store,
      products
    });
  } catch (err) {
    console.error('❌ GET /stores/:id/menu error:', err.message);
    res.status(500).json({
      success: false,
      error: 'Internal server error'
    });
  }
});

// Placeholder for orders checkout
app.post('/api/v1/orders/checkout', async (req, res) => {
  const orderData = req.body;

  try {
    res.status(201).json({
      success: true,
      message: 'Order created (stub)',
      orderNumber: `WAS-NAL-${Math.floor(Math.random() * 9000) + 1000}`,
      otpCode: `${Math.floor(Math.random() * 9000)}`.padStart(4, '0'),
      status: 'placed',
      ...orderData
    });
  } catch (err) {
    console.error('❌ POST /orders/checkout error:', err.message);
    res.status(500).json({
      success: false,
      error: 'Order processing failed'
    });
  }
});

// Admin overview endpoint (requires PIN)
app.get('/api/v1/admin/overview', (req, res) => {
  const pin = req.query.pin || req.headers['x-admin-pin'];

  if (pin !== MASTER_ADMIN_PIN) {
    return res.status(403).json({ error: 'Unauthorized — valid admin PIN required' });
  }

  res.status(200).json({
    activeOrders: 14,
    liveDrivers: 8,
    gmvLYD: 4970.00,
    cashCollectedLYD: 3450.00
  });
});

// --- Socket.io Real-Time Telemetry ---
io.on('connection', (socket) => {
  console.log(`📡 Socket connected: ${socket.id}`);

  socket.on('driver:location_update', (payload) => {
    const { orderId, driverId, lat, lng, heading } = payload;

    if (orderId) {
      socket.to(`order:${orderId}`).emit('order:driver_location', {
        lat, lng, heading, driverId,
        eta: '5 min'
      });
    }

    socket.to('admin:fleet').emit('admin:driver_marker', {
      driverId, lat, lng, heading
    });
  });

  socket.on('driver:register', ({ driverId, name, coords }) => {
    socket.join('drivers');
    console.log(`🛵 ${name} (${driverId}) registered at ${JSON.stringify(coords)}`);
    io.emit('fleet:driver_online', { driverId, name });
  });

  socket.on('order:join', ({ orderId }) => {
    socket.join(`order:${orderId}`);
    console.log(`👤 Customer joined order room: ${orderId}`);
  });

  socket.on('admin:join_fleet', () => {
    socket.join('admin:fleet');
    console.log(`🛡 Admin joined fleet monitoring`);
  });

  socket.on('disconnect', () => {
    console.log(`📡 Socket disconnected: ${socket.id}`);
  });
});

// Root route — API status
app.get('/', (req, res) => {
  res.status(200).json({
    service: 'Wasel Nalut Super-App',
    status: 'running',
    version: '1.0.0',
    environment: NODE_ENV,
    endpoints: {
      health: '/api/v1/health',
      stores: '/api/v1/stores',
      menu: '/api/v1/stores/:id/menu',
      checkout: '/api/v1/orders/checkout',
      admin: '/api/v1/admin/overview?pin=...'
    }
  });
});

app.use((req, res) => {
  res.status(404).json({ error: 'Not found' });
});

server.listen(PORT, () => {
  console.log(`🚀 Wasel Nalut Backend running on http://localhost:${PORT}`);
});

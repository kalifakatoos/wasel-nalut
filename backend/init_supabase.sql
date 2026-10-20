-- backend/init_supabase.sql — Wasel Nalut Production Schema Initialization
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "postgis";

-- 1. USERS & ROLES
DO $$ BEGIN
    CREATE TYPE user_role AS ENUM ('customer', 'driver', 'merchant', 'admin');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    role user_role DEFAULT 'customer',
    avatar_url TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. STORES & CATEGORIES
DO $$ BEGIN
    CREATE TYPE store_vertical AS ENUM ('food', 'grocery', 'marketplace');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

CREATE TABLE IF NOT EXISTS stores (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    vertical store_vertical DEFAULT 'food',
    district VARCHAR(100) DEFAULT 'وسط نالوت',
    latitude DOUBLE PRECISION NOT NULL,
    longitude DOUBLE PRECISION NOT NULL,
    rating NUMERIC(2, 1) DEFAULT 4.8,
    is_open BOOLEAN DEFAULT TRUE,
    base_delivery_fee NUMERIC(6, 2) DEFAULT 5.00,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. PRODUCTS & MODIFIERS
CREATE TABLE IF NOT EXISTS products (
    id VARCHAR(50) PRIMARY KEY,
    store_id VARCHAR(50) REFERENCES stores(id) ON DELETE CASCADE,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    base_price_lyd NUMERIC(8, 2) NOT NULL,
    image_url TEXT,
    is_available BOOLEAN DEFAULT TRUE,
    category VARCHAR(50),
    is_food BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. CAPTAINS / DRIVERS
DO $$ BEGIN
    CREATE TYPE driver_status AS ENUM ('offline', 'online', 'busy');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

CREATE TABLE IF NOT EXISTS drivers (
    id VARCHAR(50) PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    vehicle_type VARCHAR(50) DEFAULT 'سيارة',
    plate_number VARCHAR(30),
    status driver_status DEFAULT 'offline',
    current_latitude DOUBLE PRECISION,
    current_longitude DOUBLE PRECISION,
    rating NUMERIC(2, 1) DEFAULT 4.9,
    active_orders_count INT DEFAULT 0,
    cod_balance_lyd NUMERIC(10, 2) DEFAULT 0.00,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 5. ORDERS & TRACKING
DO $$ BEGIN
    CREATE TYPE order_status AS ENUM (
        'placed', 'accepted', 'preparing', 'ready_for_pickup',
        'picked_up', 'delivered', 'cancelled', 'disputed'
    );
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

CREATE TABLE IF NOT EXISTS orders (
    id VARCHAR(50) PRIMARY KEY,
    order_number VARCHAR(20) UNIQUE NOT NULL,
    customer_id UUID REFERENCES users(id),
    customer_name VARCHAR(100),
    customer_phone VARCHAR(20),
    store_id VARCHAR(50) REFERENCES stores(id),
    store_name VARCHAR(150),
    driver_id VARCHAR(50) REFERENCES drivers(id),
    driver_name VARCHAR(100),
    status order_status DEFAULT 'placed',
    items JSONB NOT NULL,
    subtotal_lyd NUMERIC(8, 2) NOT NULL,
    delivery_fee_lyd NUMERIC(8, 2) NOT NULL,
    total_amount_lyd NUMERIC(8, 2) NOT NULL,
    delivery_address TEXT,
    delivery_lat DOUBLE PRECISION,
    delivery_lng DOUBLE PRECISION,
    otp_code VARCHAR(4) NOT NULL,
    payment_method VARCHAR(20) DEFAULT 'cod',
    prep_time_minutes INT DEFAULT 20,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert seed data for Nalut stores
INSERT INTO stores (id, name, vertical, district, latitude, longitude, rating, is_open, base_delivery_fee)
VALUES
    ('store_nalut_01', 'مطعم قصر نالوت للمشويات والشاورما', 'food', 'وسط نالوت', 31.8687, 10.9818, 4.9, TRUE, 5.00),
    ('store_nalut_02', 'سوبرماركت الأمل الحديث', 'grocery', 'حي سيدي خليفة', 31.8710, 10.9850, 4.8, TRUE, 4.00),
    ('store_nalut_03', 'متجر متاع نالوت للإلكترونيات', 'marketplace', 'طريق الجبل والقلعة', 31.8650, 10.9780, 5.0, TRUE, 6.00)
ON CONFLICT (id) DO NOTHING;

-- Insert seed products
INSERT INTO products (id, store_id, title, description, base_price_lyd, category, is_food)
VALUES
    ('prod_01', 'store_nalut_01', 'شاورما دجاج تنور نالوتي', 'شاورما دجاج مميزة مع صلصة الثومية الحارة والخبز العربي الطازج', 12.00, 'مشويات', TRUE),
    ('prod_02', 'store_nalut_01', 'وجبة مشويات مشكلة', 'تخبيطة لحم ضأن وكباب نالوتي مع بطاطا وسلطة', 35.00, 'مشويات', TRUE),
    ('prod_03', 'store_nalut_02', 'حليب وطني طازج 1 لتر', 'حليب طبيعي طازج عالي الجودة', 5.00, 'ألبان', FALSE),
    ('prod_04', 'store_nalut_03', 'شاحن متنقل سريع 20000 ملي أمبير', 'شاحن أصلي عالي الأداء مع ضمان سنة', 85.00, 'إلكترونيات', FALSE)
ON CONFLICT (id) DO NOTHING;

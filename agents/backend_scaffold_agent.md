# وكيل Backend Scaffold — وصف المهمة

## المهمة
إنشاء هيكل أولي للـ backend باستخدام Node.js و Express و PostgreSQL (Supabase).

## الخطوات
1. إنشاء `backend/package.json` مع التبعيات الأساسية:
   - express
   - socket.io
   - @supabase/supabase-js
   - dotenv
2. إنشاء `backend/server.js` — إعداد Express + WebSocket.
3. ربط Supabase باستخدام `SUPABASE_URL` و `SUPABASE_ANON_KEY`.
4. تضمين endpoint تجريبي: `GET /stores`.

## التسليم
- ملفات `server.js` و `package.json` جاهزة.
- Repo محدّث.

## الملاحظات
- استخدام ESModules (`"type": "module"`).
- إعداد CORS و Logger أساسيين.

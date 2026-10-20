# خريطة الوكلاء — مشروع Wasel Nalut

## الوكلاء المُستخدمون

| اسم الوكيل | المهمة | الحالة |
|-----------|--------|--------|
| Repo Init Agent | إنشاء GitHub Repo + هيكل المشروع | ✅ جديد |
| Backend Scaffold Agent | إعداد الـ backend (Express + Supabase) | ✅ جديد |
| Flutter Dev Agent | بناء UI التطبيقات الأربعة | ⏳ في الانتظار |
| DevOps Agent | نشر و CI/CD على Render | ⏳ فى الانتظار |
| Simulation Agent | تشغيل محاكاة اللوجستيات | ⏳ في الانتظار |

## كيفية التنفيذ
1. دعوة الوكلاء حسب المرحلة.
2. كل وكيل يُكمل مهمته ويُرسل تقريرًا.
3. مراجعة دمج (merge review) يُدارها Repo Init Agent.

## الملاحظة
- جميع الوكلاء يعملون على فرع منفصل (`feature/<name>`) ثم يدمجونه في `main`.

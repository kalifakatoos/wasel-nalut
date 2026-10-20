// active_delivery_flow_screen.dart — 4-step turn-by-turn delivery execution
import 'package:flutter/material.dart';

class ActiveDeliveryFlowScreen extends StatefulWidget {
  const ActiveDeliveryFlowScreen({super.key});

  @override
  State<ActiveDeliveryFlowScreen> createState() => _ActiveDeliveryFlowScreenState();
}

class _ActiveDeliveryFlowScreenState extends State<ActiveDeliveryFlowScreen> {
  int currentStep = 1; // 1: Heading to Store, 2: Pickup, 3: Heading to Customer, 4: OTP & Cash

  final TextEditingController otpController = TextEditingController();
  bool cashCollected = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('تنفيذ الطلب • مرحلة $currentStep من 4'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress indicator
              LinearProgressIndicator(value: currentStep / 4.0, backgroundColor: Colors.grey.shade200, color: Colors.blue.shade800),
              const SizedBox(height: 24),

              if (currentStep == 1) ...[
                const Text('المرحلة 1: التوجه للمتجر', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                const Text('المتجر: مطعم قصر نالوت للمشويات', style: TextStyle(fontSize: 16)),
                const Text('العنوان: شارع القلعة الرئيسي، نالوت', style: TextStyle(color: Colors.grey)),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade800, foregroundColor: Colors.white, padding: const EdgeInsets.all(16)),
                    onPressed: () => setState(() => currentStep = 2),
                    child: const Text('وصلت إلى المتجر (Arrived)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ] else if (currentStep == 2) ...[
                const Text('المرحلة 2: تأكيد استلام الوجبة من المطعم', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                const Text('• 2x شاورما دجاج تنور نالوتي', style: TextStyle(fontSize: 15)),
                const Text('• 1x بطاطا مقلية مقرمشة', style: TextStyle(fontSize: 15)),
                const SizedBox(height: 16),
                const Text('تأكد من مطابقة الأصناف وسلامة التغليف الساخن قبل الاستلام.', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, padding: const EdgeInsets.all(16)),
                    onPressed: () => setState(() => currentStep = 3),
                    child: const Text('استلمت الطلب وبدء رحلة التوصيل', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ] else if (currentStep == 3) ...[
                const Text('المرحلة 3: التوجه للزبون', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                const Text('الزبون: سليمان النالوتي', style: TextStyle(fontSize: 16)),
                const Text('العنوان: حي سيدي خليفة، بجانب المسجد العتيق', style: TextStyle(color: Colors.grey)),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade800, foregroundColor: Colors.white, padding: const EdgeInsets.all(16)),
                    onPressed: () => setState(() => currentStep = 4),
                    child: const Text('وصلت لموقع الزبون', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ] else ...[
                const Text('المرحلة 4: إدخال رمز OTP وتحصيل الكاش', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                const Text('المطلوب تحصيله نقداً (COD): 32.00 د.ل', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange)),
                const SizedBox(height: 20),
                TextField(
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  decoration: InputDecoration(
                    labelText: 'أدخل رمز الـ OTP المكون من 4 أرقام من الزبون',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                CheckboxListTile(
                  title: const Text('تم استلام المبلغ نقداً كاملاً (32.00 د.ل)'),
                  value: cashCollected,
                  onChanged: (val) => setState(() => cashCollected = val ?? false),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, padding: const EdgeInsets.all(16)),
                    onPressed: () {
                      if (otpController.text.length == 4 && cashCollected) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تم إتمام الطلب بنجاح وتمت إضافة أجر التوصيل لمحفظتك!')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('الرجاء إدخال رمز OTP وتأكيد استلام الكاش')),
                        );
                      }
                    },
                    child: const Text('إتمام وتسليم الطلب', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

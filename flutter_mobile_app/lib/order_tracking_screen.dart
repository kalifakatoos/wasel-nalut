// order_tracking_screen.dart — Live GPS tracking & delivery timeline
import 'package:flutter/material.dart';
import 'design_system.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تتبع الطلب النشط • WAS-NAL-8492'),
        ),
        body: Column(
          children: [
            // Map placeholder simulation
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.blueGrey.shade100,
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.map, size: 64, color: Colors.grey),
                        SizedBox(height: 8),
                        Text('خريطة نالوت الحية (OpenStreetMap / GPS Telemetry)', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
                      child: const Text('📍 الكابتن على بعد 1.2 كم', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.waselPrimary)),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // OTP Banner
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.waselLight,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.waselPrimary.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('رمز تأكيد الاستلام (OTP)', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.waselPrimary)),
                                SizedBox(height: 4),
                                Text('أعطِ هذا الرمز للكابتن عند استلام الطلب', style: TextStyle(fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(color: AppColors.waselPrimary, borderRadius: BorderRadius.circular(8)),
                              child: const Text('4821', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 4)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      const Text('مراحل التوصيل', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),

                      _buildTimelineStep('تم تأكيد الطلب من المطعم', '10:42 صباحاً', true, false),
                      _buildTimelineStep('المطعم يجهز الوجبة الآن', '10:45 صباحاً', true, false),
                      _buildTimelineStep('الكابتن (محمد نالوتي) في الطريق إليك', 'قريباً', true, true),
                      _buildTimelineStep('تم التوصيل بنجاح', 'في الانتظار', false, false),

                      const Divider(height: 32),

                      // Captain contact card
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const CircleAvatar(
                          backgroundColor: AppColors.waselPrimary,
                          child: Icon(Icons.delivery_dining, color: Colors.white),
                        ),
                        title: const Text('محمد نالوتي (كابتن واصل)', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: const Text('دراجة نارية • لوحة 7842 نالوت'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.phone, color: AppColors.success),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.chat, color: AppColors.info),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineStep(String title, String time, bool isCompleted, bool isActive) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCompleted ? AppColors.success : (isActive ? AppColors.waselPrimary : Colors.grey.shade300),
            ),
            child: Icon(
              isCompleted ? Icons.check : (isActive ? Icons.hourglass_top : Icons.circle),
              size: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: isActive ? FontWeight.bold : FontWeight.normal, color: isActive ? AppColors.waselPrimary : Colors.black87)),
                Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

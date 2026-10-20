// driver_home_screen.dart — Shift toggle, earnings, COD debt warning
import 'package:flutter/material.dart';
import 'order_radar_dialog.dart';
import 'active_delivery_flow_screen.dart';
import 'driver_wallet_screen.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  bool isOnline = false;
  double codBalance = 350.00; // Cash in hand (COD debt)
  double netEarnings = 70.00;
  int completedTrips = 14;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('كابتن واصل • نالوت'),
          actions: [
            IconButton(
              icon: const Icon(Icons.wallet),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const DriverWalletScreen()));
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shift Switch Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isOnline ? Colors.green.shade50 : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isOnline ? Colors.green : Colors.grey.shade300, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isOnline ? 'أنت في العمل (متاح للطلبات)' : 'أنت في استراحة (غير متصل)',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isOnline ? Colors.green.shade800 : Colors.grey.shade700),
                        ),
                        const SizedBox(height: 4),
                        Text(isOnline ? 'جهازك يستقبل طلبات نالوت الآن 📡' : 'فعّل الشفت لاستلام المشاوير', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                    Switch(
                      value: isOnline,
                      activeColor: Colors.green,
                      onChanged: (val) {
                        setState(() => isOnline = val);
                        if (val) {
                          // Simulate incoming radar offer after 3 seconds
                          Future.delayed(const Duration(seconds: 3), () {
                            if (mounted && isOnline) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) => const OrderRadarDialog(),
                              );
                            }
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // COD Debt Warning if > 500
              if (codBalance > 500)
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.red)),
                  child: const Row(
                    children: [
                      Icon(Icons.warning, color: Colors.red),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'تنبيه عهدة نقدية: تجاوزت عهدة الكاش 500 د.ل. يرجى توريد المبلغ بمركز نالوت لاستئناف الطلبات.',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),

              const Text('ملخص اليوم', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(child: _buildMetricCard('المشاوير', '$completedTrips مشوار', Icons.delivery_dining, Colors.blue)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildMetricCard('أرباح التوصيل', '$netEarnings د.ل', Icons.savings, Colors.green)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildMetricCard('عهدة الكاش (COD)', '$codBalance د.ل', Icons.money, Colors.orange)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildMetricCard('تقييم الكابتن', '4.9 ⭐', Icons.star, Colors.amber)),
                ],
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.navigation),
                  label: const Text('فتح تدفق التوصيل التجريبي', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ActiveDeliveryFlowScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

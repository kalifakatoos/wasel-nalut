// driver_wallet_screen.dart — COD debt & cash deposit ledger
import 'package:flutter/material.dart';

class DriverWalletScreen extends StatelessWidget {
  const DriverWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('محفظة الكابتن والعهد النقدية')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('إجمالي عهدة الكاش بحوزتك (COD)', style: TextStyle(color: Colors.white70, fontSize: 14)),
                    SizedBox(height: 8),
                    Text('350.00 د.ل', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('يجب توريد المبلغ في مركز نالوت عند تجاوز 500 د.ل', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('سجل الحركات المالية الأخيرة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Expanded(
                child: ListView(
                  children: const [
                    ListTile(
                      leading: Icon(Icons.arrow_downward, color: Colors.green),
                      title: Text('أجر توصيل طلب WAS-NAL-8491'),
                      subtitle: Text('20 أكتوبر 2026 • 10:15 ص'),
                      trailing: Text('+5.00 د.ل', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.money, color: Colors.orange),
                      title: Text('تحصيل كاش طلب WAS-NAL-8490 (COD)'),
                      subtitle: Text('20 أكتوبر 2026 • 09:30 ص'),
                      trailing: Text('+32.00 د.ل', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.receipt_long, color: Colors.blue),
                      title: Text('سند قبض توريد عهدة نقدية بمركز نالوت'),
                      subtitle: Text('19 أكتوبر 2026 • 04:00 م'),
                      trailing: Text('-400.00 د.ل', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

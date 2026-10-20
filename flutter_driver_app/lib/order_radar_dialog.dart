// order_radar_dialog.dart — High-urgency incoming offer modal with 15s timer
import 'package:flutter/material.dart';
import 'active_delivery_flow_screen.dart';

class OrderRadarDialog extends StatefulWidget {
  const OrderRadarDialog({super.key});

  @override
  State<OrderRadarDialog> createState() => _OrderRadarDialogState();
}

class _OrderRadarDialogState extends State<OrderRadarDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 15))
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.pop(context); // Auto dismiss if 15s expires
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.radar, color: Colors.red, size: 28),
            const SizedBox(width: 8),
            const Text('طلب توصيل جديد في نالوت!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(value: 1.0, valueColor: _controller.drive(ColorTween(begin: Colors.red, end: Colors.orange))),
            const SizedBox(height: 16),
            const Text('مطعم قصر نالوت • شارع القلعة', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            const Text('المسافة: 1.4 كم للمتجر • 2.8 كم للزبون', style: TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(10)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('أجر التوصيل الكابتن:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('+5.00 د.ل', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('اعتذار', style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ActiveDeliveryFlowScreen()),
              );
            },
            child: const Text('قبول الطلب'),
          ),
        ],
      ),
    );
  }
}

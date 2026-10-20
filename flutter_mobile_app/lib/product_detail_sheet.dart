// product_detail_sheet.dart — Dual-mode food & e-commerce modifier bottom sheet
import 'package:flutter/material.dart';
import 'design_system.dart';

class ProductDetailSheet extends StatefulWidget {
  final String storeName;
  const ProductDetailSheet({super.key, required this.storeName});

  @override
  State<ProductDetailSheet> createState() => _ProductDetailSheetState();
}

class _ProductDetailSheetState extends State<ProductDetailSheet> {
  String selectedSize = 'حجم عادي (سنجل)';
  final List<String> addons = [];
  int quantity = 1;

  final double basePrice = 12.00;

  double get totalPrice {
    double sizeExtra = 0;
    if (selectedSize == 'حجم مزدوج (دبل)') sizeExtra = 5.00;
    if (selectedSize == 'حجم عائلي كبير (جامبو)') sizeExtra = 12.00;

    double addonsExtra = addons.length * 1.50;
    return (basePrice + sizeExtra + addonsExtra) * quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(child: Text('شاورما دجاج تنور نالوتي', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.lightTextPrimary))),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                ],
              ),
              Text(widget.storeName, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              const SizedBox(height: 16),

              const Text('اختر الحجم المطلوب:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 8),
              _buildRadioOption('حجم عادي (سنجل)', '+0.00 د.ل'),
              _buildRadioOption('حجم مزدوج (دبل)', '+5.00 د.ل'),
              _buildRadioOption('حجم عائلي كبير (جامبو)', '+12.00 د.ل'),
              const Divider(height: 24),

              const Text('إضافات وتعديلات:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 8),
              _buildCheckboxOption('صلصة ثومية ليبية حارة (+1.50 د.ل)'),
              _buildCheckboxOption('شريحة جبنة شيدر مدخنة (+2.00 د.ل)'),
              _buildCheckboxOption('بطاطا مقلية مقرمشة إضافية (+3.50 د.ل)'),
              const Divider(height: 24),

              const Text('تعليمات خاصة للمطبخ:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'مثال: بدون بصل، ثومية إضافية جانباً...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: AppColors.lightBackground,
                ),
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          if (quantity > 1) setState(() => quantity--);
                        },
                      ),
                      Text('$quantity', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () => setState(() => quantity++),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.waselPrimary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('تمت الإضافة للسلة بنجاح • ${totalPrice.toStringAsFixed(2)} د.ل')),
                      );
                    },
                    child: Text('إضافة للسلة • ${totalPrice.toStringAsFixed(2)} د.ل', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioOption(String title, String price) {
    bool isSelected = selectedSize == title;
    return InkWell(
      onTap: () => setState(() => selectedSize = title),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: AppColors.waselPrimary),
            const SizedBox(width: 12),
            Text(title, style: const TextStyle(fontSize: 14)),
            const Spacer(),
            Text(price, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxOption(String title) {
    bool isChecked = addons.contains(title);
    return InkWell(
      onTap: () {
        setState(() {
          if (isChecked) {
            addons.remove(title);
          } else {
            addons.add(title);
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(isChecked ? Icons.check_box : Icons.check_box_outline_blank, color: AppColors.waselPrimary),
            const SizedBox(width: 12),
            Text(title, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

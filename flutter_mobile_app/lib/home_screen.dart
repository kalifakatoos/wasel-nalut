// home_screen.dart — Wasel Nalut Super-App Home Dashboard (World-Class Redesign)
import 'package:flutter/material.dart';
import 'design_system.dart';
import 'product_detail_sheet.dart';
import 'order_tracking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedVertical = 'food'; // 'food', 'grocery', 'marketplace'
  String selectedDistrict = 'وسط نالوت';

  final List<String> districts = [
    'وسط نالوت',
    'حي سيدي خليفة',
    'طريق الجبل والقلعة',
    'طريق الحوامد / كاباو'
  ];

  final List<Map<String, dynamic>> stores = [
    {
      'id': 'store_nalut_01',
      'name': 'مطعم قصر نالوت للمشويات والشاورما',
      'vertical': 'food',
      'rating': 4.9,
      'time': '20-30 دقيقة',
      'fee': '5.00 د.ل',
      'image': 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=500',
      'district': 'وسط نالوت',
    },
    {
      'id': 'store_nalut_02',
      'name': 'سوبرماركت الأمل الحديث',
      'vertical': 'grocery',
      'rating': 4.8,
      'time': '15-25 دقيقة',
      'fee': '4.00 د.ل',
      'image': 'https://images.unsplash.com/photo-1578916171728-46686eac8d58?w=500',
      'district': 'حي سيدي خليفة',
    },
    {
      'id': 'store_nalut_03',
      'name': 'متجر متاع نالوت للإلكترونيات',
      'vertical': 'marketplace',
      'rating': 5.0,
      'time': 'توصيل فوري',
      'fee': '6.00 د.ل',
      'image': 'https://images.unsplash.com/photo-1526738549149-8e07eca6c147?w=500',
      'district': 'طريق الجبل والقلعة',
    }
  ];

  @override
  Widget build(BuildContext context) {
    final filteredStores = stores.where((s) {
      return s['vertical'] == selectedVertical && s['district'] == selectedDistrict;
    }).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        appBar: AppBar(
          backgroundColor: AppColors.darkSurface,
          elevation: 0,
          title: Row(
            children: [
              const Icon(Icons.location_on, color: AppColors.waselPrimary),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: selectedDistrict,
                dropdownColor: AppColors.darkCard,
                style: const TextStyle(color: AppColors.darkTextPrimary, fontWeight: FontWeight.bold),
                underline: const SizedBox(),
                items: districts.map((d) {
                  return DropdownMenuItem(value: d, child: Text(d, style: const TextStyle(fontSize: 14)));
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => selectedDistrict = val);
                },
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.receipt_long, color: AppColors.waselPrimary),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderTrackingScreen()));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Immersive Gradient Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.waselPrimary, AppColors.waselSecondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(color: AppColors.waselPrimary.withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 8))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text('تطبيق واصل نالوت 🚀', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text('كل ما تحتاجه في نالوت وصل بباب بيتك — طعام، مقاضي، وإلكترونيات.', style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Vertical Selector Tabs
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildVerticalTab('طعام', 'food', Icons.restaurant),
                    _buildVerticalTab('مقاضي', 'grocery', Icons.shopping_cart),
                    _buildVerticalTab('سوق', 'marketplace', Icons.storefront),
                  ],
                ),
                const SizedBox(height: 24),

                const Text('المتاجر المتاحة في منطقتك', style: TextStyle(color: AppColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),

                filteredStores.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Text('لا توجد متاجر نشطة حالياً في هذا القسم ضمن هذا الحي.', style: TextStyle(color: AppColors.darkTextMuted)),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredStores.length,
                        itemBuilder: (context, index) {
                          final store = filteredStores[index];
                          return GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => ProductDetailSheet(storeName: store['name']),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: AppColors.darkCard,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: AppColors.darkBorder),
                                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                    child: Image.network(store['image'], height: 160, width: double.infinity, fit: BoxFit.cover),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(child: Text(store['name'], style: const TextStyle(color: AppColors.darkTextPrimary, fontSize: 16, fontWeight: FontWeight.bold))),
                                            Row(
                                              children: [
                                                const Icon(Icons.star, color: AppColors.gold, size: 16),
                                                const SizedBox(width: 4),
                                                Text('${store['rating']}', style: const TextStyle(color: AppColors.darkTextPrimary, fontWeight: FontWeight.bold)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            const Icon(Icons.access_time, size: 14, color: AppColors.darkTextSecondary),
                                            const SizedBox(width: 4),
                                            Text(store['time'], style: const TextStyle(color: AppColors.darkTextSecondary, fontSize: 12)),
                                            const SizedBox(width: 16),
                                            const Icon(Icons.delivery_dining, size: 14, color: AppColors.waselSecondary),
                                            const SizedBox(width: 4),
                                            Text(store['fee'], style: const TextStyle(color: AppColors.waselSecondary, fontSize: 12, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalTab(String title, String verticalKey, IconData icon) {
    final isSelected = selectedVertical == verticalKey;
    return GestureDetector(
      onTap: () => setState(() => selectedVertical = verticalKey),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.waselPrimary : AppColors.darkCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? AppColors.waselPrimary : AppColors.darkBorder),
          boxShadow: isSelected ? [BoxShadow(color: AppColors.waselPrimary.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))] : [],
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.white : AppColors.darkTextSecondary, size: 18),
            const SizedBox(width: 8),
            Text(title, style: TextStyle(color: isSelected ? Colors.white : AppColors.darkTextSecondary, fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

// home_screen.dart — Wasel Nalut Super-App Home Dashboard
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
        appBar: AppBar(
          title: Row(
            children: [
              const Icon(Icons.location_on, color: AppColors.waselPrimary),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: selectedDistrict,
                underline: const SizedBox(),
                items: districts.map((d) {
                  return DropdownMenuItem(value: d, child: Text(d, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)));
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => selectedDistrict = val);
                },
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.receipt_long),
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
                // Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [AppColors.waselPrimary, AppColors.waselSecondary]),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('تطبيق واصل نالوت 🚀', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('كل ما تحتاجه في نالوت وصل بباب بيتك — طعام، مقاضي، وإلكترونيات.', style: TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Vertical Selector Tabs
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildVerticalTab('food', 'طعام 🍔', AppColors.waselPrimary),
                    _buildVerticalTab('grocery', 'مقاضي 🛒', AppColors.waselGreen),
                    _buildVerticalTab('marketplace', 'متاع ⚡', AppColors.waselPurple),
                  ],
                ),
                const SizedBox(height: 24),

                const Text('المتاجر المتاحة في منطقتك', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),

                filteredStores.isEmpty
                    ? const Center(child: Padding(padding: EdgeInsets.all(40), child: Text('لا توجد متاجر نشطة في هذا الحي حالياً')))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredStores.length,
                        itemBuilder: (context, index) {
                          final store = filteredStores[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (_) => ProductDetailSheet(storeName: store['name']),
                                );
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                    child: Image.network(store['image'], height: 150, width: double.infinity, fit: BoxFit.cover),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(store['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            const Icon(Icons.star, size: 16, color: AppColors.gold),
                                            const SizedBox(width: 4),
                                            Text('${store['rating']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                            const SizedBox(width: 16),
                                            const Icon(Icons.access_time, size: 16, color: Colors.grey),
                                            const SizedBox(width: 4),
                                            Text(store['time']),
                                            const Spacer(),
                                            Text('التوصيل ${store['fee']}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.waselPrimary)),
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

  Widget _buildVerticalTab(String id, String label, Color color) {
    bool isSelected = selectedVertical == id;
    return InkWell(
      onTap: () => setState(() => selectedVertical = id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: isSelected ? color : Colors.grey.shade300),
          boxShadow: isSelected ? [BoxShadow(color: color.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))] : [],
        ),
        child: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

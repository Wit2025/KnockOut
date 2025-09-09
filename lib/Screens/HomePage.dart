import 'package:flutter/material.dart';
import 'package:knockout/Screens/Profile/Support/SupportPage.dart';
import 'package:knockout/Screens/ScanQRCodePage.dart';
import 'package:knockout/Widgets/AppColors.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.darkButton, AppColors.mainButton],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 30),
                child: Column(
                  children: [
                    // Header Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.white, Color(0xFFE0E7FF)],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Color(0xFF3B82F6),
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'ສະບາຍດີ, ຍ້ອຍສະຫວັນ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'ມື້ນີ້ຊີລ້າງໝວກກັນນ໋ອກບໍ່?',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications_outlined,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // ยอดเงินและคะแนน
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildInfoCard(
                          icon: Icons.account_balance_wallet_outlined,
                          label: 'ຍອດເງິນ',
                          value: '270,000 ກີບ',
                        ),
                        _buildInfoCard(
                          icon: Icons.star_border_rounded,
                          label: 'ແຕ້ມ',
                          value: '35 ຄະແນນ',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Services Section
                    Text(
                      'ບໍລິການຂອງພວກເຮົາ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    SizedBox(height: 16),

                    GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.1,
                      children: [
                        _buildServiceCard(
                          'ລ້າງທຳມະດາ',
                          '10,000 ກີບ',
                          Icons.cleaning_services_outlined,
                          Color(0xFF10B981),
                          context,
                          'ລ້າງທຳມະດາ',
                        ),
                        _buildServiceCard(
                          'ລ້າງ Premium',
                          '20,000 ກີບ',
                          Icons.star_outline,
                          Color(0xFFF59E0B),
                          context,
                          'ລ້າງ Premium',
                        ),
                        _buildServiceCard(
                          'ຂ້າເຊື້ອ',
                          '25,000 ກີບ',
                          Icons.health_and_safety,
                          Color(0xFF8B5CF6),
                          context,
                          'ຂ້າເຊື້ອ',
                        ),
                        _buildServiceCard(
                          'ລ້າງ + ອົບແຫ້ງ',
                          '30,000 ກີບ',
                          Icons.whatshot,
                          Color(0xFFEF4444),
                          context,
                          'ລ້າງ + ອົບແຫ້ງ',
                        ),
                      ],
                    ),
                    SizedBox(height: 32),

                    // Promotions Section
                    Text(
                      'ໂປໂມຊັ່ນ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    SizedBox(height: 16),

                    Container(
                      height: 160,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildPromotionCard(
                            'ລ້າງ 3 ຄັ້ງ ຟຣີ 1 ຄັ້ງ',
                            'ປະຢັດໄດ້ 60,000 ກີບ',
                            Color(0xFFEC4899),
                          ),
                          SizedBox(width: 16),
                          _buildPromotionCard(
                            'ສະມາຊິກໃໝ່ ຫຼຸດ 20%',
                            'ສຳລັບການໃຊ້ບໍລິການຄັ້ງທຳອິດ',
                            Color(0xFF06B6D4),
                          ),
                          SizedBox(width: 16),
                          _buildPromotionCard(
                            'ແພັກເກັດ VIP',
                            'ລ້າງບໍ່ຈຳກັດ 30 ວັນ 300,000 ກີບ',
                            Color(0xFF8B5CF6),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),

                    // Quick Actions
                    Text(
                      'ເມນູດ່ວນ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: _buildQuickAction(
                            'ຕິດຕໍ່ຮ້ານ',
                            Icons.support_agent_outlined,
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SupportPage(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      height: 70,
      width: 140,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.7),
            Colors.white.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 22, color: const Color(0xFF3B82F6)),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    String title,
    String price,
    IconData icon,
    Color color,
    BuildContext context,
    String serviceType,
  ) {
    double numericPrice = double.parse(
      price.replaceAll(',', '').replaceAll('ກີບ', '').trim(),
    );
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QRScannerScreen(
              selectedService: serviceType,
              selectedPrice: numericPrice,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              price,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionCard(String title, String description, Color color) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withOpacity(0.8)]),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.local_offer, color: Colors.white, size: 28),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xFF3B82F6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Color(0xFF3B82F6), size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Color(0xFF9CA3AF), size: 16),
          ],
        ),
      ),
    );
  }
}

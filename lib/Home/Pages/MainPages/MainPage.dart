import 'package:flutter/material.dart';
import 'package:knockout/Home/Pages/MainPages/Notification/Notofication.dart';
import 'package:knockout/Home/Pages/ScanQR/ScanQRCodePage.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/Support/SupportPage.dart';
import 'package:knockout/Widgets/AppColors.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.mainButton, AppColors.mainButton],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textColor.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 30),
                child: Column(
                  children: [
                    // Header Row - ส่วนที่ปรับปรุง
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.backgroundColor.withOpacity(0.5),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.textColor.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/p.jpg',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.backgroundColor,
                                        AppColors.mainButton,
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: AppColors.mainButton,
                                    size: 32,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ข้อความทักทาย - ปรับให้มีสไตล์มากขึ้น
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'ສະບາຍດີ, ',
                                      style: TextStyle(
                                        color: AppColors.backgroundColor
                                            .withOpacity(0.9),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'ຍ້ອຍສະຫວັນ',
                                      style: const TextStyle(
                                        color: AppColors.backgroundColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              // ข้อความเสริม - ปรับให้ดูน่าสนใจ
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundColor.withOpacity(
                                    0.15,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'ມື້ນີ້ຊີລ້າງໝວກກັນນ໋ອກບໍ່?',
                                  style: TextStyle(
                                    color: AppColors.backgroundColor
                                        .withOpacity(0.95),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // ปุ่มการแจ้งเตือน - ปรับให้ดูทันสมัย
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.backgroundColor.withOpacity(0.2),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.textColor.withOpacity(0.1),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              IconButton(
                                onPressed: () {
                                  // นำทางไปยังหน้า NotificationPage
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NotificationPage(),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.notifications_outlined,
                                  color: AppColors.backgroundColor,
                                  size: 26,
                                ),
                              ),
                              Positioned(
                                right: 8,
                                top: 8,
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: AppColors.error,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
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

              // ส่วนที่เหลือของโค้ดไม่เปลี่ยนแปลง
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
                        color: AppColors.textColor,
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
                          AppColors.mainButton,
                          context,
                          'ລ້າງທຳມະດາ',
                        ),
                        _buildServiceCard(
                          'ລ້າງ Premium',
                          '20,000 ກີບ',
                          Icons.star_outline,
                          AppColors.warning,
                          context,
                          'ລ້າງ Premium',
                        ),
                        _buildServiceCard(
                          'ຂ້າເຊື້ອ',
                          '25,000 ກີບ',
                          Icons.health_and_safety,
                          AppColors.third,
                          context,
                          'ຂ້າເຊື້ອ',
                        ),
                        _buildServiceCard(
                          'ລ້າງ + ອົບແຫ້ງ',
                          '30,000 ກີບ',
                          Icons.whatshot,
                          AppColors.error,
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
                        color: AppColors.textColor,
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
                            'ປະຢັດໄດ້ 10,000 ກີບ',
                            AppColors.darkButton,
                          ),
                          SizedBox(width: 16),
                          _buildPromotionCard(
                            'ສະມາຊິກໃໝ່ ຫຼຸດ 20%',
                            'ສຳລັບການໃຊ້ບໍລິການຄັ້ງທຳອິດ',
                            AppColors.mainButton,
                          ),
                          SizedBox(width: 16),
                          _buildPromotionCard(
                            'ແພັກເກັດ VIP',
                            'ລ້າງບໍ່ຈຳກັດ 30 ວັນ 300,000 ກີບ',
                            AppColors.third,
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
                        color: AppColors.textColor,
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

  // ฟังก์ชันอื่นๆ ไม่เปลี่ยนแปลง
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
            AppColors.backgroundColor.withOpacity(0.7),
            AppColors.backgroundColor.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.textColor.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 22, color: AppColors.mainButton),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
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
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.textColor.withOpacity(0.1),
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
                color: AppColors.textColor,
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
          Icon(Icons.local_offer, color: AppColors.backgroundColor, size: 28),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: AppColors.backgroundColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(color: AppColors.backgroundColor, fontSize: 14),
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
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.textColor.withOpacity(0.1),
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
                color: AppColors.mainButton.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.mainButton, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.borderColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

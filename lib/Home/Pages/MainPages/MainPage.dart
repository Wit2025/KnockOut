import 'package:flutter/material.dart';
import 'package:knockout/Home/Pages/MainPages/Widgets/HeaderSection.dart';
import 'package:knockout/Home/Pages/MainPages/Widgets/PromotionCard.dart';
import 'package:knockout/Home/Pages/MainPages/Widgets/QuickAction.dart';
import 'package:knockout/Home/Pages/MainPages/Widgets/ServiceCard.dart';
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
              HeaderSection(),
              
              // ส่วนที่เหลือของโค้ด
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
                        ServiceCard(
                          title: 'ລ້າງທຳມະດາ',
                          price: '10,000 ກີບ',
                          icon: Icons.cleaning_services_outlined,
                          color: AppColors.mainButton,
                          serviceType: 'ລ້າງທຳມະດາ',
                        ),
                        ServiceCard(
                          title: 'ລ້າງ Premium',
                          price: '20,000 ກີບ',
                          icon: Icons.star_outline,
                          color: AppColors.warning,
                          serviceType: 'ລ້າງ Premium',
                        ),
                        ServiceCard(
                          title: 'ຂ້າເຊື້ອ',
                          price: '25,000 ກີບ',
                          icon: Icons.health_and_safety,
                          color: AppColors.third,
                          serviceType: 'ຂ້າເຊື້ອ',
                        ),
                        ServiceCard(
                          title: 'ລ້າງ + ອົບແຫ້ງ',
                          price: '30,000 ກີບ',
                          icon: Icons.whatshot,
                          color: AppColors.error,
                          serviceType: 'ລ້າງ + ອົບແຫ້ງ',
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
                          PromotionCard(
                            title: 'ລ້າງ 3 ຄັ້ງ ຟຣີ 1 ຄັ້ງ',
                            description: 'ປະຢັດໄດ້ 10,000 ກີບ',
                            color: AppColors.darkButton,
                          ),
                          SizedBox(width: 16),
                          PromotionCard(
                            title: 'ສະມາຊິກໃໝ່ ຫຼຸດ 20%',
                            description: 'ສຳລັບການໃຊ້ບໍລິການຄັ້ງທຳອິດ',
                            color: AppColors.mainButton,
                          ),
                          SizedBox(width: 16),
                          PromotionCard(
                            title: 'ແພັກເກັດ VIP',
                            description: 'ລ້າງບໍ່ຈຳກັດ 30 ວັນ 300,000 ກີບ',
                            color: AppColors.third,
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
                          child: QuickAction(
                            title: 'ຕິດຕໍ່ຮ້ານ',
                            icon: Icons.support_agent_outlined,
                            onTap: () {
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
}
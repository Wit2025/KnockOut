import 'package:flutter/material.dart';
import 'package:knockout/Home/Pages/Histories/HistoryPage.dart';
import 'package:knockout/Home/Pages/MainPages/MainPage.dart';
import 'package:knockout/Home/Pages/Profiles/ProfilePage.dart';
import 'package:knockout/Home/Pages/ScanQR/ScanQRCodePage.dart';
import 'package:knockout/Home/Pages/TrackingStatus/TrackingPage.dart';
import 'package:knockout/Widgets/AppBar.dart';
import 'package:knockout/Widgets/AppColors.dart';

class Home extends StatefulWidget {
  final int initialIndex;
  const Home({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _pages = [
    MainPage(),
    RealtimeTrackingPage(),
    QRScannerScreen(),
    HistoryPage(),
    ProfilePage(),
  ];

  final List<String> _pageTitles = [
    '',
    'ຕິດຕາມສະຖານະ',
    '',
    'ປະຫວັດການລ້າງ',
    'ໂປຣຟາຍ',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: _pageTitles[_currentIndex]),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 8,
            color: AppColors.backgroundColor,
            padding: EdgeInsets.zero,
            child: Container(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // หน้าแรก
                    _buildNavItem(
                      index: 0,
                      icon: Icons.home_outlined,
                      label: 'ໜ້າຫຼັກ',
                    ),
                    _buildNavItem(
                      index: 1,
                      icon: Icons.schedule,
                      label: 'ສະຖານະ',
                    ),
                    SizedBox(width: 48),
                    _buildNavItem(
                      index: 3,
                      icon: Icons.history,
                      label: 'ປະຫວັດ',
                    ),
                    _buildNavItem(
                      index: 4,
                      icon: Icons.person_2_outlined,
                      label: 'ໂປຣຟາຍ',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 1),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [AppColors.iconSelect, AppColors.mainButton],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.mainButton.withOpacity(0.4),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QRScannerScreen()),
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          highlightElevation: 0,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          child: Icon(
            Icons.qr_code_scanner,
            size: 40,
            color: AppColors.backgroundColor,
          ),
        ),
      ),
    );
  }

  // เมธอดสร้าง Navigation Item
  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    bool isSelected = _currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _currentIndex = index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.mainButton : AppColors.iconUnselect,
              size: isSelected ? 30 : 24,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? AppColors.mainButton
                    : AppColors.iconUnselect,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

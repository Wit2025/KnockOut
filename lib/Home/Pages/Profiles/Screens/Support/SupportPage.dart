import 'package:flutter/material.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/Support/Widgets/BranchesTab.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/Support/Widgets/ChatMessage.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/Support/Widgets/FAQTab.dart';
import 'package:knockout/Widgets/AppColors.dart';

class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.backgroundColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'ຕິດຕໍ່ພວກເຮົາ',
          style: TextStyle(
            color: AppColors.backgroundColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.darkButton, AppColors.mainButton],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'ສາຂາ'),
            Tab(text: 'ແຊທ'),
            Tab(text: 'FAQ'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [BranchesTab(), ChatTab(), FAQTab()],
      ),
    );
  }
}

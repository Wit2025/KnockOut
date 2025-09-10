import 'package:flutter/material.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/ChangePassword/ChangePassword.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/Support/SupportPage.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/TermCondition/TermCondition.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/Wallets/WalletPage.dart';
import 'package:knockout/Widgets/AppColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Map<String, dynamic> userProfile = {
    'name': 'ຍ້ອຍສະຫວັນ ສີລິມຸງຄຸນ',
    'email': 'yoisavanh@email.com',
    'phone': '08X-XXX-XXXX',
    'points': 35,
    'level': 'Silver',
    'memberSince': 'ມີນາ 2024',
    'totalServices': 2,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              margin: EdgeInsets.all(24),
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.mainButton, AppColors.mainButton],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.mainButton.withOpacity(0.3),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Profile Picture
                  Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.backgroundColor,
                              AppColors.backgroundColor.withOpacity(0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: AppColors.mainButton,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: AppColors.backgroundColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              size: 16,
                              color: AppColors.mainButton,
                            ),
                            onPressed: () {
                              // Change profile picture
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  Text(
                    userProfile['name'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.backgroundColor,
                    ),
                  ),
                  SizedBox(height: 8),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.backgroundColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      'ສະມາຊິກ ${userProfile['level']}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.backgroundColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Stats Row - แบบใหม่
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.backgroundColor.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(
                          Icons.star,
                          '${userProfile['points']}',
                          'ແຕ້ມສະສົມ',
                        ),
                        _buildDivider(),
                        _buildStatItem(
                          Icons.local_laundry_service,
                          '${userProfile['totalServices']}',
                          'ບໍລິການ',
                        ),
                        _buildDivider(),
                        _buildStatItem(
                          Icons.calendar_today,
                          '',
                          userProfile['memberSince'],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Menu Items
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _buildMenuItem(
                    'ຂໍ້ມູນສ່ວນຕົວ',
                    'ແກ້ໄຂຂໍ້ມູນ ແລະ ການຕັ້ງຄ່າ',
                    Icons.person_outline,
                    () => _editProfile(),
                  ),

                  _buildMenuItem(
                    'ເຕິມເງິນ',
                    'ເຕີມເງິນເພື່ອໃຊ້ຈ່າຍ',
                    Icons.account_balance_wallet,
                    () => _wallets(),
                  ),

                  _buildMenuItem(
                    'ລະຫັດຜ່ານ',
                    'ປ່ຽນລະຫັດຜ່ານ',
                    Icons.key_outlined,
                    () => _passwordSettings(),
                  ),

                  _buildMenuItem(
                    'ຕິດຕໍ່ ແລະ ການສະໜັບສະໜູນ',
                    'ຊ່ວຍເຫຼືອ ແລະ ຕິກຕໍ່ຮ້ານ',
                    Icons.support_agent_outlined,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SupportPage()),
                      );
                    },
                  ),

                  _buildMenuItem(
                    'ເງືອນໄຂ ແລະ ຂໍ້ຕົກລົງ',
                    'ນະໂຍບາຍຄວາມເປັນສ່ວນຕົວ',
                    Icons.description_outlined,
                    () => _showTermsAndConditions(),
                  ),

                  SizedBox(height: 20),

                  // Logout Button
                  Container(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: _showLogoutDialog,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.error),
                        foregroundColor: AppColors.error,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'ອອກຈາກລະບົບ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.iconUnselect,
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: AppColors.backgroundColor),
          ),
          SizedBox(height: 8),
          if (value.isNotEmpty)
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.backgroundColor,
              ),
              textAlign: TextAlign.center,
            ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.backgroundColor.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            AppColors.backgroundColor.withOpacity(0.3),
            Colors.transparent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: AppColors.borderColor.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.mainButton.withOpacity(0.1),
                      AppColors.iconSelect.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.mainButton, size: 24),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColor,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.iconUnselect,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.mainButton.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.mainButton,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editProfile() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.borderColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: 20),

              Text(
                'ແກ້ໄຂຂໍ້ມູນສ່ວນຕົວ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              // Form fields would go here
              _buildFormField('ຊື່ ແລະ ນາມສະກຸນ', userProfile['name']),
              SizedBox(height: 16),
              _buildFormField('ອີເມລ', userProfile['email']),
              SizedBox(height: 16),
              _buildFormField('ເບີໂທລະສັບ', userProfile['phone']),

              Spacer(),

              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainButton,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'ບັນທຶກ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.backgroundColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFormField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textColor,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        TextFormField(
          initialValue: value,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.backgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.mainButton, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  void _wallets() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WalletPage()),
    );
  }

  void _passwordSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChangePasswordPage()),
    );
  }

  void _showTermsAndConditions() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TermsAndConditionsPage()),
    );
  }

  void _showLogoutDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'ອອກຈາກລະບົບ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'ທ່ານແນ່ໃຈວ່າຈະອອກຈາກລະບົບບໍ່?',
            style: TextStyle(fontSize: 16, color: AppColors.textColor),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'ຍົກເລິກ',
                style: TextStyle(color: AppColors.borderColor),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // ลบค่า login
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('isLoggedIn');

                // ปิด dialog
                Navigator.pop(context);

                // กลับไปหน้า Login
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'ອອກຈາກລະບົບ',
                style: TextStyle(color: AppColors.backgroundColor),
              ),
            ),
          ],
        );
      },
    );
  }
}

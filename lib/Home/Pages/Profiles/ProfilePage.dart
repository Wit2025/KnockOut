import 'package:flutter/material.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/ChangePassword/ChangePassword.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/Support/SupportPage.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/TermCondition/TermCondition.dart';
import 'package:knockout/Home/Pages/Profiles/Screens/Wallets/WalletPage.dart';
import 'package:knockout/Home/Pages/Profiles/Widgets/EditProfileSheet.dart';
import 'package:knockout/Home/Pages/Profiles/Widgets/LogoutButton.dart';
import 'package:knockout/Home/Pages/Profiles/Widgets/LogoutDialog.dart';
import 'package:knockout/Home/Pages/Profiles/Widgets/ProfileHeader.dart';
import 'package:knockout/Home/Pages/Profiles/Widgets/ProfileMenuItem.dart';
import 'package:knockout/Widgets/AppColors.dart';

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
            ProfileHeader(userProfile: userProfile),

            // Menu Items
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  ProfileMenuItem(
                    title: 'ຂໍ້ມູນສ່ວນຕົວ',
                    subtitle: 'ແກ້ໄຂຂໍ້ມູນ ແລະ ການຕັ້ງຄ່າ',
                    icon: Icons.person_outline,
                    onTap: _editProfile,
                  ),

                  ProfileMenuItem(
                    title: 'ເຕິມເງິນ',
                    subtitle: 'ເຕີມເງິນເພື່ອໃຊ້ຈ່າຍ',
                    icon: Icons.account_balance_wallet,
                    onTap: _wallets,
                  ),

                  ProfileMenuItem(
                    title: 'ລະຫັດຜ່ານ',
                    subtitle: 'ປ່ຽນລະຫັດຜ່ານ',
                    icon: Icons.key_outlined,
                    onTap: _passwordSettings,
                  ),

                  ProfileMenuItem(
                    title: 'ຕິດຕໍ່ ແລະ ການສະໜັບສະໜູນ',
                    subtitle: 'ຊ່ວຍເຫຼືອ ແລະ ຕິກຕໍ່ຮ້ານ',
                    icon: Icons.support_agent_outlined,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SupportPage()),
                      );
                    },
                  ),

                  ProfileMenuItem(
                    title: 'ເງືອນໄຂ ແລະ ຂໍ້ຕົກລົງ',
                    subtitle: 'ນະໂຍບາຍຄວາມເປັນສ່ວນຕົວ',
                    icon: Icons.description_outlined,
                    onTap: _showTermsAndConditions,
                  ),

                  SizedBox(height: 20),

                  // Logout Button
                  LogoutButton(onPressed: _showLogoutDialog),
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

  void _editProfile() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return EditProfileSheet(userProfile: userProfile);
      },
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
    showDialog(context: context, builder: (context) => LogoutDialog());
  }
}

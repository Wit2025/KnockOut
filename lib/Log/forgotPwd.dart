import 'package:flutter/material.dart';
import 'package:knockout/Log/OTP_Page.dart';
import 'package:knockout/Widgets/AppColors.dart';
import 'package:flutter/services.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _phoneController = TextEditingController();

  void _sendOTP() {
  String phone = _phoneController.text.trim();
  if (phone.isEmpty || phone.length < 8) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('ກະລຸນາໃສ່ເບີໂທທີ່ຖືກຕ້ອງ')),
    );
    return;
  }

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => OTPPage(
        phoneNumber: phone,
        isRegister: false, // เพราะเป็น forgot password
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          'ລືມລະຫັດຜ່ານ',
          style: TextStyle(
            color: AppColors.backgroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.backgroundColor),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.iconSelect, AppColors.mainButton],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            Text(
              'ປ້ອນເບີໂທລະສັບຂອງທ່ານເພື່ອຮັບ OTP ສໍາລັບການຢືນຢັນ',
              style: TextStyle(fontSize: 16, color: AppColors.textColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: 'ເບີໂທ',
                filled: true,
                fillColor: AppColors.backgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.iconUnselect),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.mainButton, width: 2),
                ),
                prefixIcon: Icon(Icons.phone, color: AppColors.iconUnselect),
              ),
            ),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _sendOTP,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainButton,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  'ຮັບລະຫັດ OTP',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.backgroundColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

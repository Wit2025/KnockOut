import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:knockout/Log/ResetPassword.dart';

class OTPPage extends StatefulWidget {
  final String phoneNumber;
  final bool isRegister;

  OTPPage({required this.phoneNumber, this.isRegister = false});

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  int _remainingTime = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _verifyOTP() {
    String otp = _controllers.map((controller) => controller.text).join();
    if (otp.length == 4) {
      // ตรวจสอบ OTP เสร็จแล้ว
      if (widget.isRegister) {
        // มาจากหน้า Register -> ไปหน้า Login
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          (Route<dynamic> route) => false,
        );
      } else {
        // มาจากหน้า Forgot Password -> ไปหน้า ResetPassword
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ResetPasswordPage(phoneNumber: widget.phoneNumber),
          ),
        );
      }
    }
  }

  void _resendOTP() {
    setState(() {
      _remainingTime = 60;
      for (var controller in _controllers) {
        controller.clear();
      }
    });
    _startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF3B82F6)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'ຢືນຢັນ OTP',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            SizedBox(height: 32),
            Container(
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFF3B82F6).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.sms_outlined,
                      size: 40,
                      color: Color(0xFF3B82F6),
                    ),
                  ),
                  SizedBox(height: 24),

                  Text(
                    'ຢືນຢັນລະຫັດ OTP',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'ກາລຸນາປ້ອນລະັດ 4 ຫຼັກທີ່ສົ່ງໄປໃຫ້',
                    style: TextStyle(color: Color(0xFF6B7280), fontSize: 16),
                  ),
                  Text(
                    widget.phoneNumber,
                    style: TextStyle(
                      color: Color(0xFF3B82F6),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 32),

                  // OTP Input Fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return Container(
                        width: 60,
                        height: 60,
                        child: TextFormField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: Color(0xFFF9FAFB),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color(0xFFD1D5DB)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color(0xFF3B82F6),
                                width: 2,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 3) {
                              _focusNodes[index + 1].requestFocus();
                            } else if (value.isEmpty && index > 0) {
                              _focusNodes[index - 1].requestFocus();
                            }

                            if (value.isNotEmpty && index == 3) {
                              _verifyOTP();
                            }
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 32),

                  // Verify Button
                  Container(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _verifyOTP,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3B82F6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        'ຢືນຢັນ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Resend OTP
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ບໍ່ໄດ້ຮັບລະຫັດບໍ່? ',
                        style: TextStyle(color: Color(0xFF6B7280)),
                      ),
                      if (_remainingTime > 0)
                        Text(
                          'ສົ່ງໃໝ່ໃນ $_remainingTime ວິນາທີ',
                          style: TextStyle(color: Color(0xFF6B7280)),
                        )
                      else
                        TextButton(
                          onPressed: _resendOTP,
                          child: Text(
                            'ສົ່ງລະຫັດໃໝ່',
                            style: TextStyle(
                              color: Color(0xFF3B82F6),
                              fontWeight: FontWeight.w600,
                            ),
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
    );
  }
}

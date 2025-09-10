import 'package:flutter/material.dart';
import 'package:knockout/Widgets/AppBar.dart';
import 'package:knockout/Widgets/AppColors.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  // ตัวแปรสำหรับตรวจสอบเงื่อนไขรหัสผ่านใหม่
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasNumbers = false;

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_validateNewPassword);
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _newPasswordController.removeListener(_validateNewPassword);
    super.dispose();
  }

  void _validateNewPassword() {
    final text = _newPasswordController.text;
    setState(() {
      _hasMinLength = text.length >= 6;
      _hasUppercase = RegExp(r'[A-Z]').hasMatch(text);
      _hasLowercase = RegExp(r'[a-z]').hasMatch(text);
      _hasNumbers = RegExp(r'[0-9]').hasMatch(text);
    });
  }

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
      // จำลองการเปลี่ยนรหัสผ่าน
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('ປ່ຽນລະຫັດຜ່ານສຳເລັດ'),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 2),
        ),
      );

      // ล้างฟอร์มหลังจากเปลี่ยนรหัสสำเร็จ
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
      setState(() {
        _hasMinLength = false;
        _hasUppercase = false;
        _hasLowercase = false;
        _hasNumbers = false;
      });
    }
  }

  Widget _buildPasswordRequirement(String text, bool isMet) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.circle,
          size: 16,
          color: isMet ? AppColors.success : AppColors.iconUnselect,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isMet ? AppColors.success : AppColors.iconUnselect,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: GradientAppBar(title: 'ປ່ຽນລະຫັດຜ່ານ', showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // หัวข้อ
              const Text(
                'ປ່ຽນລະຫັດຜ່ານຂອງທ່ານ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
              const SizedBox(height: 32),

              // รหัสผ่านปัจจุบัน
              TextFormField(
                controller: _currentPasswordController,
                obscureText: _obscureCurrentPassword,
                decoration: InputDecoration(
                  labelText: 'ລະຫັດຜ່ານປະຈຸບັນ',
                  labelStyle: const TextStyle(color: AppColors.mainButton),
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.mainButton,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureCurrentPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.mainButton.withOpacity(0.6),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureCurrentPassword = !_obscureCurrentPassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.mainButton),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ກະລຸນາໃສ່ລະຫັດຜ່ານປະຈຸບັນ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // รหัสผ่านใหม่
              TextFormField(
                controller: _newPasswordController,
                obscureText: _obscureNewPassword,
                decoration: InputDecoration(
                  labelText: 'ລະຫັດຜ່ານໃໝ່',
                  labelStyle: const TextStyle(color: AppColors.mainButton),
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.mainButton,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNewPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.mainButton.withOpacity(0.6),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureNewPassword = !_obscureNewPassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.mainButton),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ກະລຸນາໃສ່ລະຫັດຜ່ານໃໝ່';
                  }
                  if (value.length < 6) {
                    return 'ລະຫັດຜ່ານຕ້ອງມີຢ່າງນ້ອຍ 6 ຕົວອັກສອນ';
                  }
                  if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    return 'ລະຫັດຜ່ານຕ້ອງມີຕົວອັກສອນພິມໃຫຍ່';
                  }
                  if (!RegExp(r'[a-z]').hasMatch(value)) {
                    return 'ລະຫັດຜ່ານຕ້ອງມີຕົວອັກສອນພິມນ້ອຍ';
                  }
                  if (!RegExp(r'[0-9]').hasMatch(value)) {
                    return 'ລະຫັດຜ່ານຕ້ອງມີຕົວເລກ';
                  }
                  if (value == _currentPasswordController.text) {
                    return 'ລະຫັດຜ່ານໃໝ່ຕ້ອງຕ່າງຈາກລະຫັດຜ່ານເກົ່າ';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // ยืนยันรหัสผ่านใหม่
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'ຢືນຢັນລະຫັດຜ່ານໃໝ່',
                  labelStyle: const TextStyle(color: AppColors.mainButton),
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.mainButton,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.mainButton.withOpacity(0.6),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.mainButton),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ກະລຸນາຢືນຢັນລະຫັດຜ່ານໃໝ່';
                  }
                  if (value != _newPasswordController.text) {
                    return 'ລະຫັດຜ່ານຢືນຢັນບໍ່ຕົງກັນ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // ข้อกำหนดรหัสผ่าน (แสดงผลแบบ real-time)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.mainButton.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.mainButton.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ລະຫັດຜ່ານຕ້ອງ:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildPasswordRequirement(
                      'ຕ້ອງມີຢ່າງນ້ອຍ 6 ຕົວອັກສອນ',
                      _hasMinLength,
                    ),
                    const SizedBox(height: 8),
                    _buildPasswordRequirement(
                      'ຕ້ອງມີຕົວອັກສອນພິມໃຫຍ່ (A-Z)',
                      _hasUppercase,
                    ),
                    const SizedBox(height: 8),
                    _buildPasswordRequirement(
                      'ຕ້ອງມີຕົວອັກສອນພິມນ້ອຍ (a-z)',
                      _hasLowercase,
                    ),
                    const SizedBox(height: 8),
                    _buildPasswordRequirement(
                      'ຕ້ອງມີຕົວເລກ (0-9)',
                      _hasNumbers,
                    ),
                  ],
                ),
              ),

              // Spacer เพื่อดันปุ่มไปด้านล่าง
              const Spacer(),

              // ปุ่มเปลี่ยนรหัสผ่าน (อยู่ด้านล่างสุด)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainButton,
                    foregroundColor: AppColors.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'ປ່ຽນລະຫັດຜ່ານ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:knockout/Log/OTP_Page.dart';
import 'package:knockout/Widgets/AppColors.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeTerms = false;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text(
          'ສ້າງບັນຊີ',
          style: TextStyle(
            color: AppColors.backgroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.backgroundColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.iconSelect, AppColors.mainButton],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16),
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
                    _buildInputField(
                      'ຊື່ ແລະ ນາມສະກຸນ',
                      'ປ້ອນຊື່ ແລະ ນາມສະກຸນ',
                      _nameController,
                      Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ກາລຸນາປ້ອນຊື່';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    _buildInputField(
                      'ເບີໂທລະສັບ',
                      '020-XXXX-XXXX',
                      _phoneController,
                      Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ກາລຸນາປ້ອນເບີ';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    _buildInputField(
                      'ອີເມລ',
                      'example@email.com',
                      _emailController,
                      Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ກາລຸນາປ້ອນອີເມລ';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    _buildPasswordField(
                      'ລະຫັດຜ່ານ',
                      'ປ້ອນລະຫັດຜ່ານ',
                      _passwordController,
                      _obscurePassword,
                      () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ກາລະນຸນາປ້ອນລະຫັດຜ່ານ';
                        }
                        if (value.length < 6) {
                          return 'ລະຫັັັດຜ່ານຢ່າງໜ້ອຍ 6 ໂຕ';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    _buildPasswordField(
                      'ຢືນຢັນລະຫັດຜ່ານ',
                      'ປ້ອນລະຫັດອີກຄັ້ງ',
                      _confirmPasswordController,
                      _obscureConfirmPassword,
                      () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'ກາລຸນາຢືນຢັນລະຫັດຜ່ານ';
                        }
                        if (value != _passwordController.text) {
                          return 'ລະຫັດຜ່ານບໍ່ຕົງກັນ';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          value: _agreeTerms,
                          onChanged: (val) {
                            setState(() {
                              _agreeTerms = val ?? false;
                            });
                          },
                          fillColor: MaterialStateProperty.resolveWith<Color>((
                            states,
                          ) {
                            if (states.contains(MaterialState.selected)) {
                              return AppColors.mainButton;
                            }
                            return AppColors.borderColor;
                          }),
                          checkColor: AppColors.backgroundColor,
                        ),

                        Expanded(
                          child: Text(
                            'ຂອນຍອມຮັບ ຂໍ້ຕົກລົງ ແລະ ເງືອນໄຂການໃຊ້ງານ',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _agreeTerms
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OTPPage(
                                        phoneNumber: _phoneController.text,
                                        isRegister: true,
                                      ),
                                    ),
                                  );
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _agreeTerms
                              ? Color(0xFF3B82F6)
                              : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          'ສ້າງບັນຊີ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    String hint,
    TextEditingController controller,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Color(0xFF9CA3AF)),
            hintText: hint,
            filled: true,
            fillColor: Color(0xFFF9FAFB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFFD1D5DB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFF3B82F6), width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(
    String label,
    String hint,
    TextEditingController controller,
    bool obscureText,
    VoidCallback toggleVisibility, {
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Color(0xFFF9FAFB),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Color(0xFF9CA3AF),
              ),
              onPressed: toggleVisibility,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFFD1D5DB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFF3B82F6), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

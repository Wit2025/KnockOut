import 'package:flutter/material.dart';
import 'package:knockout/Widgets/AppColors.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'ຂໍ້ຕົກລົງ ແລະ ເງື່ອນໄຂການໃຊ້ງານ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.backgroundColor,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Terms and conditions content
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.borderColor.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('1. ການຍອມຮັບຂໍ້ຕົກລົງ'),
                      _buildSectionContent(
                        'ການໃຊ້ງານແອັບພລິເຄຊັນນີ້ຖືວ່າທ່ານໄດ້ອ່ານ ເຂົ້າໃຈ ແລະ ຍອມຮັບຂໍ້ຕົກລົງ ແລະ ເງື່ອນໄຂທັງໝົດທີ່ກ່າວໄວ້ໃນນີ້. ຖ້າທ່ານບໍ່ຍອມຮັບຂໍ້ຕົກລົງເຫຼົ່ານີ້, ກະລຸນາຢຸດການໃຊ້ງານແອັບພລິເຄຊັນນີ້.',
                      ),

                      _buildSectionTitle('2. ບໍລິການທີ່ໃຫ້'),
                      _buildSectionContent(
                        'ແອັບພລິເຄຊັນນີ້ໃຫ້ບໍລິການລ້າງໝວກກັນກະທົບແບບອັດຕະໂນມັດ. ບໍລິສັດຂອງພວກເຮົາສະຫນັບສະຫນູນການໃຊ້ງານຕາມຄວາມເໝາະສົມ ແລະ ຮັກສາສິດທິໃນການປ່ຽນແປງ ຫຼື ຢຸດບໍລິການໃດໆໄດ້ຕາມຄວາມເໝາະສົມ.',
                      ),

                      _buildSectionTitle('3. ສິດທິທາງຊັບສິນປັນຍາ'),
                      _buildSectionContent(
                        'ເນື້ອໃນທັງໝົດທີ່ປາກົດຢູ່ໃນແອັບພລິເຄຊັນນີ້, ລວມທັງຂໍ້ຄວາມ, ຮູບພາບ, ໂລໂກ້, ແລະ ການອອກແບບ, ແມ່ນຊັບສິນຂອງບໍລິສັດຂອງພວກເຮົາ ຫຼື ຄູ່ຄ້າຂອງພວກເຮົາ. ຫ້າມຄັດລອກ, ແຈກຢາຍ, ຫຼື ນຳໃຊ້ເນື້ອໃນເຫຼົ່ານີ້ໂດຍບໍ່ໄດ້ຮັບອະນຸຍາດ.',
                      ),

                      _buildSectionTitle('4. ການຄຸ້ມຄອງຂໍ້ມູນ'),
                      _buildSectionContent(
                        'ພວກເຮົາເຄົາລົບຄວາມເປັນສ່ວນຕົວຂອງທ່ານ. ຂໍ້ມູນສ່ວນຕົວທີ່ທ່ານໃຫ້ແກ່ພວກເຮົາຈະຖືກນຳໃຊ້ເພື່ອຈຸດປະສົງໃນການໃຫ້ບໍລິການ ແລະ ປັບປຸງປະສົບການການໃຊ້ງານ. ພວກເຮົາຈະບໍ່ແຈກຢາຍຂໍ້ມູນຂອງທ່ານໃຫ້ແກ່ພາກສ່ວນທີສາມໂດຍບໍ່ໄດ້ຮັບອະນຸຍາດ.',
                      ),

                      _buildSectionTitle('5. ຂໍ້ມູນທີ່ຜູ້ໃຊ້ຕ້ອງໃຫ້'),
                      _buildSectionContent(
                        'ເພື່ອໃຊ້ງານແອັບພລິເຄຊັນນີ້, ທ່ານອາດຈະຖືກຖາມເຖິງຂໍ້ມູນສ່ວນຕົວບາງຢ່າງ. ທ່ານຕ້ອງໃຫ້ຂໍ້ມູນທີ່ຖືກຕ້ອງ, ທັນສະໄໝ, ແລະ ເຕັມຮູບແບບ. ຖ້າຂໍ້ມູນຂອງທ່ານມີການປ່ຽນແປງ, ທ່ານຕ້ອງແຈ້ງໃຫ້ພວກເຮົາຮູ້ໃນທັນໃດ.',
                      ),

                      _buildSectionTitle('6. ການຍົກເວັ້ນຄວາມຮັບຜິດຊອບ'),
                      _buildSectionContent(
                        'ແອັບພລິເຄຊັນນີ້ໃຫ້ບໍລິການໃນສະພາບ "ດັ່ງທີ່ເປັນຢູ່" ແລະ "ຕາມທີ່ມີຢູ່". ພວກເຮົາບໍ່ຮັບປະກັນວ່າບໍລິການຈະບໍ່ມີຂໍ້ຜິດພາດ ຫຼື ຕໍ່ເນື່ອງ. ພວກເຮົາຈະບໍ່ຮັບຜິດຊອບຕໍ່ຄວາມເສຍຫາຍໃດໆທີ່ເກີດຈາກການໃຊ້ງານແອັບພລິເຄຊັນນີ້.',
                      ),

                      _buildSectionTitle('7. ການປ່ຽນແປງຂໍ້ຕົກລົງ'),
                      _buildSectionContent(
                        'ພວກເຮົາສະຫງວນສິດໃນການປ່ຽນແປງຂໍ້ຕົກລົງ ແລະ ເງື່ອນໄຂເຫຼົ່ານີ້ໄດ້ຕາມຄວາມເໝາະສົມ. ການປ່ຽນແປງຈະມີຜົນບັງຄັບໃຊ້ທັນທີເມື່ອເຜີຍແຜ່ໃນແອັບພລິເຄຊັນ. ການໃຊ້ງານຕໍ່ເນື່ອງຫຼັງຈາກມີການປ່ຽນແປງຖືວ່າທ່ານຍອມຮັບຂໍ້ຕົກລົງໃໝ່.',
                      ),

                      _buildSectionTitle('8. ການຢຸດໃຊ້ງານ'),
                      _buildSectionContent(
                        'ພວກເຮົາສະຫງວນສິດທີ່ຈະຢຸດ ຫຼື ກີດຂວາງການເຂົ້າເຖິງບໍລິການຂອງທ່ານໂດຍບໍ່ຕ້ອງແຈ້ງເຕືອນລ່ວງໜ້າ ຖ້າພົບວ່າທ່ານລະເມີດຂໍ້ຕົກລົງເຫຼົ່ານີ້. ນອກຈາກນີ້, ພວກເຮົາອາດຈະຢຸດບໍລິການໃດໆໄດ້ຕາມຄວາມເໝາະສົມ.',
                      ),

                      _buildSectionTitle('9. ກົດໝາຍທີ່ກ່ຽວຂ້ອງ'),
                      _buildSectionContent(
                        'ຂໍ້ຕົກລົງເຫຼົ່ານີ້ຈະຖືກກຳນົດຕາມກົດໝາຍຂອງ ສປປ ລາວ. ການໃຊ້ງານແອັບພລິເຄຊັນນີ້ຖືວ່າທ່ານຍອມຮັບອຳນາດການພິຈາລະນາຂອງສານໃນ ສປປ ລາວໃນກໍລະນີມີຂໍ້ຂັດແຍ່ງ.',
                      ),

                      _buildSectionTitle('10. ຕິດຕໍ່ພວກເຮົາ'),
                      _buildSectionContent(
                        'ຖ້າທ່ານມີຄຳຖາມ ຫຼື ຄວາມກັງວົນໃຈກ່ຽວກັບຂໍ້ຕົກລົງເຫຼົ່ານີ້, ກະລຸນາຕິດຕໍ່ພວກເຮົາຜ່ານ:\nເບີໂທ: +856 20 1234 5678\nອີເມວ: support@knockoutlao.com\nທີ່ຢູ່: ບ້ານສີຫະໄຊ, ເມືອງຈັນທະບູລີ, ນະຄອນຫຼວງວຽງຈັນ, ລາວ',
                      ),

                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.mainButton.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.mainButton.withOpacity(0.2),
                          ),
                        ),
                        child: Text(
                          'ການໃຊ້ງານແອັບພລິເຄຊັນນີ້ຖືວ່າທ່ານໄດ້ອ່ານ ແລະ ຍອມຮັບຂໍ້ຕົກລົງ ແລະ ເງື່ອນໄຂທັງໝົດຂ້າງເທິງນີ້.',
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: AppColors.textColor.withOpacity(0.7),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.mainButton,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 15,
          height: 1.5,
          color: AppColors.textColor.withOpacity(0.8),
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}

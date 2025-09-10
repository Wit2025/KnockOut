import 'package:flutter/material.dart';
import 'package:knockout/Widgets/AppColors.dart';

class FAQTab extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      'question': 'ໃຊ້ເວລາໃນການລ້າງໝວກນານແທ້ໃດ?',
      'answer': 'ຈະໃຊ້ເວລາລ້າງຕໍ່ຄັ້ງ 8 ນາທີ',
    },
    {
      'question': 'ສາມາດຍົກເລີກການຈອງໄດ້ບໍ?',
      'answer':
          'ສາມາດຍົກເລີກການຈອງໄດ້ກ່ອນເວລານັດ 2 ຊົ່ວໂມງ ຖ້າຍົກເລີກຫຼັງຈາກນັ້ນຈະບໍ່ໄດ້ຮັບເງິນຄືນ',
    },
    {
      'question': 'ມີບໍລິການຮັບສົ່ງໝວກບໍ?',
      'answer': 'ຂະນະນີ້ຍັງບໍ່ມີບໍລິການຮັບສົ່ງໝວກ ຕ້ອງນຳມາທີ່ຮ້ານດ້ວຍຕົນເອງ',
    },
    {
      'question': 'ລາຄາການລ້າງໝວກເທົ່າໃດ?',
      'answer':
          'ລ້າງທຳມະດາ 10,000 ກີບ ລ້າງ Premium 20,000 ກີບ ຂ້າເຊື້ອ 25,000 ກີບ ລ້າງ + ອົບແຫ້ງ 30,000 ກີບ',
    },
    {
      'question': 'ຮັບລ້າງໝວກທຸກຍີ່ຫໍ້ບໍ?',
      'answer':
          'ຮັບລ້າງໝວກກັນນ໊ອກທຸກຍີ່ຫໍ້ ທຸກລຸ່ນ ແຕ່ຈະຕ້ອງກວດກາສະພາບກ່ອນຮັບບໍລິການ',
    },
    {
      'question': 'ໄດ້ແຕ້ມສະສົມແນວໃດ?',
      'answer':
          'ໃຊ້ບໍລິການຄັ້ງລະ 10,000 ກີບ ຈະໄດ້ 10 ແຕ້ມ ສາມາດນຳແຕ້ມມາແລກສ່ວນຫຼຸດຫຼືຂອງລາງວັນໄດ້',
    },
    {
      'question': 'ຫາກໝວກຊຳຣຸດລະຫວ່າງລ້າງຈະເປັນແນວໃດ?',
      'answer':
          'ຫາກເກີດຄວາມເສຍຫາຍຈາກຄວາມປະມາດຂອງທາງຮ້ານ ພວກເຮົາຈະຮັບຜິດຊອບຄ່າເສຍຫາຍຕາມລາຄາຕະຫຼາດ',
    },
    {
      'question': 'ມີການຮັບປະກັນບໍ?',
      'answer': 'ຮັບປະກັນຄຸນນະພາບການລ້າງ 7 ວັນ ຫາກບໍ່ພໍໃຈສາມາດນຳມາລ້າງໃໝ່ຟຣີ',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(24),
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        return _buildFAQItem(faqs[index]);
      },
    );
  }

  Widget _buildFAQItem(Map<String, String> faq) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.textColor.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          faq['question']!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              faq['answer']!,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.iconUnselect,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

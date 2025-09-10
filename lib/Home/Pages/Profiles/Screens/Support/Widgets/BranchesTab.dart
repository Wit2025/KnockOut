import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:knockout/Widgets/AppColors.dart';

class BranchesTab extends StatelessWidget {
  final List<Map<String, dynamic>> branches = [
    {
      'name': 'ສາຂາ ຕານມີໄຊ',
      'address': 'ບ້ານ ຕານມີໄຊ ເມືອງໄຊທານີ ນະຄອນລວງວຽງຈັນ',
      'phone': '02097471681',
      'hours': 'ເວລາເປີດ: 09:00 - 18:00 ນາທີ',
      'lat': 102.7563,
      'lng': 100.5018,
    },
    {
      'name': 'ສາຂາ ດົງປາລານ',
      'address': 'ບ້ານ ດົງປາລານ ເມືອງ ຈັນທະບູລີ ນະຄອນລວງວຽງຈັນ',
      'phone': '02097471681',
      'hours': 'ເວລາເປີດ: 09:00 - 18:00 ນາທີ',
      'lat': 102.8563,
      'lng': 100.6018,
    },
    {
      'name': 'ສາຂາ ສາຍລົມ',
      'address': 'ບ້ານ ສາຍລົມ ເມືອງຈັນທະບູລີ ນະຄອນລວງວຽງຈັນ',
      'phone': '02097471681',
      'hours': 'ເວລາເປີດ: 09:00 - 18:00 ນາທີ',
      'lat': 102.6563,
      'lng': 100.6018,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contact Methods
          Row(
            children: [
              Expanded(
                child: _buildContactCard(
                  'ໂທລະສັບ',
                  '021-98745645',
                  Icons.phone,
                  AppColors.iconSelect,
                  () {
                    // Make phone call
                  },
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildContactCard(
                  'LINE',
                  '@helmetclean',
                  Icons.chat_bubble_outline,
                  AppColors.success,
                  () {
                    // Open LINE
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 32),

          // Branches List
          Text(
            'ສາຂາທັງໝົດ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          SizedBox(height: 16),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: branches.length,
            itemBuilder: (context, index) {
              return _buildBranchCard(branches[index], context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.textColor.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            SizedBox(height: 12),
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
              style: TextStyle(fontSize: 14, color: AppColors.iconUnselect),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBranchCard(Map<String, dynamic> branch, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            branch['name'],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          SizedBox(height: 12),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.location_on, color: AppColors.iconUnselect, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  branch['address'],
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.iconUnselect,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),

          Row(
            children: [
              Icon(Icons.phone, color: AppColors.iconUnselect, size: 18),
              SizedBox(width: 8),
              Text(
                branch['phone'],
                style: TextStyle(fontSize: 14, color: AppColors.iconUnselect),
              ),
            ],
          ),
          SizedBox(height: 8),

          Row(
            children: [
              Icon(Icons.access_time, color: AppColors.iconUnselect, size: 18),
              SizedBox(width: 8),
              Text(
                branch['hours'],
                style: TextStyle(fontSize: 14, color: AppColors.iconUnselect),
              ),
            ],
          ),
          SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: branch['phone']));
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('ສຳເນົາເບີໂທແລ້ວ')));
                  },
                  icon: Icon(Icons.phone, size: 18),
                  label: Text('ໂທ'),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.mainButton),
                    foregroundColor: AppColors.mainButton,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Open Google Maps
                  },
                  icon: Icon(Icons.directions, size: 18),
                  label: Text('ເສັ້ນທາງ'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainButton,
                    foregroundColor: AppColors.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

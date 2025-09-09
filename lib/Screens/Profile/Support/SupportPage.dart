import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:knockout/Widgets/AppColors.dart';

class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _messageController = TextEditingController();

  // เพิ่ม List สำหรับเก็บข้อความแชท
  final List<ChatMessage> _chatMessages = [
    ChatMessage(
      message: 'ສະບາຍດີ! ມີຫຍັງໃຫ້ຊ່ວຍບໍ່?',
      isMe: false,
      time: '14:30',
    ),
    ChatMessage(
      message: 'ຢາກຖາມເລື່ອງລາຄາການລ້າງໝວກກັນນ໋ອກ',
      isMe: true,
      time: '14:32',
    ),
    ChatMessage(
      message:
          'ໂດຍ ການລ້າງທຳມະດາ 10,000 ກີບ ລ້າງ Premium 20,000 ກີບ ຂ້າເຊື້ອ 25,000 ກີບ ລ້າງ + ອົບແຫ້ງ 30,000 ກີບ',
      isMe: false,
      time: '14:33',
    ),
  ];

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
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // ฟังก์ชันส่งข้อความ
  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _chatMessages.add(
          ChatMessage(
            message: _messageController.text,
            isMe: true,
            time: _getCurrentTime(),
          ),
        );
        _messageController.clear();
      });

      // จำลองการตอบกลับจาก support (optional)
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _chatMessages.add(
            ChatMessage(
              message: 'ຂອບໃຈສຳລັບຂໍ້ຄວາມຂອງທ່ານ. ພວກເຮົາຈະຕິດຕໍ່ທ່ານໃນໄວໆນີ້.',
              isMe: false,
              time: _getCurrentTime(),
            ),
          );
        });
      });
    }
  }

  // ฟังก์ชันดึงเวลาปัจจุบัน
  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
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
          labelColor: AppColors.backgroundColor,
          unselectedLabelColor: AppColors.backgroundColor,
          indicatorColor: AppColors.backgroundColor,
          tabs: [
            Tab(text: 'ສາຂາ'),
            Tab(text: 'ແຊທ'),
            Tab(text: 'FAQ'),
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [_buildBranchesTab(), _buildChatTab(), _buildFAQTab()],
      ),
    );
  }

  Widget _buildBranchesTab() {
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
              return _buildBranchCard(branches[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChatTab() {
    return Column(
      children: [
        // Chat Header
        Container(
          padding: EdgeInsets.all(20),
          color: AppColors.backgroundColor,
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.subButton,
                child: Icon(
                  Icons.support_agent,
                  color: AppColors.backgroundColor,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Knock Out Support',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColor,
                      ),
                    ),
                    Text(
                      'ອອນລາຍ',
                      style: TextStyle(fontSize: 14, color: AppColors.success),
                    ),
                  ],
                ),
              ),
              Icon(Icons.more_vert, color: AppColors.iconUnselect),
            ],
          ),
        ),

        // Chat Messages
        Expanded(
          child: Container(
            color: AppColors.backgroundColor,
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                final message = _chatMessages[index];
                return _buildChatMessage(
                  message.message,
                  message.isMe,
                  message.time,
                );
              },
            ),
          ),
        ),

        // Message Input
        Container(
          padding: EdgeInsets.all(16),
          color: AppColors.backgroundColor,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.backgroundColor),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: 'ພິມຂໍ້ຄວາມ...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.attach_file,
                          color: AppColors.iconUnselect,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.mainButton,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: IconButton(
                  icon: Icon(Icons.send, color: AppColors.backgroundColor),
                  onPressed: _sendMessage,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFAQTab() {
    return ListView.builder(
      padding: EdgeInsets.all(24),
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        return _buildFAQItem(faqs[index]);
      },
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
              color: Colors.black.withOpacity(0.1),
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

  Widget _buildBranchCard(Map<String, dynamic> branch) {
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

  Widget _buildChatMessage(String message, bool isMe, String time) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.mainButton,
              child: Icon(
                Icons.support_agent,
                color: AppColors.backgroundColor,
                size: 16,
              ),
            ),
            SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isMe ? AppColors.mainButton : AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 14,
                      color: isMe
                          ? AppColors.backgroundColor
                          : AppColors.textColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      color: isMe
                          ? AppColors.backgroundColor.withOpacity(0.7)
                          : AppColors.textColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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

// เพิ่มคลาสสำหรับเก็บข้อมูลข้อความแชท
class ChatMessage {
  final String message;
  final bool isMe;
  final String time;

  ChatMessage({required this.message, required this.isMe, required this.time});
}

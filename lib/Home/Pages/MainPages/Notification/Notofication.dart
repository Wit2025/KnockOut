import 'package:flutter/material.dart';
import 'package:knockout/Widgets/AppColors.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // ข้อมูลตัวอย่างสำหรับการแจ้งเตือน
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'ການຊຳລະສຳເລັດ',
      'message': 'ທ່ານໄດ້ຊຳລະຄ່າບໍລິການລ້າງຫມວກ 10,000 ກີບ ສຳເລັດແລ້ວ',
      'time': 'ມື້ນີ້ 10:30',
      'isRead': false,
      'type': 'payment',
      'icon': Icons.payment,
      'color': AppColors.mainButton,
    },
    {
      'title': 'ຂໍ້ສະເໜີພິເສດ',
      'message': 'ສຳລັບສະມາຊິກໃໝ່ ລົງທະບຽນວັນນີ້ ຫຼຸດ 20%',
      'time': 'ມື້ນີ້ 09:15',
      'isRead': false,
      'type': 'promotion',
      'icon': Icons.local_offer,
      'color': AppColors.mainButton,
    },
    {
      'title': 'ແຈ້ງເຕືອນການໃຊ້ງານ',
      'message': 'ບໍລິການຂອງທ່ານຈະໝົດອາຍຸໃນ 3 ວັນ ໃຫ້ເຕີມເງິນໄວ້ກ່ອນນັ້ນ',
      'time': 'ວານນີ້ 14:20',
      'isRead': true,
      'type': 'alert',
      'icon': Icons.notifications_active,
      'color': AppColors.mainButton,
    },
    {
      'title': 'ຄະແນນສະສົມ',
      'message':
          'ທ່ານມີຄະແນນສະສົມ 35 ຄະແນນ ໃຊ້ຫມົດ 50 ຄະແນນສາມາດແລກບໍລິການຟຣີໄດ້',
      'time': 'ວານນີ້ 11:05',
      'isRead': true,
      'type': 'points',
      'icon': Icons.star,
      'color': AppColors.mainButton,
    },
    {
      'title': 'ອັບເດດແອັບ',
      'message': 'ມີແອັບເວີຊັ່ນໃໝ່ ພ້ອມຄຸນສົມບັດໃໝ່ ອັບເດດໄດ້ແລ້ວມື້ນີ້',
      'time': '2 ວັນກ່ອນ',
      'isRead': true,
      'type': 'update',
      'icon': Icons.system_update,
      'color': AppColors.mainButton,
    },
  ];

  // เพิ่ม state สำหรับเก็บประเภทที่เลือก
  String _selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    // กรองการแจ้งเตือนตามประเภทที่เลือก
    final filteredNotifications = _notifications.where((notification) {
      if (_selectedFilter == 'all') return true;
      if (_selectedFilter == 'unread') return !notification['isRead'];
      if (_selectedFilter == 'payment')
        return notification['type'] == 'payment';
      if (_selectedFilter == 'promotion')
        return notification['type'] == 'promotion';
      if (_selectedFilter == 'alert')
        return notification['type'] == 'alert' ||
            notification['type'] == 'points' ||
            notification['type'] == 'update';
      return false;
    }).toList();

    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.backgroundColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'ການແຈ້ງເຕືອນ',
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
        actions: [
          TextButton(
            onPressed: _markAllAsRead,
            child: Text(
              'ອ່ານທັງໝົດ',
              style: TextStyle(
                color: AppColors.backgroundColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('ທັງໝົດ', 'all'),
                  SizedBox(width: 8),
                  _buildFilterChip('ຍັງບໍ່ອ່ານ', 'unread'),
                  SizedBox(width: 8),
                  _buildFilterChip('ການຊຳລະ', 'payment'),
                  SizedBox(width: 8),
                  _buildFilterChip('ຂໍ້ສະເໜີ', 'promotion'),
                  SizedBox(width: 8),
                  _buildFilterChip('ແຈ້ງເຕືອນ', 'alert'),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),

          // Notifications List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 16),
              itemCount: filteredNotifications.length,
              itemBuilder: (context, index) {
                final notification = filteredNotifications[index];
                final originalIndex = _notifications.indexWhere(
                  (n) => n == notification,
                );
                return _buildNotificationCard(notification, originalIndex);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedFilter == value;
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Color(0xFF3B82F6),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = value;
        });
      },
      backgroundColor: Colors.white,
      selectedColor: Color(0xFF3B82F6),
      checkmarkColor: Colors.white,
      shape: StadiumBorder(side: BorderSide(color: Color(0xFF3B82F6))),
      elevation: 0,
      showCheckmark: true,
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification, int index) {
    return Dismissible(
      key: Key('notification_$index'),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: Colors.white, size: 30),
      ),
      onDismissed: (direction) {
        setState(() {
          _notifications.removeAt(index);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ລຶບການແຈ້ງເຕືອນແລ້ວ'),
            backgroundColor: Colors.red,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Unread indicator
            if (!notification['isRead'])
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 4,
                  decoration: BoxDecoration(
                    color: Color(0xFF3B82F6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                ),
              ),

            ListTile(
              contentPadding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 12,
                bottom: 12,
              ),
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: notification['color'].withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  notification['icon'],
                  color: notification['color'],
                  size: 26,
                ),
              ),
              title: Text(
                notification['title'],
                style: TextStyle(
                  fontWeight: notification['isRead']
                      ? FontWeight.w500
                      : FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF1F2937),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text(
                    notification['message'],
                    style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Text(
                    notification['time'],
                    style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                  ),
                ],
              ),
              trailing: !notification['isRead']
                  ? Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Color(0xFF3B82F6),
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
              onTap: () {
                setState(() {
                  _notifications[index]['isRead'] = true;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['isRead'] = true;
      }
    });
  }
}

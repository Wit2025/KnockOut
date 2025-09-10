import 'package:flutter/material.dart';
import 'package:knockout/Widgets/AppColors.dart';

class NotificationController {
  final ValueNotifier<List<Map<String, dynamic>>> notificationsNotifier =
      ValueNotifier<List<Map<String, dynamic>>>([]);

  String _selectedFilter = 'all';
  String get selectedFilter => _selectedFilter;

  List<Map<String, dynamic>> get filteredNotifications {
    return notificationsNotifier.value.where((notification) {
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
  }

  NotificationController() {
    // Initialize with sample data
    notificationsNotifier.value = [
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
  }

  void setFilter(String filter) {
    _selectedFilter = filter;
    // Create a new list to trigger the ValueNotifier update
    notificationsNotifier.value = List.from(notificationsNotifier.value);
  }

  void markAsRead(int index) {
    final List<Map<String, dynamic>> updatedNotifications = List.from(
      notificationsNotifier.value,
    );
    updatedNotifications[index]['isRead'] = true;
    notificationsNotifier.value = updatedNotifications;
  }

  void markAllAsRead() {
    final List<Map<String, dynamic>> updatedNotifications =
        notificationsNotifier.value.map((notification) {
          return {...notification, 'isRead': true};
        }).toList();
    notificationsNotifier.value = updatedNotifications;
  }

  void removeNotification(int index) {
    final List<Map<String, dynamic>> updatedNotifications = List.from(
      notificationsNotifier.value,
    );
    updatedNotifications.removeAt(index);
    notificationsNotifier.value = updatedNotifications;
  }
}

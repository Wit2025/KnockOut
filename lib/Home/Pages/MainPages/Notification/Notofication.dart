import 'package:flutter/material.dart';
import 'package:knockout/Home/Pages/MainPages/Notification/Widgets/NotificationController.dart';
import 'package:knockout/Home/Pages/MainPages/Notification/Widgets/NotificationFilterChips.dart';
import 'package:knockout/Home/Pages/MainPages/Notification/Widgets/NotificationList.dart';
import 'package:knockout/Widgets/AppColors.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotificationController _controller = NotificationController();

  @override
  Widget build(BuildContext context) {
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
            onPressed: _controller.markAllAsRead,
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
      body: ValueListenableBuilder(
        valueListenable: _controller.notificationsNotifier,
        builder: (context, _, __) {
          return Column(
            children: [
              // Filter Chips
              NotificationFilterChips(
                selectedFilter: _controller.selectedFilter,
                onFilterChanged: _controller.setFilter,
              ),
              SizedBox(height: 8),

              // Notifications List
              Expanded(
                child: NotificationList(
                  notifications: _controller.filteredNotifications,
                  onDismiss: _controller.removeNotification,
                  onTap: _controller.markAsRead,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

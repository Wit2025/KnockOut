import 'package:flutter/material.dart';

class NotificationFilterChips extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const NotificationFilterChips({
    Key? key,
    required this.selectedFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = selectedFilter == value;
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
        onFilterChanged(value);
      },
      backgroundColor: Colors.white,
      selectedColor: Color(0xFF3B82F6),
      checkmarkColor: Colors.white,
      shape: StadiumBorder(side: BorderSide(color: Color(0xFF3B82F6))),
      elevation: 0,
      showCheckmark: true,
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:knockout/Home/Pages/TrackingStatus/Widgets/BubbleProgressCircle.dart';
import 'package:knockout/Widgets/AppColors.dart';
import 'dart:async';
import 'Widgets/ProcessStepsContainer.dart'; // นำเข้า Widget ที่แยกออกมา

class RealtimeTrackingPage extends StatefulWidget {
  final int? processTime;

  const RealtimeTrackingPage({super.key, this.processTime});

  @override
  _RealtimeTrackingPageState createState() => _RealtimeTrackingPageState();
}

class _RealtimeTrackingPageState extends State<RealtimeTrackingPage> {
  double progress = 0.0;
  int remainingTime = 0;
  Timer? _timer;
  bool isProcessing = false;
  int totalTime = 0;
  int elapsedTime = 0;

  @override
  void initState() {
    super.initState();

    // ถ้ามีการส่งเวลามา ให้เริ่มนับเวลา
    if (widget.processTime != null && widget.processTime! > 0) {
      totalTime = widget.processTime! * 60;
      remainingTime = totalTime;
      isProcessing = true;
      _startProgress();
    }
  }

  void _startProgress() {
    if (!isProcessing || totalTime <= 0) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      setState(() {
        elapsedTime++;
        remainingTime = totalTime - elapsedTime;
        progress = elapsedTime / totalTime;
      });

      // ถ้าเสร็จแล้ว
      if (elapsedTime >= totalTime) {
        timer.cancel();
        _showCompletionDialog();
      }
    });
  }

  void _showCompletionDialog() {
    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            backgroundColor: AppColors.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 80,
                    color: AppColors.mainButton,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'ສຳເລັດສົມບູນແລ້ວ!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'ທ່ານສາມາດເອົາໝວກຂອງທ່ານອອກໄດ້ແລ້ວ',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainButton,
                      foregroundColor: AppColors.backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home',
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Text("ຕົກລົງ"),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar:
          isProcessing // แสดง AppBar เฉพาะเมื่อกำลังซักผ้า
          ? AppBar(
              title: const Text(
                'ສະຖານະການເຮັດວຽກ',
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
            )
          : null,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isProcessing ? 'ກຳລັງລ້າງ...' : 'ບໍ່ມີວຽກທີ່ກຳລັງດຳເນີນການ',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                if (isProcessing) ...[
                  const SizedBox(height: 30),

                  // Enhanced Blue Bubble Progress Circle
                  BubbleProgressCircle(
                    progress: progress,
                    remainingTime: _formatTime(remainingTime),
                  ),

                  const SizedBox(height: 80),

                  // ใช้ ProcessStepsContainer ที่แยกออกมา
                  ProcessStepsContainer(progress: progress),
                ] else ...[
                  const SizedBox(height: 30),
                  const Text(
                    'ບໍ່ມີວຽກທີ່ກຳລັງດຳເນີນການ',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.borderColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

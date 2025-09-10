import 'package:flutter/material.dart';
import 'package:knockout/Home/Pages/ScanQR/Widgets/CameraErrorWidget.dart';
import 'package:knockout/Home/Pages/ScanQR/Widgets/CameraLoadingWidget.dart';
import 'package:knockout/Home/Pages/ScanQR/Widgets/ScannerOverlay.dart';
import 'package:knockout/Widgets/AppColors.dart';
import 'package:knockout/Home/Pages/ScanQR/SelectMenu/ServiceSelectionPage.dart';
import 'package:knockout/Home/Pages/ScanQR/SelectMenu/ConfirmOrder/ConfirmOrderPage.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  final String? selectedService;
  final double? selectedPrice;

  const QRScannerScreen({super.key, this.selectedService, this.selectedPrice});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  MobileScannerController? cameraController;
  bool isScanCompleted = false;
  bool _torchEnabled = false;
  CameraFacing _cameraFacing = CameraFacing.back;
  bool _cameraInitialized = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      cameraController = MobileScannerController();
      setState(() {
        _cameraInitialized = true;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'ไม่สามารถเริ่มต้นกล้องได้: $e';
      });
    }
  }

  // ฟังก์ชันสำหรับสลับไฟฉาย
  Future<void> _toggleTorch() async {
    if (cameraController == null) return;

    try {
      await cameraController!.toggleTorch();
      setState(() {
        _torchEnabled = !_torchEnabled;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'ไม่สามารถเปิดไฟฉายได้: $e';
      });
    }
  }

  // ฟังก์ชันสำหรับสลับกล้อง
  Future<void> _switchCamera() async {
    if (cameraController == null) return;

    try {
      await cameraController!.switchCamera();
      setState(() {
        _cameraFacing = _cameraFacing == CameraFacing.back
            ? CameraFacing.front
            : CameraFacing.back;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'ไม่สามารถสลับกล้องได้: $e';
      });
    }
  }

  void _goToNextPage() {
    // If a service was selected from HomePage, go directly to OrderSummaryPage
    if (widget.selectedService != null && widget.selectedPrice != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OrderSummaryPage(
            serviceData: {
              'service': widget.selectedService,
              'time': 8,
              'price': widget.selectedPrice,
            },
          ),
        ),
      );
    } else {
      // Otherwise go to ServiceSelectionPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ServiceSelectionPage(selectedService: widget.selectedService),
        ),
      );
    }
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage.isNotEmpty) {
      return CameraErrorWidget(
        errorMessage: _errorMessage,
        onBackPressed: () => Navigator.pop(context),
      );
    }

    if (!_cameraInitialized) {
      return const CameraLoadingWidget();
    }

    return Scaffold(
      backgroundColor: AppColors.textColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.backgroundColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'ສະແກນ QR Code',
          style: TextStyle(color: AppColors.backgroundColor),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          // ปุ่มเปิด/ปิดไฟฉาย
          IconButton(
            color: AppColors.backgroundColor,
            icon: _torchEnabled
                ? const Icon(Icons.flash_on, color: AppColors.warning)
                : const Icon(Icons.flash_off, color: AppColors.borderColor),
            iconSize: 32.0,
            onPressed: _toggleTorch,
          ),
          // ปุ่มสลับกล้อง
          IconButton(
            color: AppColors.backgroundColor,
            icon: _cameraFacing == CameraFacing.front
                ? const Icon(Icons.camera_front)
                : const Icon(Icons.camera_rear),
            iconSize: 32.0,
            onPressed: _switchCamera,
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController!,
            onDetect: (capture) {
              if (!isScanCompleted) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  if (barcode.rawValue != null) {
                    isScanCompleted = true;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('ສະແກນສຳເລັດ: ${barcode.rawValue}'),
                        backgroundColor: AppColors.success,
                      ),
                    );

                    Future.delayed(const Duration(seconds: 1), () {
                      _goToNextPage();
                    });

                    break;
                  }
                }
              }
            },
          ),
          // Overlay สำหรับช่วยเล็ง
          const ScannerOverlay(),

          // ข้อความแนะนำ
          Positioned(
            top: 20,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.qr_code_scanner, color: Colors.white, size: 32),
                  SizedBox(height: 8),
                  Text(
                    'ວາງ QR Code ໃນຂອບ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'ເພື່ອເຊື່ອກັບຕູ້ລ້າງ',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // ปุ่มข้ามไปหน้าบริการ (ทดสอบ)
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                onPressed: _goToNextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainButton,
                  foregroundColor: AppColors.backgroundColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(Icons.arrow_circle_right_outlined, size: 25),
                label: const Text('ຕໍ່ໄປ', style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

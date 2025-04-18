import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeScannerBottomSheet extends StatelessWidget {
  final MobileScannerController cameraController;

  const QrCodeScannerBottomSheet({super.key, required this.cameraController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Scan QR Code',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: MobileScanner(
                controller: cameraController,
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  if (barcodes.isNotEmpty) {
                    final String? code = barcodes.first.rawValue;
                    Navigator.pop(context, code); // Return the scanned code
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Scanning...', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
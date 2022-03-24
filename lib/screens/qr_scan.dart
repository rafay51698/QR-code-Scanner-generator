import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final qrkey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    // TODO: implement reassemble
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            QRView(
              key: qrkey,
              onQRViewCreated: onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderLength: 25,
                borderRadius: 10,
                borderWidth: 10,
                borderColor: Colors.blue,
                cutOutSize: MediaQuery.of(context).size.height * 0.5,
              ),
            ),
            Align(
              alignment: Alignment(0, 0.9),
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(20),
                height: 100,
                width: double.infinity,
                child: Text(
                  barcode != null ? 'Result: ${barcode!.code}' : 'Scan Qr code',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
      });
    });
  }
}
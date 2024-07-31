import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({Key? key, required this.redirect}) : super(key: key);

  final String redirect;

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  bool qrCodeDetected = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const SizedBox(),
        leadingWidth: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.adaptive.arrow_back,
                color: Colors.white,
                size: 24.sp,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.flash_on_rounded,
                color: Colors.white,
                size: 24.sp,
              ),
              onPressed: () {
                controller?.toggleFlash();
                // Navigator.of(context).pushNamed(
                //   widget.redirect,
                //   arguments: '4db12128-d1ea-44f7-8dfc-44f07fcaaf94',
                // );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
                _buildScannerOverlay(),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.20,
                  child: const FittedBox(
                    child: Text(
                      'Align the QR code within the frame',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (qrCodeDetected) {
        return;
      }

      qrCodeDetected = true;

      final qrCode = Uri.parse(scanData.code!).queryParameters['c'];

      Navigator.of(context).pushNamed(
        widget.redirect,
        arguments: qrCode,
      );
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget _buildScannerOverlay() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              top: 0,
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.25,
              child: Container(color: Colors.black45),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.25,
              child: Container(color: Colors.black45),
            ),
            Positioned(
              left: 0,
              top: constraints.maxHeight * 0.25,
              width: constraints.maxWidth * 0.15,
              height: constraints.maxHeight * 0.5,
              child: Container(color: Colors.black45),
            ),
            Positioned(
              right: 0,
              top: constraints.maxHeight * 0.25,
              width: constraints.maxWidth * 0.15,
              height: constraints.maxHeight * 0.5,
              child: Container(color: Colors.black45),
            ),
            Positioned(
              left: 0,
              top: constraints.maxHeight * 0.25,
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.5,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 2.w, color: Colors.white),
                    bottom: BorderSide(width: 2.w, color: Colors.white),
                    left: BorderSide(width: 2.w, color: Colors.white),
                    right: BorderSide(width: 2.w, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

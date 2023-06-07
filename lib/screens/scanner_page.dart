import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  // final GlobalKey _globalKey = GlobalKey(); 
  // QRViewController? controller;
  // Barcode? result;

  // void qr(QRViewController controller ){
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((event){
  //     setState((){
  //       result = event;
  //     });
  //   });
  // }

  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

  @override 
  void dispose(){
    controller?.dispose();
    super.dispose();
  }

  // @override
  // void reassemble() async {
  //   super.reassemble();
  //   if(Platform.isAndroid){
  //     await controller!.pauseCamera();
  //   }
  //   controller!.resumeCamera();
  // }


  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child:
    //    Column(
    //      children: [
    //       Container(
    //       width: 200, 
    //       height: 200,
    //        child: QRView(
    //          key: _globalKey, 
    //          onQRViewCreated: qr
    //        ),
    //      ),
    //       Container(
    //         child:(result != null) ? Text('${result!.code}'): Text('Scan a code'),
    //       ),
    //      ]
    //    ),

      
    // );
    return Stack(
      alignment: Alignment.center,
      children: [
        buildQrView(context),
        Positioned(bottom: 10, child: buildResult()),
      ],
    );
  }
  Widget buildQrView (BuildContext context)=> QRView(
    key: qrKey, 
    onQRViewCreated: onQRViewCreated,
    overlay: QrScannerOverlayShape(
      borderColor: Theme.of(context).accentColor,
      borderWidth: 10,
      borderRadius: 10,
      borderLength: 20,
      cutOutSize: MediaQuery.of(context).size.width*0.5,

    ),
  );
  void onQRViewCreated(QRViewController controller){
    setState(()=> this.controller = controller);
    controller.scannedDataStream
      .listen((barcode)=> setState(()=> this.barcode = barcode));
  }
  
  Widget buildResult()  => Container(
    padding: EdgeInsets.all(12),
    decoration:BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white24,
    ),
    child: Text(
      barcode != null ? 'Result: ${barcode!.code}': 'Scan a code',
      maxLines: 3
    ),
  );
    
  

  
}
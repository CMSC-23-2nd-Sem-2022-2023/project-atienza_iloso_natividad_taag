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
  final GlobalKey _globalKey = GlobalKey(); 
  QRViewController? controller;
  Barcode? result;

  void qr(QRViewController controller ){
    this.controller = controller;
    controller.scannedDataStream.listen((event){
      setState((){
        result = event;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
       Column(
         children: [
          Container(
          width: 200, 
          height: 200,
           child: QRView(
             key: _globalKey, 
             onQRViewCreated: qr
           ),
         ),
          Container(
            child:(result != null) ? Text('${result!.code}'): Text('Scan a code'),
          ),
         ]
       ),

      
    );
  }
}
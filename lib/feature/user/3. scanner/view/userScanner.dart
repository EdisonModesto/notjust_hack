import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

class UserScanner extends ConsumerStatefulWidget {
  const UserScanner({super.key});

  static const String routePath = '/user/scanner';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserScannerState();
}

class _UserScannerState extends ConsumerState<UserScanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRCodeDartScanView(
        scanInvertedQRCode: true, // enable scan invert qr code ( default = false)
        typeScan: TypeScan.takePicture, // if TypeScan.takePicture will try decode when click to take a picture (default TypeScan.live)
        // takePictureButtonBuilder: (context,controller,isLoading){ // if typeScan == TypeScan.takePicture you can customize the button.
        //    if(loading) return CircularProgressIndicator();
        //    return ElevatedButton(
        //       onPressed:controller.takePictureAndDecode,
        //       child:Text('Take a picture'),
        //    );
        // }
        // resolutionPreset: = QrCodeDartScanResolutionPreset.high,
        // formats: [ // You can restrict specific formats.
        //   BarcodeFormat.QR_CODE,
        //   BarcodeFormat.AZTEC,
        //   BarcodeFormat.DATA_MATRIX,
        //   BarcodeFormat.PDF_417,
        //   BarcodeFormat.CODE_39,
        //   BarcodeFormat.CODE_93,
        //   BarcodeFormat.CODE_128,
        //  BarcodeFormat.EAN_8,
        //   BarcodeFormat.EAN_13,
        // ],
        onCapture: (Result result) async {
          // do anything with result
          // result.text
          // result.rawBytes
          // result.resultPoints
          // result.format
          // result.numBits
          // result.resultMetadata
          // result.time
          print(result.text);

          List<String> parsedString = result.text.split(':');

          if (parsedString.length == 2) {
            GoRouter.of(context).pushNamed(
              'discoverDetails',
              pathParameters: {
                'id': parsedString[1],
              },
            );
          }
        },
      ),
    );
  }
}

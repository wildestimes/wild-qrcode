
import 'dart:io';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image/image.dart';
import 'dart:ui' as ui;

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('Usage: dart run qr_code_generator.dart <url1> [url2 ...] [output_prefix]');
    exit(1);
  }

  String outputPrefix = 'qrcode';
  List<String> urls = [];

  // Determine if the last argument is an output prefix or a URL
  if (arguments.length > 1 && !arguments.last.startsWith('http')) {
    outputPrefix = arguments.last;
    urls = arguments.sublist(0, arguments.length - 1);
  } else {
    urls = arguments;
  }

  for (int i = 0; i < urls.length; i++) {
    final String url = urls[i];
    final String outputFile = '${outputPrefix}_${i + 1}.png';

    try {
      final qrImage = QrPainter(
        data: url,
        version: QrVersions.auto,
        gapless: true,
        color: const QrEyeFrameColor(
          color: ui.Color(0xFF000000),
        ),
        emptyColor: const QrEyeFrameColor(
          color: ui.Color(0xFFFFFFFF),
        ),
      );

      final pic = await qrImage.toPicture(200);
      final image = await pic.toImage(200, 200);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      File(outputFile).writeAsBytesSync(pngBytes);
      print('QR code for "$url" saved to "$outputFile"');
    } catch (e) {
      print('Error generating QR code for $url: $e');
      exit(1);
    }
  }
}

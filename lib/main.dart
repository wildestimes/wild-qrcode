
import 'dart:io';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image/image.dart';

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('Usage: dart run qr_code_generator.dart <url> [output_file.png]');
    exit(1);
  }

  final String url = arguments[0];
  final String outputFile = arguments.length > 1 ? arguments[1] : 'qrcode.png';

  try {
    final qrImage = QrPainter(
      data: url,
      version: QrVersions.auto,
      gapless: true,
      color: const QrEyeFrameColor(
        color: Color(0xFF000000),
      ),
      emptyColor: const QrEyeFrameColor(
        color: Color(0xFFFFFFFF),
      ),
    );

    final pic = await qrImage.toPicture(200);
    final image = await pic.toImage(200, 200);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    File(outputFile).writeAsBytesSync(pngBytes);
    print('QR code for "$url" saved to "$outputFile"');
  } catch (e) {
    print('Error generating QR code: $e');
    exit(1);
  }
}

import 'dart:io';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;
import 'package:args/args.dart';

ui.Color parseColor(String colorString) {
  if (colorString.startsWith('0x')) {
    return ui.Color(int.parse(colorString));
  } else if (colorString.startsWith('#')) {
    return ui.Color(int.parse('ff' + colorString.substring(1), radix: 16));
  } else {
    switch (colorString.toLowerCase()) {
      case 'black': return ui.Color(0xFF000000);
      case 'white': return ui.Color(0xFFFFFFFF);
      case 'red': return ui.Color(0xFFFF0000);
      case 'green': return ui.Color(0xFF00FF00);
      case 'blue': return ui.Color(0xFF0000FF);
      default: return ui.Color(0xFF000000);
    }
  }
}

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('color', abbr: 'c', defaultsTo: 'black', help: 'QR code fill color (hex or name)')
    ..addOption('background', abbr: 'b', defaultsTo: 'white', help: 'QR code background color (hex or name)')
    ..addOption('logo', abbr: 'l', help: 'Path to a logo image file to embed')
    ..addOption('ai-prompt', abbr: 'a', help: 'Text prompt for AI image generation to augment the QR code')
    ..addFlag('help', abbr: 'h', hide: true);

  ArgResults argResults = parser.parse(arguments);

  if (argResults['help'] || argResults.rest.isEmpty) {
    print('Usage: dart run qr_code_generator.dart [options] <url1> [url2 ...] [output_prefix]');
    print(parser.usage);
    exit(0);
  }

  final ui.Color qrColor = parseColor(argResults['color']);
  final ui.Color qrBackgroundColor = parseColor(argResults['background']);
  final String? logoPath = argResults['logo'];
  final String? aiPrompt = argResults['ai-prompt'];

  img.Image? logoImage;
  if (logoPath != null) {
    final File logoFile = File(logoPath);
    if (!logoFile.existsSync()) {
      print('Error: Logo file not found at $logoPath');
      exit(1);
    }
    logoImage = img.decodeImage(logoFile.readAsBytesSync());
    if (logoImage == null) {
      print('Error: Could not decode logo image from $logoPath');
      exit(1);
    }
  }

  String outputPrefix = 'qrcode';
  List<String> urls = [];

  if (argResults.rest.length > 1 && !argResults.rest.last.startsWith('http')) {
    outputPrefix = argResults.rest.last;
    urls = argResults.rest.sublist(0, argResults.rest.length - 1);
  } else {
    urls = argResults.rest;
  }

  for (int i = 0; i < urls.length; i++) {
    final String url = urls[i];
    final String outputFile = '${outputPrefix}_${i + 1}.png';

    try {
      final qrImage = QrPainter(
        data: url,
        version: QrVersions.auto,
        gapless: true,
        color: QrEyeFrameColor(
          color: qrColor,
        ),
        emptyColor: QrEyeFrameColor(
          color: qrBackgroundColor,
        ),
      );

      final int qrSize = 200;
      final pic = await qrImage.toPicture(qrSize.toDouble());
      final image = await pic.toImage(qrSize, qrSize);
      img.Image qrCodeImage = img.decodeImage( (await image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List() )!;

      if (logoImage != null) {
        final int logoSize = (qrSize * 0.2).toInt();
        final img.Image resizedLogo = img.copyResize(logoImage, width: logoSize, height: logoSize);
        final int offsetX = (qrSize - logoSize) ~/ 2;
        final int offsetY = (qrSize - logoSize) ~/ 2;
        img.compositeImage(qrCodeImage, resizedLogo, dstX: offsetX, dstY: offsetY);
      }

      if (aiPrompt != null) {
        final tempQrFile = '${outputPrefix}_${i + 1}_temp_qr.png';
        final pngBytes = img.encodePng(qrCodeImage);
        File(tempQrFile).writeAsBytesSync(pngBytes);
        print('Temporary QR code for "$url" saved to "$tempQrFile"');
        print('Please use the edit_image tool with file: "$tempQrFile" and prompt: "$aiPrompt"');
        print('After editing, save the result to "$outputFile"');
      } else {
        final pngBytes = img.encodePng(qrCodeImage);
        File(outputFile).writeAsBytesSync(pngBytes);
        print('QR code for "$url" saved to "$outputFile"');
      }
    } catch (e) {
      print('Error generating QR code for $url: $e');
      exit(1);
    }
  }
}

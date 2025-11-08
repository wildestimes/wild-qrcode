
import 'dart:io';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image/image.dart';
import 'dart:ui' as ui;
import 'package:args/args.dart';

ui.Color parseColor(String colorString) {
  if (colorString.startsWith('0x')) {
    return ui.Color(int.parse(colorString));
  } else if (colorString.startsWith('#')) {
    return ui.Color(int.parse('ff' + colorString.substring(1), radix: 16));
  } else {
    // Basic color names for simplicity
    switch (colorString.toLowerCase()) {
      case 'black': return ui.Color(0xFF000000);
      case 'white': return ui.Color(0xFFFFFFFF);
      case 'red': return ui.Color(0xFFFF0000);
      case 'green': return ui.Color(0xFF00FF00);
      case 'blue': return ui.Color(0xFF0000FF);
      default: return ui.Color(0xFF000000); // Default to black
    }
  }
}

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('color', abbr: 'c', defaultsTo: 'black', help: 'QR code fill color (hex or name)')
    ..addOption('background', abbr: 'b', defaultsTo: 'white', help: 'QR code background color (hex or name)')
    ..addFlag('help', abbr: 'h', hide: true);

  ArgResults argResults = parser.parse(arguments);

  if (argResults['help'] || argResults.rest.isEmpty) {
    print('Usage: dart run qr_code_generator.dart [options] <url1> [url2 ...] [output_prefix]');
    print(parser.usage);
    exit(0);
  }

  final ui.Color qrColor = parseColor(argResults['color']);
  final ui.Color qrBackgroundColor = parseColor(argResults['background']);

  String outputPrefix = 'qrcode';
  List<String> urls = [];

  // Determine if the last argument in rest is an output prefix or a URL
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

import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/material.dart';

void saveImageFile(Uint8List bytes, BuildContext context) async {
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.document.createElement('a') as html.AnchorElement
    ..href = url
    ..style.display = 'none'
    ..download = 'recommendation.png';
  html.document.body!.children.add(anchor);

  anchor.click();
  html.document.body!.children.remove(anchor);
  html.Url.revokeObjectUrl(url);
}

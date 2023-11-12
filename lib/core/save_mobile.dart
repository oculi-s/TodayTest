import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

Future<void> saveImageFile(Uint8List bytes, BuildContext context) async {
  final result = await ImageGallerySaver.saveImage(bytes.buffer.asUint8List());

  var snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 20.0),
    content: const Text('저장된 이미지는 갤러리에서 확인 가능합니다.'),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

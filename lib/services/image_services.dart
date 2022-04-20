import 'dart:io';

// import 'package:charitybox/config/custom_color.dart';
// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageServices {
  static Future selectImage({
    required bool isGallery,
  }) async {
    final source = isGallery ? ImageSource.gallery : ImageSource.camera;
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile == null) return null;

    final file = File(pickedFile.path);

    // return cropImage(file);
    return file;
  }

  // static Future cropImage(File imageFile) async => await ImageCropper.cropImage(
  //     sourcePath: imageFile.path,
  //     aspectRatio: CropAspectRatio(ratioX: 16, ratioY: 16),
  //     androidUiSettings: androidUiSettings(),
  //     iosUiSettings: ioUiSettings());

  // static IOSUiSettings ioUiSettings() => IOSUiSettings(
  //       aspectRatioLockEnabled: true,
  //     );

  // static AndroidUiSettings androidUiSettings() => AndroidUiSettings(
  //       toolbarTitle: "Crop Image",
  //       toolbarColor: Colors.green,
  //       toolbarWidgetColor: Colors.white,
  //       lockAspectRatio: false,
  //     );
}

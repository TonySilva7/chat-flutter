import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File image) onImagePick;
  const UserImagePicker({super.key, required this.onImagePick});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _storedImage;
  final ImagePicker picker = ImagePicker();

  Future<void> getLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }

    if (response.files != null) {
      for (final XFile file in response.files ?? []) {
        _handleFile(file);
      }
    } else {
      _handleError(response.exception);
    }
  }

  _handleFile(XFile file) {
    setState(() {
      _storedImage = File(file.path);
    });
  }

  _handleError(PlatformException? exception) {
    print(exception);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey,
        backgroundImage: _storedImage != null ? FileImage(_storedImage!) : null,
      ),
    ]);
  }
}

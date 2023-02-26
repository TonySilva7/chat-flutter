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
  File? _image;
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
      _image = File(file.path);
    });
  }

  _handleError(PlatformException? exception) {
    print(exception);
  }

  Future<void> _handlePickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);

    if (image == null) return;
    setState(() {
      _image = File(image.path);
    });

    widget.onImagePick(_image!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey,
        backgroundImage: _image != null ? FileImage(_image!) : null,
      ),
      TextButton(
        onPressed: _handlePickImage,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 5),
            const Text('Adicionar imagem'),
          ],
        ),
      )
    ]);
  }
}

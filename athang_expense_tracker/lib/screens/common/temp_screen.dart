import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source, BuildContext context) async {
    if (source == ImageSource.camera) {
      PermissionStatus cameraStatus = await Permission.camera.request();
      if (!cameraStatus.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Camera permission is required')),
        );
        return;
      }
    } else {
      PermissionStatus photosStatus = await Permission.photos.request();
      if (!photosStatus.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Photo library permission is required')),
        );
        return;
      }
    }

    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage(BuildContext context) async {
    if (_image == null) return;

    final uri = Uri.parse('https://example.com/upload');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        _image!.path,
        filename: basename(_image!.path),
      ));
    request.fields['title'] = 'something';

    final response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload successful!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Image')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_image != null)
              Image.file(_image!, height: 300, width: 200)
            else
              Text('No image selected.'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.camera, context),
                  child: Text('Camera'),
                ),
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.gallery, context),
                  child: Text('Gallery'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _uploadImage(context),
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}

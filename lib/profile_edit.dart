import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin_dashboard.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  File? _image;
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();

  Future<void> pickImage() async {
    final p = ImagePicker();
    final f = await p.pickImage(source: ImageSource.gallery);
    if (f != null) setState(() => _image = File(f.path));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Modifica Profilo'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                ),
              ),
              CupertinoTextField(
                controller: _nameController,
                placeholder: 'Nome',
              ),
              CupertinoTextField(
                controller: _surnameController,
                placeholder: 'Cognome',
              ),
              CupertinoButton.filled(
                onPressed: () {
                  // chiamata BE per aggiornare profilo e upload immagine
                },
                child: const Text('Salva'),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text("Vai al Profilo"),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (_) => AdminDashboardPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

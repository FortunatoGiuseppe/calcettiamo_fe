import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/profile_edit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ProfilePage extends StatefulWidget {
  final String token; // Passiamo il JWT dal login

  const ProfilePage({super.key, required this.token});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  final List<String> _friends = ["Mario Rossi", "Luca Bianchi", "Anna Verdi"];

  static const Color appGreen = Color(0xFF289775);

  late String email;
  late String role;

  @override
  void initState() {
    super.initState();
    final decodedToken = JwtDecoder.decode(widget.token);
    email = decodedToken["sub"]; // dal tuo JWT il subject è l'email
    role = decodedToken["roles"][0]; // prendi il primo ruolo
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _addFriend() {
    showCupertinoDialog(
      context: context,
      builder: (_) {
        final TextEditingController controller = TextEditingController();
        return CupertinoAlertDialog(
          title: const Text("Aggiungi Amico"),
          content: CupertinoTextField(
            controller: controller,
            placeholder: "Nome amico",
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text("Annulla"),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoDialogAction(
              child: const Text("Aggiungi"),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() {
                    _friends.add(controller.text);
                  });
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _logout() {
    Navigator.pop(context); // Torna alla login
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text("Profilo")),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // FOTO PROFILO
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: CupertinoColors.systemGrey4,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : null,
                  child: _profileImage == null
                      ? const Icon(
                          CupertinoIcons.person_alt_circle,
                          size: 80,
                          color: CupertinoColors.white,
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 12),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _pickImage,
                child: const Text(
                  "Cambia immagine",
                  style: TextStyle(color: appGreen),
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text("Vai al Profilo"),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (_) => ProfileEditPage()),
                  );
                },
              ),

              const SizedBox(height: 24),

              // DATI UTENTE DAL JWT
              Text(
                email,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Ruolo: $role",
                style: const TextStyle(color: CupertinoColors.systemGrey),
              ),

              const SizedBox(height: 30),

              // LISTA AMICI
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Amici",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: _addFriend,
                    child: const Icon(
                      CupertinoIcons.add_circled,
                      color: appGreen,
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _friends.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey6,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_friends[index]),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: const Icon(
                            CupertinoIcons.delete,
                            color: CupertinoColors.systemRed,
                          ),
                          onPressed: () {
                            setState(() {
                              _friends.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 40),

              // LOGOUT
              CupertinoButton.filled(
                borderRadius: BorderRadius.circular(12),
                onPressed: _logout,
                color: CupertinoColors.destructiveRed,
                child: const Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

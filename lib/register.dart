import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/auth_service.dart';
import 'package:flutter_application_1/login.dart';

import 'package:shared_preferences/shared_preferences.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController(
    text: "USER",
  ); // default USER
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  static const Color appGreen = Color(0xFF289775);

  void _register() async {
    final email = _emailController.text.trim();
    final name = _nameController.text.trim();
    final surname = _surnameController.text.trim();
    final role = _roleController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (email.isEmpty || name.isEmpty || surname.isEmpty || password.isEmpty) {
      _showDialog("Errore", "Tutti i campi devono essere compilati");
      return;
    }

    if (password != confirmPassword) {
      _showDialog("Errore", "Le password non coincidono");
      return;
    }

    try {
      final authService = AuthService();
      final response = await authService.register(
        email,
        name,
        surname,
        password,
        role,
      );

      // La risposta è il JWT
      final token = response;

      // Salva il token
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt', token);

      _showDialog("Registrazione riuscita", "Token salvato correttamente.");
    } catch (e) {
      _showDialog("Errore", e.toString());
    }
  }

  void _showDialog(String title, String content) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Image.asset("images/calcettiamo_logo.png", height: 40),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Benvenuto!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              CupertinoTextField(
                controller: _emailController,
                placeholder: "Email",
                keyboardType: TextInputType.emailAddress,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 12),
              CupertinoTextField(
                controller: _nameController,
                placeholder: "Nome",
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 12),
              CupertinoTextField(
                controller: _surnameController,
                placeholder: "Cognome",
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 12),
              CupertinoTextField(
                controller: _roleController,
                placeholder: "Ruolo",
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 12),
              CupertinoTextField(
                controller: _passwordController,
                placeholder: "Password",
                obscureText: true,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 12),
              CupertinoTextField(
                controller: _confirmPasswordController,
                placeholder: "Conferma Password",
                obscureText: true,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 24),
              CupertinoButton.filled(
                borderRadius: BorderRadius.circular(12),
                onPressed: _register,
                color: appGreen,
                child: const Text("Registrati"),
              ),
              const SizedBox(height: 16),
              CupertinoButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (_) => const LoginPage()),
                  );
                },
                child: const Text(
                  "Ho già un account, accedi",
                  style: TextStyle(color: appGreen),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

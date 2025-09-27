import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/register.dart';
import 'auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart'; // crea una pagina di home protetta

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  static const Color appGreen = Color(0xFF289775);

  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showDialog("Errore", "Email e password sono obbligatorie");
      return;
    }

    try {
      final authService = AuthService();
      final token = await authService.login(email, password);

      // Salva il token in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt', token);

      // Naviga verso la home page
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (_) => const HomePage()),
      );
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
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Benvenuto!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
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
              const SizedBox(height: 16),
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
              const SizedBox(height: 30),
              CupertinoButton.filled(
                borderRadius: BorderRadius.circular(12),
                onPressed: _login,
                color: appGreen,
                child: const Text("Accedi"),
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => const RegistrationPage(),
                    ),
                  );
                },
                child: Text(
                  "Non hai un account? Registrati",
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

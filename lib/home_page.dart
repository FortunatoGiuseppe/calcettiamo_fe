import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('jwt');
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Home'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text("Logout"),
          onPressed: _logout,
        ),
      ),
      child: SafeArea(
        child: Center(
          child: _token == null
              ? const CupertinoActivityIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Benvenuto!",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Il tuo token JWT è:",
                      style: TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Text("Vai al Profilo"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => ProfilePage(token: _token!),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        _token!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.activeBlue,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

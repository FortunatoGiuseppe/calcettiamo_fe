import 'package:flutter/cupertino.dart';
import 'login.dart';
import 'friends_page.dart';
import 'admin_dashboard.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      // per rotte nominate potresti usare `onGenerateRoute`
    );
  }
}

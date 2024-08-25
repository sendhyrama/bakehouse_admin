import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/navbar_state.dart';
import 'routes.dart';
import 'utils/colors.dart';
import 'utils/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPrefs.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bakehouse',
      theme: ThemeData(
        primaryColor: PrimaryColor.c8,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Routes.splash,
      routes: Routes.getRoutes(),
      onGenerateRoute: (settings) {
        if (settings.name == Routes.navbarAdmin) {
          final int initialIndex = settings.arguments as int? ?? 0;
          return MaterialPageRoute(
            builder: (context) {
              return NavbarAdmin(initialIndex: initialIndex);
            },
          );
        }
        return null;
      },
    );
  }
}

import 'package:Images_App/models/image.dart';
import 'package:Images_App/screens/register_image/register_image_screen.dart';
import 'package:Images_App/services/image_service.dart';
import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';
import 'package:provider/provider.dart';

import 'screens/image/image_screen.dart';

Future<void> main() async => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ImageService(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreem(),
        initialRoute: "/login",
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case "/image":
              return MaterialPageRoute(
                  builder: (_) =>
                      ImageScreem(settings.arguments as ImageModel));
            case "/register_image":
              return MaterialPageRoute(builder: (_) => RegisterImageScreen());
            case "/home":
            default:
              return MaterialPageRoute(builder: (_) => HomeScreem());
          }
        },
      ),
    );
  }
}

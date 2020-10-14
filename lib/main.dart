import 'package:Images_App/services/image_service.dart';
import 'package:flutter/material.dart';
import 'screens/home/home.dart';
import 'package:provider/provider.dart';

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
        home: Home(),
      ),
    );
  }
}

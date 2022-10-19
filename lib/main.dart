import 'package:flutter/material.dart';


import 'Screen/all_music.dart';


void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Audio Player",
      home: HomePage(),
      // initialRoute: AppRoutes().homePage,
      // routes: routes,
    );
  }
}

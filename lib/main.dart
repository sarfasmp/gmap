
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gmapapp/presentation/controller/home_screen_provider.dart';
import 'package:gmapapp/presentation/view/home_screen.dart';
import 'package:gmapapp/presentation/view/map_screen.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


void main() {

  HttpOverrides.global = MyHttpOverrides();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

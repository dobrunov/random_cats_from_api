import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_cats_one/services/cat_facts_service.dart';
import 'package:test_cats_one/services/connectivity_service.dart';

import 'home/home.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat facts and photo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => CatFactsService(),
          ),
          RepositoryProvider(
            create: (context) => ConnectivityService(),
          ),
        ],
        child: const HomePage(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

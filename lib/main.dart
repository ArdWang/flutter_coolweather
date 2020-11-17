import 'package:flutter/material.dart';
import 'package:flutter_coolweather/app/provider/state_provider.dart';

import 'package:provider/provider.dart';

import 'package:flutter_coolweather/app/pages/index_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_) => StateProvider()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cool Weather',
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: IndexPage(),
    );
  }
}


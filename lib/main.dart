import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xicom_test/providers/form_screen_provider.dart';
import 'package:xicom_test/screens/form_screen.dart';
import 'package:xicom_test/screens/home_screen.dart';

import 'providers/home_provider.dart';

void main() {
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (ctx)=> HomeProvider()),
        ChangeNotifierProvider(create: (ctx)=> FormScreenProvider())



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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      initialRoute: HomeScreen.classname,
      routes: {
        '/':(context)=>HomeScreen(),
        FormScreen.classname:(context)=>FormScreen(),



      },
    );
  }
}

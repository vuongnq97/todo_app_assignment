import 'package:flutter/material.dart';

import 'app/login.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter login demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(
        onSignedIn: () {},
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:note_app/DBProvider.dart';
import 'package:note_app/data/dbhelper.dart';
import 'package:note_app/view/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>DBProvider(dbhelper: Dbhelper.getInstance()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes',
        darkTheme: ThemeData.dark(useMaterial3: true),
        home: HomePage(),
      ),
    );
  }
}


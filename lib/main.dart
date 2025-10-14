import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart'; //added
import 'package:note_app/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();    //added
  await Hive.initFlutter();                     //added
  await Hive.openBox<String>('notesBox');         //added
  runApp(const ProviderScope (child:MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Home(),
      ),
    );
  }
}


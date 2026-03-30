import 'package:flutter/material.dart';
import './UI/menu.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    home: Menu(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  Widget build(BuildContext context){
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_){

            })
        ]
    );
  }
}
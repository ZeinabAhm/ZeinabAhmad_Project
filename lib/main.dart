import 'package:flutter/material.dart';
import 'package:zeinab_ahmad_project/More_Info_Page.dart';
import 'package:zeinab_ahmad_project/Welcome_Screen.dart';
import 'package:zeinab_ahmad_project/data/expense_data.dart';
import 'pages/home.page.dart';
import 'package:provider/provider.dart';
import 'models/expense_item.dart';
import 'package:zeinab_ahmad_project/Welcome_Screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=>ExpenseData(),
    builder:(context,child)=> MaterialApp(
     debugShowCheckedModeBanner:false,
     home:WelcomeScreen(),
    ),
    );
  }
}


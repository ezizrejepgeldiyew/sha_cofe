import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_kofe/provider/basket_provider.dart';
import 'package:sa_kofe/provider/main_provider.dart';
import 'package:sa_kofe/provider/menu_provider.dart';
import 'package:sa_kofe/provider/order_provider.dart';
import 'package:sa_kofe/view/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainProvider()),
        ChangeNotifierProvider(create: (context) => MenuProvider()),
        ChangeNotifierProvider(create: (context) => BasketProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: const MaterialApp(home: DashboardScreen()),
    );
  }
}

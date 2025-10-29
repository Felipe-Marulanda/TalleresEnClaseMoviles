import 'package:flutter/material.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_drawer.dart';
import 'home_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Inicio 🌎'),
  drawer: CustomDrawer(),
      body: const HomePage(),
    );
  }
}

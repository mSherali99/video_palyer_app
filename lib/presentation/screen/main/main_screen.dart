import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_palyer_app/presentation/screen/cookies/home_screen.dart';
import 'package:video_palyer_app/presentation/screen/second_page/favourite_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.redAccent));
    List<Widget> pages = [const HomeScreen(), const FavouriteScreen()];
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          currentIndex = value;
          setState(() {});
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.redAccent.shade400,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.cookie), label: "Cookies"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Homes"),
        ],
      ),
    );
  }
}

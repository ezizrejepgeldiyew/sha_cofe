import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_kofe/provider/basket_provider.dart';
import 'package:sa_kofe/view/basket/basket_screen.dart';
import 'package:sa_kofe/view/home/home_screen.dart';
import 'package:sa_kofe/view/menu/menu_screen.dart';
import 'package:sa_kofe/view/profil/profil_screen.dart';
import 'package:badges/badges.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, this.index});
  final int? index;
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[
    const HomeScreen(),
    const MenuScreen(),
    const BasketScreen(),
    const ProfilScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List basketProductIdList =
        Provider.of<BasketProvider>(context).productData;
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(widget.index ?? selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedIconTheme: const IconThemeData(color: Colors.brown),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedFontSize: 15,
        selectedItemColor: Colors.brown,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.brown, size: 35),
              label: 'Home'),
          const BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined, color: Colors.brown, size: 35),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Badge(
                badgeAnimation: const BadgeAnimation.scale(),
                showBadge: basketProductIdList.isEmpty ? false : true,
                badgeContent: Text("${basketProductIdList.length}",
                    style: const TextStyle(color: Colors.white, fontSize: 18)),
                child: const Icon(Icons.shopping_cart,
                    color: Colors.brown, size: 35)),
            label: 'Sebedim',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.brown, size: 35),
            label: 'Profil',
          ),
        ],
        currentIndex: widget.index ?? selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}

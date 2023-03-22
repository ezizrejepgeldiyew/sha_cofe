import 'package:flutter/material.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text("Profil"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            ButtonPages(
                routeName: '/loginPage',
                iconName: Icons.login,
                title: 'Hasabyma gir'),
            ButtonPages(
                iconName: Icons.card_travel,
                routeName: '/ordersPage',
                title: 'Sargytlarym'),
            ButtonPages(
                iconName: Icons.date_range,
                routeName: '/bronsPage',
                title: 'Bronlarym'),
            ButtonPages(
                iconName: Icons.favorite_outline_sharp,
                routeName: '/favoritesPage',
                title: 'Halanlarym'),
          ],
        ),
      ),
    );
  }
}

class ButtonPages extends StatelessWidget {
  final String routeName;
  final IconData iconName;
  final String title;
  const ButtonPages(
      {Key? key,
      required this.iconName,
      required this.routeName,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white),
          child: Row(
            children: [
              Icon(
                iconName,
                color: Colors.brown,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 20, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_kofe/provider/order_provider.dart';
import 'package:sa_kofe/view/model/place_model.dart';

class MyDropdownButton extends StatefulWidget {
  final List<PlaceModel> places;
  const MyDropdownButton({super.key, required this.places});

  @override
  State<MyDropdownButton> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String? _selectedPlaceName;

  @override
  Widget build(BuildContext context) {
    Function placeName = Provider.of<OrderProvider>(context).placeName;
    return DropdownButton(
      alignment: Alignment.centerLeft,
      hint: const Text('Ýer saýlaň'),
      value: _selectedPlaceName,
      underline: const SizedBox(),
      items: widget.places
          .map((item) => DropdownMenuItem(
                value: item.name,
                child: Text(item.name),
              ))
          .toList(),
      iconSize: 30,
      style: TextStyle(
        color: Colors.grey[700],
        fontSize: 20,
      ),
      isExpanded: true,
      onChanged: (newPlaceName) {
        setState(() {
          placeName(newPlaceName);
          _selectedPlaceName = newPlaceName;
        });
      },
    );
  }
}

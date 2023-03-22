import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_kofe/provider/order_provider.dart';

class TelInput extends StatefulWidget {
  const TelInput({super.key});

  @override
  State<TelInput> createState() => _TelInputState();
}

class _TelInputState extends State<TelInput> {
  final _controllerPhoneNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Function phoneNumber = Provider.of<OrderProvider>(context).phoneNumber;

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
              bottom: 23,
            ),
            padding: const EdgeInsets.only(top: 20, right: 15, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(5),
                topLeft: Radius.circular(5),
              ),
            ),
            child: const Text(
              '+993',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.only(right: 5),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  phoneNumber(value);
                });
              },
              controller: _controllerPhoneNumber,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  borderSide: BorderSide(color: Colors.brown, width: 2),
                ),
              ),
              maxLength: 8,
              keyboardType: TextInputType.phone,
            ),
          ),
        ),
      ],
    );
  }
}

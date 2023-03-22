import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_kofe/provider/order_provider.dart';

class MyDate extends StatefulWidget {
  const MyDate({super.key});

  @override
  State<MyDate> createState() => _MyDateState();
}

class _MyDateState extends State<MyDate> {
  DateTime dateTime = DateTime.now();
  DateTime selectedDateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Function date = Provider.of<OrderProvider>(context, listen: false).dateTime;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.27,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey)),
          child: CupertinoPageScaffold(
            child: CupertinoButton(
              alignment: Alignment.centerLeft,
              child: Text(
                  '${selectedDateTime.day}-${selectedDateTime.month}-${selectedDateTime.year}  ${selectedDateTime.hour}:${selectedDateTime.minute}'),
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) => SizedBox(
                    height: h * 0.4,
                    child: CupertinoDatePicker(
                      minimumDate:
                          dateTime.subtract(const Duration(minutes: 1)),
                      maximumDate: DateTime(
                          dateTime.year, dateTime.month, dateTime.day + 3),
                      backgroundColor: Colors.white,
                      initialDateTime: selectedDateTime,
                      onDateTimeChanged: (DateTime newTime) {
                        setState(() {
                          date(selectedDateTime);
                          selectedDateTime = newTime;
                        });
                      },
                      use24hFormat: true,
                      mode: CupertinoDatePickerMode.dateAndTime,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

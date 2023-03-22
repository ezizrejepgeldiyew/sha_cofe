import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sa_kofe/view/widgets/tel_input.dart';

class Bron extends StatefulWidget {
  const Bron({super.key});

  @override
  State<Bron> createState() => _BronState();
}

class _BronState extends State<Bron> {
  String? cafeValue;
  int? numberValue;
  DateTime dateTime = DateTime.now();
  List<String> cafeListItem = [
    'Ylham seyilgahi',
    'Berkarar sowda merkezi',
  ];
  List<int> numberListItem = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text("Bronym"),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 30, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cafeDropdown(),
                    const SizedBox(
                      height: 20,
                    ),
                    numberDropdown(),
                    const SizedBox(
                      height: 20,
                    ),
                    dateTimes(),
                    const SizedBox(
                      height: 20,
                    ),
                    nameInput(),
                    const SizedBox(
                      height: 20,
                    ),
                    const TelInput(),
                    descriptionInput(),
                  ],
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              InkWell(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.brown,
                  padding: const EdgeInsets.all(25),
                  child: const Text(
                    "Bron et",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Column descriptionInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidgets(title: "Bellikleriniz"),
        const SizedBox(
          height: 5,
        ),
        Container(
          margin: const EdgeInsets.only(right: 25),
          child: TextFormField(
            minLines: 2,
            maxLines: 5,
            decoration: InputDecoration(
                hintText: 'Belliklerinizi yazyn',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                )),
          ),
        ),
      ],
    );
  }

  Column nameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidgets(title: "Adynyz"),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.only(
            right: 25,
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: "Adynyzy girizin",
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Column dateTimes() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidgets(title: "Wagty"),
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 105,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey)),
            child: CupertinoPageScaffold(
              child: CupertinoButton(
                alignment: Alignment.centerLeft,
                child: Text(
                    '${dateTime.day}-${dateTime.month}-${dateTime.year}  ${dateTime.hour}:${dateTime.minute}'),
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => SizedBox(
                      height: 250,
                      child: CupertinoDatePicker(
                        minimumDate:
                            dateTime.subtract(const Duration(minutes: 1)),
                        maximumDate: DateTime(
                            dateTime.year, dateTime.month, dateTime.day + 3),
                        backgroundColor: Colors.white,
                        initialDateTime: dateTime,
                        onDateTimeChanged: (DateTime newTime) {
                          setState(() {
                            dateTime = newTime;
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

  Column numberDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidgets(title: "Adam sany"),
        const SizedBox(
          height: 5,
        ),
        Container(
          margin: const EdgeInsets.only(right: 26),
          padding: const EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.grey,
              )),
          child: DropdownButton(
            hint: const Text("Sany sayla"),
            alignment: Alignment.centerLeft,
            underline: const SizedBox(),
            value: numberValue,
            items: numberListItem.map((valueItem) {
              return DropdownMenuItem(
                value: valueItem,
                child: Text(valueItem.toString()),
              );
            }).toList(),
            iconSize: 30,
            style: TextStyle(color: Colors.grey[700], fontSize: 16),
            isExpanded: true,
            onChanged: (newValue) {
              setState(() {
                numberValue = newValue;
              });
            },
          ),
        ),
      ],
    );
  }

  Column cafeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidgets(title: "Kafe"),
        const SizedBox(
          height: 5,
        ),
        Container(
          margin: const EdgeInsets.only(right: 26),
          padding: const EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.grey,
              )),
          child: DropdownButton(
            hint: const Text("Kafe sayla"),
            alignment: Alignment.centerLeft,
            underline: const SizedBox(),
            value: cafeValue,
            items: cafeListItem.map((valueItem) {
              return DropdownMenuItem(
                value: valueItem,
                child: Text(valueItem),
              );
            }).toList(),
            iconSize: 30,
            style: TextStyle(color: Colors.grey[700], fontSize: 16),
            isExpanded: true,
            onChanged: (newValue) {
              setState(() {
                cafeValue = newValue.toString();
              });
            },
          ),
        ),
      ],
    );
  }
}

class TextWidgets extends StatelessWidget {
  final String title;
  const TextWidgets({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        color: Colors.grey[700],
      ),
    );
  }
}

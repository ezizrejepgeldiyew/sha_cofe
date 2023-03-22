import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_kofe/provider/basket_provider.dart';
import 'package:sa_kofe/provider/order_provider.dart';
import 'package:sa_kofe/view/widgets/my_date.dart';
import 'package:sa_kofe/view/widgets/my_dropdown_button.dart';
import 'package:sa_kofe/view/widgets/tel_input.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

List<String> servicesTypeNames = [
  'Eltip bermek',
  'Alyp gaýytmak',
  'Baryp iýmek'
];
List<String> paymentTypeNames = ['Nagyt töleg', 'Terminal töleg'];
int _servicesTypeId = 0;
int _servicesTime = 1;
int _paymentTypeId = 0;

class _OrderScreenState extends State<OrderScreen> {
  final _controllerDelivery = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerNotes = TextEditingController();
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double sp = MediaQuery.of(context).textScaleFactor;

    Future getPlace() async {
      final provider = Provider.of<OrderProvider>(context, listen: false);
      final places = await provider.getPlace();
      return places;
    }
    final List _productData = Provider.of<BasketProvider>(context).productData;
    Function postOrder = Provider.of<OrderProvider>(context).postOrder;

    Future<int> readyTime() async {
      var time = await Provider.of<BasketProvider>(context).readTime();
      return time;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('Sargydym'),
      ),
      body: ListView(
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: h * 0.02, horizontal: w * 0.039),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textWidget(context, 'Kafe', true, sp * 20, Colors.grey[600]),
                SizedBox(height: h * 0.01),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: w * 0.02),
                  height: h * 0.055,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: textWidget(
                    context,
                    'Şa kofe - Ylham seýilgähi',
                    true,
                    sp * 20,
                    Colors.grey[600],
                  ),
                ),
                SizedBox(height: h * 0.02),
                textWidget(context, 'Sargyt', true, sp * 20, Colors.grey[600]),
                Row(
                  children: [
                    servicesType(context, sp, 0),
                    servicesType(context, sp, 1),
                    if (w > 431) servicesType(context, sp, 2),
                  ],
                ),
                if (w < 433) servicesType(context, sp, 2),
                SizedBox(height: h * 0.01),
                if (_servicesTypeId == 0)
                  placeDropdownButton(context, sp, h, w, getPlace),
                Padding(
                  padding: EdgeInsets.only(top: h * 0.03, bottom: h * 0.01),
                  child: textWidget(
                      context,
                      '${servicesTypeNames[_servicesTypeId]} wagty',
                      true,
                      sp * 20,
                      Colors.grey[600]),
                ),
                Row(
                  children: [
                    Radio(
                      value: 1,
                      activeColor: Colors.brown,
                      groupValue: _servicesTime,
                      onChanged: (value) => setState(() {
                        _servicesTime = value!;
                      }),
                    ),
                    InkWell(
                      onTap: () => setState(() {
                        _servicesTime = 1;
                      }),
                      child: Row(
                        children: [
                          textWidget(context, 'Şu wagt', false, sp * 20,
                              Colors.grey[600]),
                          FutureBuilder(
                              future: readyTime(),
                              builder: (context, time) {
                                return textWidget(
                                    context,
                                    _servicesTypeId == 0
                                        ? ' (~${(time.data ?? 0) + 30} min)'
                                        : ' (~${time.data} min)',
                                    false,
                                    sp * 20,
                                    Colors.red[600]);
                              }),
                        ],
                      ),
                    ),
                    Radio(
                      value: 2,
                      activeColor: Colors.brown,
                      groupValue: _servicesTime,
                      onChanged: (value) => setState(() {
                        _servicesTime = value!;
                      }),
                    ),
                    InkWell(
                      onTap: () => setState(() {
                        _servicesTime = 2;
                      }),
                      child: textWidget(context, 'Başga wagt', false, sp * 20,
                          Colors.grey[600]),
                    )
                  ],
                ),
                if (_servicesTime == 2) const MyDate(),
                SizedBox(height: h * 0.02),
                if (_servicesTypeId == 0)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidget(context, 'Eltip bermek üçin salgyňyz', true,
                          sp * 20, Colors.grey[600]),
                      SizedBox(height: h * 0.01),
                      Container(
                        margin: EdgeInsets.only(right: w * 0.01),
                        child: TextField(
                          controller: _controllerDelivery,
                          minLines: 2,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Salgyňyzy giriziň',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.brown, width: w * 0.007)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                Padding(
                  padding: EdgeInsets.only(top: h * 0.02, bottom: h * 0.01),
                  child: textWidget(context, 'Tölegiň görnüşi', true, sp * 20,
                      Colors.grey[600]),
                ),
                Row(
                  children: [
                    paymentType(context, sp, 0),
                    paymentType(context, sp, 1)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: h * 0.02, bottom: h * 0.01),
                  child: textWidget(
                      context, 'Adyňyz', true, sp * 20, Colors.grey[600]),
                ),
                Container(
                  padding: EdgeInsets.only(right: w * 0.01),
                  child: TextField(
                    controller: _controllerName,
                    decoration: InputDecoration(
                      hintText: 'Adyňyzy giriziň',
                      hintStyle: TextStyle(color: Colors.grey[300]),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.brown, width: w * 0.007)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: h * 0.02, bottom: h * 0.01),
                  child: textWidget(context, 'Telefon belgiňiz', true, sp * 20,
                      Colors.grey[600]),
                ),
                const TelInput(),
                Padding(
                  padding: EdgeInsets.only(top: h * 0.02, bottom: h * 0.01),
                  child: textWidget(context, 'Bellikleriňiz', true, sp * 20,
                      Colors.grey[600]),
                ),
                Container(
                  margin: EdgeInsets.only(right: w * 0.01),
                  child: TextField(
                    controller: _controllerNotes,
                    minLines: 2,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Bellikleriňizi ýazyň',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.brown, width: w * 0.007)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          orderSubmit(postOrder, h, w, context, sp, readyTime, _productData),
        ],
      ),
    );
  }

  Row paymentType(BuildContext context, double sp, value) {
    return Row(
      children: [
        Radio(
          value: value,
          activeColor: Colors.brown,
          groupValue: _paymentTypeId,
          onChanged: ((id) => setState(() {
                _paymentTypeId = id!;
              })),
        ),
        InkWell(
          onTap: () => setState(() {
            _paymentTypeId = value;
          }),
          child: textWidget(context, paymentTypeNames[value], false, sp * 20,
              Colors.grey[600]),
        ),
      ],
    );
  }

  Column placeDropdownButton(BuildContext context, double sp, double h,
      double w, Future<dynamic> Function() getPlace) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWidget(context, 'Ýer', true, sp * 20, Colors.grey[600]),
        SizedBox(height: h * 0.01),
        Container(
          height: h * 0.055,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.only(left: w * 0.02),
          child: FutureBuilder(
              future: getPlace(),
              builder: (context, place) {
                if (place.data != null) {
                  return MyDropdownButton(places: place.data);
                } else {
                  return Container();
                }
              }),
        ),
      ],
    );
  }

  Row servicesType(BuildContext context, double sp, int value) {
    return Row(
      children: [
        Radio(
          activeColor: Colors.brown,
          value: value,
          groupValue: _servicesTypeId,
          onChanged: (id) => setState(() {
            _servicesTypeId = id!;
          }),
        ),
        InkWell(
            onTap: () => setState(() {
                  _servicesTypeId = value;
                }),
            child: textWidget(context, servicesTypeNames[value], false, sp * 18,
                Colors.grey[600])),
      ],
    );
  }

  InkWell orderSubmit(
    Function postOrder,
    double h,
    double w,
    BuildContext context,
    double sp,
    Future<int> Function() readyTime,
    productData,
  ) {
    return InkWell(
      onTap: () {
        setState(() {
          postOrder(
              servicesTypeNames[_servicesTypeId],
              _controllerDelivery.text,
              paymentTypeNames[_paymentTypeId],
              _controllerName.text,
              _controllerNotes.text,
              productData);
        });
      },
      child: Container(
        width: double.maxFinite,
        height: _servicesTypeId == 0 ? h * 0.15 : h * 0.1,
        color: Colors.brown,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Row(
            children: [
              Container(
                alignment: Alignment.topLeft,
                height: _servicesTypeId == 0 ? h * 0.14 : h * 0.1,
                width: w * 0.5,
                child: Column(
                  children: [
                    if (_servicesTypeId == 0)
                      Row(
                        children: [
                          textWidget(context, 'Harytlar: ', false, sp * 18,
                              Colors.white),
                          textWidget(
                              context, '29.00 ', true, sp * 20, Colors.white),
                          textWidget(
                              context, 'TMT', false, sp * 18, Colors.white),
                          SizedBox(height: h * 0.02),
                        ],
                      ),
                    if (_servicesTypeId == 0)
                      Row(
                        children: [
                          textWidget(context, 'Eltip bermek: ', false, sp * 18,
                              Colors.white),
                          textWidget(
                              context, '15.00 ', true, sp * 20, Colors.white),
                          textWidget(
                              context, 'TMT', false, sp * 18, Colors.white),
                          SizedBox(height: h * 0.02),
                        ],
                      ),
                    Row(
                      children: [
                        textWidget(
                            context, 'Jemi: ', false, sp * 18, Colors.white),
                        textWidget(
                            context, '44.00 ', true, sp * 20, Colors.white),
                        textWidget(
                            context, 'TMT', false, sp * 18, Colors.white),
                        SizedBox(height: h * 0.02),
                      ],
                    ),
                    Row(
                      children: [
                        textWidget(
                            context, 'Wagty: ', false, sp * 18, Colors.white),
                        FutureBuilder(
                            future: readyTime(),
                            builder: (context, time) {
                              return textWidget(
                                  context,
                                  _servicesTime == 1
                                      ? _servicesTypeId == 0
                                          ? ' ~${(time.data ?? 0) + 30} '
                                          : ' ~${time.data} '
                                      : '${dateTime.day}-${dateTime.month},${dateTime.hour}:${dateTime.minute} ',
                                  true,
                                  sp * 20,
                                  Colors.white);
                            }),
                        textWidget(
                            context, 'min', false, sp * 18, Colors.white),
                        SizedBox(height: h * 0.02),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.centerRight,
                height: h * 0.2,
                width: w * 0.4,
                child: textWidget(
                    context, 'Sargyt et >', true, sp * 25, Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget textWidget(
  BuildContext context,
  String name,
  bool isBold,
  double size,
  Color? color,
) =>
    Text(
      name,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: isBold == true ? FontWeight.bold : FontWeight.normal,
      ),
    );

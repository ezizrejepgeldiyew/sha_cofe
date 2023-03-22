import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sa_kofe/view/home/components/carousel_slider/banner_card.dart';
import 'package:sa_kofe/view/model/ad_banner.dart';

class CarouselSliderView extends StatefulWidget {
  final List<AdBanner> bannerList;
  const CarouselSliderView({super.key, required this.bannerList});

  @override
  State<CarouselSliderView> createState() => _CarouselSliderViewState();
}

class _CarouselSliderViewState extends State<CarouselSliderView> {
  int _currenIndex = 0;
  late List<Widget> _bannerList;
  @override
  void initState() {
    super.initState();
    _bannerList =
        widget.bannerList.map((e) => BannerCard(imageUrl: e.image)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: _bannerList,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              onPageChanged: ((index, reason) {
                setState(() {
                  _currenIndex = index;
                });
              })),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.bannerList.map((e) {
            int index = widget.bannerList.indexOf(e);
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currenIndex == index
                      ? const Color.fromRGBO(0, 0, 0, 0.9)
                      : const Color.fromRGBO(0, 0, 0, 0.4)),
            );
          }).toList(),
        )
      ],
    );
  }
}

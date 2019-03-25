import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarousel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    const imgList = [
      "https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX32406967.jpg",
      "https://smartpharmaconsulting.com/wp-content/uploads/2018/04/pharma-banner-post-image-1280x640.jpg",
      "https://i0.wp.com/pharmacyconnection.ca/wp-content/uploads/2018/01/disposal_medication.jpg?fit=1500%2C750&ssl=1"
    ];

    return CarouselSlider(
      height: 160.0,
      autoPlay: true,
      reverse: false,
      autoPlayInterval: Duration(seconds: 4),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      aspectRatio: 16/9,
      viewportFraction: 0.9,
      enlargeCenterPage: false,
      pauseAutoPlayOnTouch: Duration(seconds: 10),
      items: imgList.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: FadeInImage(
                    image: NetworkImage(url),
                    height: 160.0,
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/background.jpg'),
                  )
                ),
            );
          },
        );
      }).toList(),
    );
  }
}
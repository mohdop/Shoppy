import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final urlImages = [
  "https://assets-prd.ignimgs.com/2021/11/25/best-apple-deals-in-the-uk-black-friday-1637853204173.png",
  "https://www.trustedreviews.com/wp-content/uploads/sites/54/2022/12/Best-iPhone-Deals.png",
  "https://www.digitaltrends.com/wp-content/uploads/2022/07/Best_Prime_Day_iPhone_Deals_Thumbnail-2022.png?fit=720%2C479&p=1",
  "https://www.leparisien.fr/resizer/MgU3LI5JHHYo8tcuXVZ8RY5jN5Q=/932x582/cloudfront-eu-central-1.images.arcpublishing.com/lpguideshopping/WATJGWWJWV2YBA6AXRGA5SAEYU.png"
];


Widget appBar(){
  return Padding(
    padding: const EdgeInsets.only(top: 48.0,left: 12),
    child: Container(
      width: double.infinity,
      child: Row(
        children: [
          Icon(Icons.menu,color: Colors.black,size: 28,),
          Padding(
            padding: const EdgeInsets.only(left: 118.0),
            child: Text("Shoppy",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 118.0),
            child:IconButton(icon:Icon(Icons.search_rounded,color: Colors.black,size: 31,),onPressed: () {},),
          )
        ],
      ),
    ),
  );
}

Widget caroussel() {
  return Padding(
    padding: const EdgeInsets.only(top: 48.0),
    child: CarouselSlider.builder(
      itemCount: urlImages.length,
      itemBuilder: (context, index, realIndex) {
        final urlImage = urlImages[index];
        return buildImage(urlImage, index);
      },
      options: CarouselOptions(
        height: 215,
        autoPlay: true,
        pauseAutoPlayOnTouch: true,
        viewportFraction: 1.0, // Show only one item at a time
        enlargeCenterPage: false, // Do not enlarge the center item
      ),
    ),
  );
}

Widget buildImage(String urlImage, int index) => Container(
  width: double.infinity, // Take up the entire width
  color: Colors.grey,
  child: Image.network(
    urlImage,
    fit: BoxFit.cover,
  ),
);

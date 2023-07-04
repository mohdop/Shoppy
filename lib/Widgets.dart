import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'models/product.dart';

final urlImages = [
  "https://assets-prd.ignimgs.com/2021/11/25/best-apple-deals-in-the-uk-black-friday-1637853204173.png",
  "https://www.trustedreviews.com/wp-content/uploads/sites/54/2022/12/Best-iPhone-Deals.png",
  "https://www.digitaltrends.com/wp-content/uploads/2022/07/Best_Prime_Day_iPhone_Deals_Thumbnail-2022.png?fit=720%2C479&p=1",
  "https://www.leparisien.fr/resizer/MgU3LI5JHHYo8tcuXVZ8RY5jN5Q=/932x582/cloudfront-eu-central-1.images.arcpublishing.com/lpguideshopping/WATJGWWJWV2YBA6AXRGA5SAEYU.png"
];


Widget appBar(){
  return  SliverAppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    title: Text(
      "Shoppy",
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
    leading: Icon(Icons.menu, color: Colors.black, size: 28),
    actions: [
      IconButton(
        icon: Icon(Icons.search_rounded),
        onPressed: () {},
      ),
    ],
    floating: true,
    pinned: true,
    snap: true,
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

Widget cat(String categ) {
  return StreamBuilder<List<Product>>(
    stream: readHotDeals(categ),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }

      final hotDeals = snapshot.data;
      if (hotDeals == null || hotDeals.isEmpty) {
        return Text('');
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: hotDeals.map((product) => buildProduct(product)).toList(),
        ),
      );
    },
  );
}



Stream<List<Product>> readHotDeals(String categ) {
  final category = categ.toUpperCase();
  if (category != "") {
    return FirebaseFirestore.instance
        .collection('product')
        .where('category', isEqualTo: category)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList());
  }
  return Stream.value([]); // Return an empty stream if the category is null
}
Widget section(String section){
  return Padding(
    padding: const EdgeInsets.only(right:12.0,left: 12,top: 20),
    child: Container(
      width: double.infinity,
      child: Row(
        children: [
          Text(section,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          Spacer(),
          Text("SEE ALL",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 18,decoration: TextDecoration.underline),)
        ],
      ),
    ),
  );
}


Widget buildProduct(Product product) {
  return  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        boxShadow:[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12)),
      child:  Stack(
        children: [
          SizedBox(
            height: 150,
            width: 200,
            child: Image.network(product.image, fit: BoxFit.contain,)),
          Padding(
            padding: const EdgeInsets.only(top:168.0,left: 12),
            child: Row(
              children: [
                Text(product.name,style: TextStyle(fontSize: 18)),
                SizedBox(width: 28,),
                FaIcon(FontAwesomeIcons.bookmark, size: 20,),
              ],
            ),
          ),Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:198.0,left: 12),
                child: Text("${product.price} \$", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              )
            ],
          ),Padding(
            padding: const EdgeInsets.only(top:218.0,left: 12,bottom: 20),
            child: Row(
              children: [
                 FaIcon(FontAwesomeIcons.star, size: 16),
                              SizedBox(width: 6),
                              Text("4.9", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    ),
  );
}


Widget bottom(){
  return  BottomNavigationBar(
    fixedColor: Colors.orange,
    showUnselectedLabels: true,
    unselectedItemColor: Colors.black,
    items:const [
      BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.house),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.solidBookmark,),
        label: 'WishList',
      ),
      BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.shapes,),
        label: 'Category',
      ),
      BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.user,),
        label: 'Account',
      ),
      BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.bagShopping,),
        label: 'Cart',
      ),
    ],
  );
}
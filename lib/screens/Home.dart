import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/Widgets.dart';
import 'package:shoppy/models/product.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottom(),
      body: CustomScrollView(
        slivers: [
         appBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              caroussel(),
              section("HOT DEALS"),
              cat("HOT DEALS"),
              section("MOST POPULAR"),
              cat("MOST POPULAR"),
            ]),
          ),
        ],
      ),
    );
  }
}

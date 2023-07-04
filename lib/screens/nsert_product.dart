import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:shoppy/models/product.dart';

class Insert extends StatefulWidget {
  const Insert({Key? key}) : super(key: key);

  @override
  State<Insert> createState() => _InsertState();
}

class _InsertState extends State<Insert> {
  PlatformFile? pickedFile;
  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future<void> uploadFile() async {
    if (pickedFile == null) return;
    final path = "images/${pickedFile!.name}";
    final file = File(pickedFile!.path!);
    final ref = firebase_storage.FirebaseStorage.instance.ref().child(path);
    await ref.putFile(file);
    final imageUrl = await ref.getDownloadURL();
    // Create the product with the image URL
    final product = Product(
      name: nameController.text,
      description: descriptionController.text,
      price: int.parse(priceController.text),
      category: categoryController.text,
      image: imageUrl,
    );
    await createProduct(product);
  }

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              if (pickedFile != null)
                Container(
                  color: Colors.blue[100],
                  child: Center(
                    child: Text(pickedFile!.name),
                  ),
                ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: selectFile,
                child: Text("Select File"),
              ),
              SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: "Name of the product"),
              ),
              SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration:
                    InputDecoration(hintText: "Description of the product"),
              ),
              SizedBox(height: 16),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Price of the product"),
              ),
              SizedBox(height: 16),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(hintText: "Category of the product"),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: uploadFile,
                child: Text("Create Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createProduct(Product product) async {
    final docProduct = FirebaseFirestore.instance.collection("product").doc();
    product.id = docProduct.id;
    final json = product.toJson();
    await docProduct.set(json);
  }
}

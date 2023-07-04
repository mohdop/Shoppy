class Product {
  String id;
  final String name;
  final String description;
  final int price;
  final String category;
  final String image; // New parameter for the image

  Product({
    this.id = '',
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "name": this.name,
        "description": this.description,
        "price": this.price,
        "category": this.category,
        "image": this.image, 
      };

  static Product fromJson(Map<dynamic, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        category: json["category"],
        image: json["image"],
      );
}

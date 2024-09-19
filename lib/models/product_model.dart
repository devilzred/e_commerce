
class Product {
  final int productId;
  final String name;
  final String description;
  final double price;
  final String unit;
  final String image;
  final int discount;
  final bool availability;
  final String brand;
  final String category;
  final double rating;
  final List<Review> reviews;

  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.unit,
    required this.image,
    required this.discount,
    required this.availability,
    required this.brand,
    required this.category,
    required this.rating,
    required this.reviews,
  });

  double get discountedPrice {
    return price * (1 - discount / 100);
  }

  String get categoryImage {
    switch (productId) {
      case 1:
        return 'assets/images/electronics_1.jpg';
      case 2:
        return 'assets/images/electronics_2.jpg';
      case 3:
        return 'assets/images/electronics_3.jpg';
      case 4:
        return 'assets/images/wearables_1.jpg';
      case 5:
        return 'assets/images/cameras_1.jpg';
      case 6:
        return 'assets/images/electronics_4.jpg';
      case 7:
        return 'assets/images/electronics_5.jpg';
      case 8:
        return 'assets/images/gaming_1.jpg';
      case 9:
        return 'assets/images/appliances_1.jpg';
      default:
        return 'assets/images/placeholder.jpg';
    }
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    var reviewsList = json['reviews'] as List?;
    List<Review> reviews = reviewsList != null 
        ? reviewsList.map((i) => Review.fromJson(i)).toList() 
        : [];

    return Product(
      productId: json['product_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      unit: json['unit'],
      image: json['image'],
      discount: json['discount'],
      availability: json['availability'],
      brand: json['brand'],
      category: json['category'],
      rating: json['rating'].toDouble(),
      reviews: reviews,
    );
  }
}

class Review {
  final int userId;
  final int rating;
  final String comment;

  Review({required this.userId, required this.rating, required this.comment});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userId: json['user_id'],
      rating: json['rating'],
      comment: json['comment'],
    );
  }
}
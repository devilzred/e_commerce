import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/controllers/product_controller.dart';
import 'product_details_screen.dart';

class HomeScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.greenAccent,
        elevation: 2,
        title: const Center(child: Text('E-commerce App')),
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (productController.productList.isEmpty) {
          return Center(child: Text('No products found.'));
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategorySection('New Arrivals', productController.productList.take(5).toList()),
                _buildCategorySection('Trending Products', productController.productList.skip(5).take(5).toList()),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildCategorySection(String title, List<Product> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        AnimatedProductList(products: products),
      ],
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailsScreen(product: product));
      },
      child: Card(
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                product.categoryImage,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 8),
              Text(
                product.name,
                style: TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey),
              ),
              Text(
                '\$${product.discountedPrice.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ),
              Text(product.brand),
              Row(
                children: [
                  Icon(Icons.star, size: 16, color: Colors.amber),
                  Text(product.rating.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedProductList extends StatefulWidget {
  final List<Product> products;

  AnimatedProductList({required this.products});

  @override
  _AnimatedProductListState createState() => _AnimatedProductListState();
}

class _AnimatedProductListState extends State<AnimatedProductList> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 280,
          child: PageView.builder(
            controller: _pageController,
            itemCount: (widget.products.length / 2).ceil(),
            itemBuilder: (context, pageIndex) {
              return Row(
                children: [
                  for (var i = pageIndex * 2; i < (pageIndex + 1) * 2; i++)
                    if (i < widget.products.length)
                      Expanded(child: _buildProductCard(widget.products[i]))
                ],
              );
            },
          ),
        ),
        SizedBox(height: 8),
        _buildAnimatedScrollIndicator(),
      ],
    );
  }

  Widget _buildAnimatedScrollIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        (widget.products.length / 2).ceil(),
        (index) => AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: _currentPage == index ? 24 : 8,
          decoration: BoxDecoration(
            color: _currentPage == index ? Colors.green : Colors.grey,
            borderRadius: BorderRadius.circular(4),
            boxShadow: _currentPage == index
                ? [BoxShadow(color: Colors.green.withOpacity(0.3), blurRadius: 4, spreadRadius: 1)]
                : [],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailsScreen(product: product));
      },
      child: Card(
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                product.categoryImage,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 8),
              Text(
                product.name,
                style: TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey),
              ),
              Text(
                '\$${product.discountedPrice.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ),
              Text(product.brand),
              Row(
                children: [
                  Icon(Icons.star, size: 16, color: Colors.amber),
                  Text(product.rating.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
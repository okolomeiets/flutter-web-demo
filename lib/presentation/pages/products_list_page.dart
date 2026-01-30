import 'package:flutter/material.dart';

import '../../data/products_api.dart';
import '../../domain/models/product.dart';
import 'product_details_page.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  final _api = ProductsApi();
  late final Future<List<Product>> _future = _api.fetchProducts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: FutureBuilder<List<Product>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final products = snapshot.data ?? const <Product>[];
          return ListView.separated(
            itemCount: products.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final p = products[index];
              return ListTile(
                leading: p.thumbnail == null
                    ? const SizedBox(width: 56, height: 56)
                    : Image.network(
                        p.thumbnail!,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                      ),
                title: Text(p.title),
                subtitle: Text('\$${p.price}'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProductDetailsPage(productId: p.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

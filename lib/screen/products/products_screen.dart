import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compara_precos/screen/common/custom_drawer/custom_drawer.dart';
import 'package:compara_precos/screen/product/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/product.dart';
import '../../service/product_service.dart';
import 'components/product_card.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductService>(
      builder: (_, productService, __) {
        return Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
            automaticallyImplyLeading: !productService.loading,
            title: Text('Produtos'),
            centerTitle: true,
          ),
          body: (productService.loading)
              ? Center(child: CircularProgressIndicator())
              : Container(
                  child: StreamBuilder<QuerySnapshot<Product>>(
                    stream: productService.getStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return Text("Ocorreu um erro inesperado");
                            });
                      }

                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      final data = snapshot.requireData;

                      return Container(
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount: data.docs.length,
                          itemBuilder: (_, index) {
                            Product object = data.docs[index].data();
                            return ProductCard(product: object, index: index);
                          },
                        ),
                      );
                    },
                  ),
                ),
          floatingActionButton: productService.loading
              ? CircularProgressIndicator()
              : FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(ProductScreen.route_name,
                        arguments: Product.empty());
                  },
                  child: Icon(Icons.add_sharp)),
        );
      },
    );
  }
}

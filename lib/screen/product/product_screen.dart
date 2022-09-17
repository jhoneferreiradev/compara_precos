import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/product.dart';
import '../../service/product_service.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({required this.product});

  final Product product;

  static const String route_name = '/product';

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductService>(builder: (_, productService, __) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: !productService.loading,
          title: Text(widget.product.isSaved
              ? 'Editando Produto'
              : 'Incluindo Produto'),
          centerTitle: true,
          actions: [
            if (productService.loading)
              TextButton(
                  onPressed: () {},
                  child: CircularProgressIndicator(color: Colors.white))
            else
              IconButton(
                  onPressed: () {
                    if (!productService.loading) {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        productService.save(widget.product, () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Operação realizada com sucesso")));
                          Navigator.of(context).pop();
                        });
                      }
                    }
                  },
                  icon: Icon(Icons.save))
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      initialValue: widget.product.name,
                      enabled: !productService.loading,
                      decoration: const InputDecoration(label: Text("Nome")),
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      onSaved: (text) => widget.product.name = text,
                      validator: (text) {
                        return (text == null || text.isEmpty)
                            ? "Campo obrigatório"
                            : null;
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

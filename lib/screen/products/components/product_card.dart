import 'package:compara_precos/screen/product/product_screen.dart';
import 'package:compara_precos/service/product_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/product.dart';

class ProductCard extends StatefulWidget {
  ProductCard({required this.product, required this.index});

  Product product;
  int index;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final backgrouncColorCard =
        (widget.index % 2 == 0) ? Colors.white24 : Colors.white70;

    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).clearSnackBars();

        widget.product.isGlobal
            ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text("Não é possível editar produto interno do sistema.")))
            : ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: primaryColor,
                  content: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        height: widget.product.isNotGlobal ? 150 : 50,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              const Text(
                                "Ações",
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    Navigator.of(context).pushNamed(
                                        ProductScreen.route_name,
                                        arguments: widget.product);
                                  },
                                  child: Text("Editar"),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: primaryColor)),
                              ElevatedButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return Center(
                                          child: Container(
                                            height: 150,
                                            color: Colors.white,
                                            padding: EdgeInsets.all(8),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Text(
                                                      "Tem certeza que deseja remover este item?",
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text("Não"),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                foregroundColor:
                                                                    primaryColor),
                                                      ),
                                                    ),
                                                    SizedBox(width: 30),
                                                    Expanded(
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                          context
                                                              .read<
                                                                  ProductService>()
                                                              .delete(widget
                                                                  .product);
                                                        },
                                                        child: Text("Sim"),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .redAccent,
                                                                foregroundColor:
                                                                    Colors
                                                                        .white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Text("Remover"),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      foregroundColor: Colors.white)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
      },
      child: Card(
        color: backgrouncColorCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Container(
          height: 75,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.product.name!,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                        if (widget.product.isGlobal)
                          Icon(Icons.verified_user_sharp)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

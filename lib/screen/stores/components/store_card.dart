import 'package:compara_precos/screen/store/store_screen.dart';
import 'package:compara_precos/service/store_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/store.dart';

class StoreCard extends StatefulWidget {
  StoreCard({required this.store, required this.index});

  Store store;
  int index;

  @override
  State<StoreCard> createState() => _StoreCardState();
}

class _StoreCardState extends State<StoreCard> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final backgrouncColorCard =
        (widget.index % 2 == 0) ? Colors.white24 : Colors.white70;

    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).clearSnackBars();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: primaryColor,
            content: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  height: 150,
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
                              Navigator.of(context).pushNamed(
                                  StoreScreen.route_name,
                                  arguments: widget.store);
                            },
                            child: Text("Editar"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: primaryColor)),
                        ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).clearSnackBars();
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text(
                                                "Tem certeza que deseja remover este item?",
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Não"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.white,
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
                                                        .read<StoreService>()
                                                        .delete(widget.store);
                                                  },
                                                  child: Text("Sim"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.redAccent,
                                                          foregroundColor:
                                                              Colors.white),
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
                          widget.store.name!,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
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

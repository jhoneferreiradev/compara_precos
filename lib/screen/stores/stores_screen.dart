import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compara_precos/screen/common/custom_drawer/custom_drawer.dart';
import 'package:compara_precos/screen/store/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/store.dart';
import '../../service/store_service.dart';
import 'components/store_card.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({Key? key}) : super(key: key);

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StoreService>(
      builder: (_, storeService, __) {
        return Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
                automaticallyImplyLeading: !storeService.loading,
              title: Text('Lojas'),
              centerTitle: true,
            ),
            body: (storeService.loading)
                ? Center(child: CircularProgressIndicator())
                : Container(
              child: StreamBuilder<QuerySnapshot<Store>>(
                stream: storeService.getStream(),
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
                        Store object = data.docs[index].data();
                        return StoreCard(store: object, index: index);
                      },
                    ),
                  );
                },
              ),
            ),

            floatingActionButton:
            storeService.loading ?
                CircularProgressIndicator() :
        FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(StoreScreen.route_name,
                  arguments: Store.empty());
            },
            child: Icon(Icons.add_sharp))
        ,
        );
      },
    );
  }
}

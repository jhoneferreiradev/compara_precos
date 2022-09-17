import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/store.dart';
import '../../service/store_service.dart';
import '../helpers/validators.dart';

class StoreScreen extends StatefulWidget {
  StoreScreen({required this.store});

  final Store store;

  static const String route_name = '/store';

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    return Consumer<StoreService>(builder: (_, storeService, __) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: !storeService.loading,
          title: Text(widget.store.isSaved
              ? 'Editando Loja'
              : 'Incluindo Loja'),
          centerTitle: true,
          actions: [
            if (storeService.loading)
              TextButton(
                  onPressed: () {},
                  child: CircularProgressIndicator(color: Colors.white))
            else
              IconButton(
                  onPressed: () {
                    if (!storeService.loading) {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        storeService.save(widget.store, () {
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
                      initialValue: widget.store.name,
                      enabled: !storeService.loading,
                      decoration: const InputDecoration(label: Text("Nome")),
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      onSaved: (text) => widget.store.name = text,
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../domain/product.dart';
import '../helpers/util.dart';
import 'local_user_service.dart';

class ProductService extends ChangeNotifier {
  bool loading = false;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final productRef = FirebaseFirestore.instance
      .collection('products')
      .where('local_user_id', whereIn: getLocalUserIdOrGlobal())
      .orderBy('name', descending: false)
      .withConverter<Product>(
        fromFirestore: (snapshots, _) {
          Product object = Product.fromJson(snapshots.data()!);
          object.id = snapshots.id;
          return object;
        },
        toFirestore: (object, _) => object.toJson(),
      );

  Stream<QuerySnapshot<Product>> getStream() {
    print(LocalUserService.localUserIdLogged);
    return productRef.snapshots();
  }

  Future<void> save(Product product, Function onSuccess) async {
    setLoading(true);
    await firestore
        .collection("products")
        .doc(product.id)
        .set(product.toJson());
    setLoading(false);
    onSuccess();
  }

  void setLoading(bool value) {
    this.loading = value;
    notifyListeners();
  }

  Future<void> delete(Product product) async {
    setLoading(true);
    await firestore.collection('products').doc(product.id).delete();
    setLoading(false);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compara_precos/service/local_user_service.dart';
import 'package:flutter/foundation.dart';

import '../domain/store.dart';
import '../helpers/util.dart';

class StoreService extends ChangeNotifier {
  bool loading = false;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final storeRef = FirebaseFirestore.instance
      .collection("users")
      .doc(LocalUserService.localUserIdLogged)
      .collection('stores')
      .orderBy('name', descending: false)
      .withConverter<Store>(
        fromFirestore: (snapshots, _) {
          Store object = Store.fromJson(snapshots.data()!);
          object.id = snapshots.id;
          return object;
        },
        toFirestore: (object, _) => object.toJson(),
      );

  Stream<QuerySnapshot<Store>> getStream() {

    return storeRef.snapshots();
  }

  Future<void> save(Store store, Function onSuccess) async {
    setLoading(true);
    await firestore.collection("users")
        .doc(LocalUserService.localUserIdLogged).collection("stores").doc(store.id).set(store.toJson());
    setLoading(false);
    onSuccess();
  }

  void setLoading(bool value) {
    this.loading = value;
    notifyListeners();
  }

  Future<void> delete(Store store) async {
    setLoading(true);
    await firestore.collection("users")
        .doc(LocalUserService.localUserIdLogged).collection('stores').doc(store.id).delete();
    setLoading(false);
  }
}

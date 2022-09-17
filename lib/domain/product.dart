import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compara_precos/service/local_user_service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(ignore: true)
  String? id;
  String? name;
  @JsonKey(name: "local_user_id")
  String? localUserId;
  bool? disabled;

  Product({this.id, this.name});

  bool get isGlobal => (localUserId != null &&
      localUserId!.isNotEmpty &&
      localUserId! == 'GLOBAL');

  bool get isNotGlobal => !isGlobal;

  bool get isSaved => id != null;

  factory Product.fromJson(Map<String, dynamic> srcJson) =>
      _$ProductFromJson(srcJson);

  factory Product.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    Product object =
        Product.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    object.id = documentSnapshot.id;
    return object;
  }

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  factory Product.empty() {
    Product p = Product();
    p.localUserId = LocalUserService.localUserIdLogged;
    p.disabled = false;
    return p;
  }
}

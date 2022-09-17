import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'store.g.dart';

@JsonSerializable()
class Store {
  @JsonKey(ignore: true)
  String? id;
  String? name;
  bool? disabled;

  Store({this.id, this.name});

  bool get isSaved => id != null;

  factory Store.fromJson(Map<String, dynamic> srcJson) =>
      _$StoreFromJson(srcJson);

  factory Store.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    Store object =
    Store.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    object.id = documentSnapshot.id;
    return object;
  }

  Map<String, dynamic> toJson() => _$StoreToJson(this);

  factory Store.empty() {
    Store p = Store();
    p.disabled = false;
    return p;
  }
}

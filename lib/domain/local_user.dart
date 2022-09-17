
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'local_user.g.dart';

@JsonSerializable()
class LocalUser {

  @JsonKey(ignore: true)
  String? id;

  String? name;
  String? email;

  @JsonKey(ignore: true)
  String? password;

  @JsonKey(ignore: true)
  String? confirmationPassword;

  LocalUser({this.id, this.name, this.email, this.password, this.confirmationPassword});

  factory LocalUser.fromJson(Map<String, dynamic> srcJson) =>
      _$LocalUserFromJson(srcJson);

  factory LocalUser.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    LocalUser user =
        LocalUser.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    user.id = documentSnapshot.id;
    return user;
  }

  Map<String, dynamic> toJson() => _$LocalUserToJson(this);
}

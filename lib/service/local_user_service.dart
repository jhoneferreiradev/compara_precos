import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compara_precos/domain/local_user.dart';
import 'package:compara_precos/helpers/firebase_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LocalUserService extends ChangeNotifier {
  LocalUserService({this.firebaseUserConnected}) {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? firebaseUserConnected;
  LocalUser? localUser;

  bool _loading = false;

  bool get loading => _loading;

  bool get isLoggedIn => localUser != null;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  static String localUserIdLogged = '';

  Future<void> _loadCurrentUser({User? firebaseUser}) async {
    DocumentSnapshot docUser;

    if (firebaseUser != null) {
      docUser = await firestore.collection('users').doc(firebaseUser.uid).get();
      localUser = LocalUser.fromDocumentSnapshot(docUser);
      LocalUserService.localUserIdLogged = localUser!.id!;
    } else {
      auth.authStateChanges().listen((User? currentFirebaseUser) async {
        if (currentFirebaseUser != null) {
          final DocumentSnapshot docUser = await firestore
              .collection('users')
              .doc(currentFirebaseUser.uid)
              .get();
          localUser = LocalUser.fromDocumentSnapshot(docUser);
          LocalUserService.localUserIdLogged = localUser!.id!;
        } else {
          LocalUserService.localUserIdLogged = '';
        }
      });
    }

    notifyListeners();
  }

  Future<void> signIn(
      {required LocalUser localUser,
      required Function onFail,
      required Function onSuccess}) async {
    setLoading(true);


    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
              email: localUser.email!, password: localUser.password!);

      await _loadCurrentUser(firebaseUser: userCredential.user);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    } on Exception catch (e) {
      onFail('Um erro indefinido ocorreu.');
    } finally {
      setLoading(false);
    }
  }

  Future<void> signUp(
      {required LocalUser localUser,
      required Function onFail,
      required Function onSuccess}) async {
    setLoading(true);

    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
              email: localUser.email!, password: localUser.password!);

      atualizarUserFirebaseConnected(userCredential.user!);
      localUser.id = firebaseUserConnected!.uid;
      saveLocalUser(localUser);
      this.localUser = localUser;
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    } on Exception catch (e) {
      print(e);
      onFail('Um erro indefinido ocorreu.');
    } finally {
      setLoading(false);
    }
  }

  signOut({Function? onSuccess}) {
    auth.signOut();
    localUser = null;
    firebaseUserConnected = null;
    notifyListeners();
    if (onSuccess != null) onSuccess();
  }

  atualizarUserFirebaseConnected(User newFirebaseUserConnected) {
    this.firebaseUserConnected = newFirebaseUserConnected;
  }

  Future<void> saveLocalUser(LocalUser user) async {
    await getDocumentReferenceFor(user).set(user.toJson());
  }

  DocumentReference getDocumentReferenceFor(LocalUser user) {
    return firestore.doc('users/' + user.id!);
  }

  void toValidUserLogged(Function() onLoggedOut) {
    if (!isLoggedIn) onLoggedOut();
  }
}

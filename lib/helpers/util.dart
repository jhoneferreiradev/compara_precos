import '../service/local_user_service.dart';

List<String> getLocalUserIdOrGlobal() {
  return <String>['GLOBAL', LocalUserService.localUserIdLogged];
}
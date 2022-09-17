import 'package:compara_precos/service/local_user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../login/login_screen.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Consumer<LocalUserService>(builder: (_, localUserService, __) {

      return Container(
        padding: EdgeInsets.fromLTRB(32, 24, 16, 8),
        height: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Comparador de Preço",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
            Text(
              "Olá, ${localUserService.localUser?.name ?? ''}",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
            GestureDetector(
              onTap: () {
                localUserService.isLoggedIn
                    ? localUserService.signOut(onSuccess: () {})
                    : null;

                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.route_name);
              },
              child: Text(
                localUserService.isLoggedIn ? "Sair" : "Entre ou cadastre-se >",
                style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    });
  }
}

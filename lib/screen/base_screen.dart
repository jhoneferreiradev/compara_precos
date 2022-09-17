import 'package:compara_precos/screen/models/page_manager.dart';
import 'package:compara_precos/screen/stores/stores_screen.dart';
import 'package:compara_precos/service/local_user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/custom_drawer/custom_drawer.dart';
import 'login/login_screen.dart';
import 'products/products_screen.dart';

class BaseScreen extends StatelessWidget {
  static const String route_name = '/base';

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalUserService>(builder: (_, localUserService, __) {
      return !localUserService.isLoggedIn
          ? LoginScreen()
          : Provider(
              create: (_) => PageManager(pageController),
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Scaffold(
                    drawer: CustomDrawer(),
                    appBar: AppBar(
                      title: const Text("Início"),
                    ),
                    body: Container(),
                  ),
                  Scaffold(
                      drawer: CustomDrawer(),
                      appBar: AppBar(
                        title: const Text("Listas de compra"),
                      ),
                      body: Container()),
                  ProductsScreen(),
                  StoresScreen(),
                ],
              ),
            );
    });
  }
}

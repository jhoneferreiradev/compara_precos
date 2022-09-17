import 'package:compara_precos/screen/common/custom_drawer/custom_drawer_header.dart';
import 'package:flutter/material.dart';

import 'drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 203, 236, 241), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
          ),
          ListView(
            children: const [
              CustomDrawerHeader(),
              Divider(),
              DrawerTile(iconData: Icons.home, title: "Início", page: 0),
              DrawerTile(
                iconData: Icons.playlist_add_check,
                title: "Listas de compra",
                page: 1,
              ),
              DrawerTile(
                iconData: Icons.list,
                title: "Produtos",
                page: 2,
              ),
              DrawerTile(
                iconData: Icons.store_mall_directory_sharp,
                title: "Lojas",
                page: 3,
              )
            ],
          ),
        ],
      ),
    );
  }
}

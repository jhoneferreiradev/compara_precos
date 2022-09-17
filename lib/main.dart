import 'package:compara_precos/firebase_options.dart';
import 'package:compara_precos/screen/base_screen.dart';
import 'package:compara_precos/screen/login/login_screen.dart';
import 'package:compara_precos/screen/product/product_screen.dart';
import 'package:compara_precos/screen/signup/signup_screen.dart';
import 'package:compara_precos/screen/store/store_screen.dart';
import 'package:compara_precos/service/local_user_service.dart';
import 'package:compara_precos/service/store_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain/product.dart';
import 'domain/store.dart';
import 'service/product_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ComparaPrecoApp());
}

class ComparaPrecoApp extends StatelessWidget {
  ComparaPrecoApp({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final primaryColor = const Color.fromARGB(255, 4, 125, 141);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocalUserService(), lazy: false),
        ChangeNotifierProvider(create: (_) => ProductService()),
        ChangeNotifierProvider(create: (_) => StoreService())
      ],
      child: MaterialApp(
        title: 'Comparador de Preços',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primaryColor,
          scaffoldBackgroundColor: Colors.white/* const Color.fromARGB(255, 4, 125, 141) */,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: primaryColor
            //backgroundColor: Colors.red
          ),
          appBarTheme: const AppBarTheme(
            color: Color.fromARGB(255, 4, 125, 141),
            elevation: 0,
          ),
        ),
        initialRoute: BaseScreen.route_name,
        onGenerateRoute: (route) {
          switch (route.name) {
            case StoreScreen.route_name:
              return MaterialPageRoute(builder: (_) => StoreScreen(store: route.arguments as Store));
            case ProductScreen.route_name:
              return MaterialPageRoute(builder: (_) => ProductScreen(product: route.arguments as Product));
            case LoginScreen.route_name:
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case SignUpScreen.route_name:
              return MaterialPageRoute(builder: (_) => SignUpScreen());
            case BaseScreen.route_name:
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}

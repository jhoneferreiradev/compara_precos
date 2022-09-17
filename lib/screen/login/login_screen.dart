import 'package:compara_precos/domain/local_user.dart';
import 'package:compara_precos/screen/base_screen.dart';
import 'package:compara_precos/screen/signup/signup_screen.dart';
import 'package:compara_precos/service/local_user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/validators.dart';

class LoginScreen extends StatelessWidget {
  static const String route_name = '/login';

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passController = TextEditingController();

    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Card(
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: primaryColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: SizedBox(
                  height: 50,
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 20, color: primaryColor),
                      ))),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: primaryColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Form(
                key: formKey,
                child:
                    Consumer<LocalUserService>(builder: (_, localUserService, __) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        controller: emailController,
                        enabled: !localUserService.loading,
                        decoration: const InputDecoration(
                            label: Text("E-mail"),
                            suffixIcon: Icon(Icons.email_sharp,
                                color: Colors.blueGrey)),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (email) {
                          return (emailValid(email ?? ''))
                              ? null
                              : "Informe um e-mail válido";
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: passController,
                        enabled: !localUserService.loading,
                        decoration: const InputDecoration(
                            label: Text("Senha"),
                            suffixIcon:
                                Icon(Icons.key_sharp, color: Colors.blueGrey)),
                        obscureText: true,
                        validator: (pass) {
                          if (pass == null || pass.isEmpty) {
                            return "Informe sua senha";
                          }
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: localUserService.loading ? null : () {},
                          child: const Text("Esqueci minha senha"),
                          style: TextButton.styleFrom(
                              foregroundColor: primaryColor),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 42,
                        child: ElevatedButton(
                          onPressed: localUserService.loading
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    localUserService.signIn(
                                        localUser: LocalUser(
                                            email: emailController.text,
                                            password: passController.text),
                                        onFail: (e) {
                                          ScaffoldMessenger.of(context)
                                              .clearSnackBars();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content:
                                                Text("Falha ao entrar. $e"),
                                            backgroundColor: Colors.redAccent,
                                          ));
                                        },
                                        onSuccess: () {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  BaseScreen.route_name);
                                        });
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor),
                          child: localUserService.loading
                              ? CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(primaryColor))
                              : const Text(
                                  "Entrar",
                                  style: TextStyle(fontSize: 18),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: localUserService.loading
                              ? null
                              : () {
                                  Navigator.of(context).pushReplacementNamed(
                                      SignUpScreen.route_name);
                                },
                          child:
                              const Text("Ainda não possui conta? Clique aqui"),
                          style: TextButton.styleFrom(
                              foregroundColor: primaryColor),
                        ),
                      ),
                      if (false)
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(BaseScreen.route_name);
                            },
                            child: const Text("Ou, continue sem fazer login"),
                            style: TextButton.styleFrom(
                                foregroundColor: primaryColor),
                          ),
                        ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

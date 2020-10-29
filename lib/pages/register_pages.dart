import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_chat/services/auth_service.dart';
import 'package:flutter_chat/services/socket_service.dart';

import 'package:flutter_chat/helpers/show_modal.dart';

import 'package:flutter_chat/widgets/button_login.dart';
import 'package:flutter_chat/widgets/custom_input.dart';
import 'package:flutter_chat/widgets/custon_logo.dart';
import 'package:flutter_chat/widgets/labels_login.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //Widget to logo
                CustomLogo(
                  urlImage: 'assets/tag-logo.png',
                  title: 'Registro',
                ),
                _Form(),

                //Widget to Labels login
                LabelsLogin(
                  ruta: 'login',
                  titleLabel: 'Iniciar Sesion',
                  subTitleLabel: 'Si ya tienes cuenta',
                ),
                Text(
                  'Terminos y Condiciones de uso',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          //Custon Input login
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            textController: nameController,
          ),
          //Custon Input login
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
          ),

          //Custon Input login
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Password',
            textController: passwordController,
            isPassword: true,
          ),

          //Witget button
          ButtonLogin(
              text: 'Registrar',
              onPressed: (authService.loadingAuth ||
                      (emailController.text == '' &&
                          passwordController.text == '' &&
                          nameController.text == ''))
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      await authService.singUp(
                        nameController.text.trim(),
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );

                      if (!authService.invalidCredencials) {
                        socketService.connect();
                        Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        showModal(context, 'No se pudo registrar',
                            'Verifique su email y vuelva a intentarlo');
                      }
                    }),
        ],
      ),
    );
  }
}

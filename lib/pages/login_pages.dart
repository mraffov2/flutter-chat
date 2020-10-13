import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/button_login.dart';
import 'package:flutter_chat/widgets/custom_input.dart';
import 'package:flutter_chat/widgets/custon_logo.dart';
import 'package:flutter_chat/widgets/labels_login.dart';

class LoginPage extends StatelessWidget {
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
                CustomLogo(urlImage: 'assets/tag-logo.png', title: 'Messenger'),
                _Form(),

                //Widget to Labels login
                LabelsLogin(
                  ruta: 'register',
                  titleLabel: 'Crear una ahora',
                  subTitleLabel: 'Si no tienes cuenta',
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
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
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
              text: 'Ingrese',
              onPressed: () {
                print(emailController.text);
                print(passwordController.text);
              }),
        ],
      ),
    );
  }
}

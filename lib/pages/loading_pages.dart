import 'package:flutter/material.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:flutter_chat/services/socket_service.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: checkLoginState(context),
      builder: (context, snapshop) {
        return Center(
          child: Loading(
              indicator: BallPulseIndicator(), size: 100.0, color: Colors.blue),
        );
      },
    ));
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context);
    final autenticado = await authService.isLoggedIn();

    if (autenticado) {
      // TODO: Conectar al socket
      Navigator.pushReplacementNamed(context, 'usuarios');
      socketService.connect();
    } else {
      Navigator.pushReplacementNamed(context, 'login');
      socketService.disconnect();
    }
  }
}

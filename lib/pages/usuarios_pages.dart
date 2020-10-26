import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:flutter_chat/services/auth_service.dart';
import 'package:flutter_chat/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final usuarios = [
    Usuario(
        id: '1',
        name: 'Mario',
        email: 'mario@email.com',
        online: true,
        registeredAt: new DateTime.now()),
    Usuario(
        id: '2',
        name: 'Axel',
        email: 'axel@email.com',
        online: false,
        registeredAt: new DateTime.now()),
    Usuario(
        id: 'evdrg4t3ge',
        name: 'stela',
        email: 'stela@email.com',
        online: true,
        registeredAt: new DateTime.now()),
    Usuario(
        id: '4',
        name: 'jonh',
        email: 'jonh@email.com',
        online: true,
        registeredAt: new DateTime.now()),
  ];
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Positioned(
            child: Container(
              margin: EdgeInsets.only(top: 45),
              child: new Center(
                  child: new Text(
                usuario.name,
                style: TextStyle(color: Colors.black54, fontSize: 15),
              )),
            ),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.black54,
              ),
              onPressed: () {
                //TODO: Desconectar el socket
                AuthService.deleteToken();
                Navigator.pushReplacementNamed(context, 'login');
              }),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.offline_bolt,
                color: Colors.red,
              ),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          onRefresh: _cargarUsuarios,
          enablePullDown: true,
          header: WaterDropMaterialHeader(
            backgroundColor: Colors.blue[200],
          ),
          child: _usuarioListView(),
        ));
  }

  ListView _usuarioListView() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.name),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.name.toUpperCase().substring(0, 2)),
        backgroundColor: Colors.blue[200],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  _cargarUsuarios() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 3000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}

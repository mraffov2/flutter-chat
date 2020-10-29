import 'dart:io';
import 'package:flutter_chat/models/mensajes_response.dart';
import 'package:provider/provider.dart';

import 'package:flutter_chat/services/auth_service.dart';
import 'package:flutter_chat/services/socket_service.dart';
import 'package:flutter_chat/services/chat_service.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/burble_chat.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();

  List<BurbleChat> _messages = [];
  bool isWriting = false;

  ChatService chatService;
  SocketService socketService;
  AuthService authService;
  @override
  void initState() {
    super.initState();
    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);

    this.socketService.socket.on('person-message', _listeningMessage);

    _cargarHistorial(this.chatService.usuarioToWrite.id);
  }

  void _cargarHistorial(String id) async {
    List<Message> chat = await this.chatService.getChat(id);

    final history = chat.map((m) => new BurbleChat(
        texto: m.message,
        uid: m.from,
        animationController: new AnimationController(
            vsync: this, duration: Duration(milliseconds: 0))
          ..forward()));

    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _listeningMessage(dynamic payload) {
    BurbleChat message = new BurbleChat(
      texto: payload['message'],
      uid: payload['to'],
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 400)),
    );

    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Positioned(
          child: Container(
            margin: EdgeInsets.only(top: 45),
            child: new Center(
                child: new Text(
              chatService.usuarioToWrite.name,
              style: TextStyle(color: Colors.black54, fontSize: 15),
            )),
          ),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        // leading: IconButton(
        //     icon: Icon(
        //       Icons.exit_to_app,
        //       color: Colors.black54,
        //     ),
        //     onPressed: () {}),
        // actions: <Widget>[
        //   Container(
        //     margin: EdgeInsets.only(right: 10),
        //     child: Icon(
        //       Icons.offline_bolt,
        //       color: Colors.red,
        //     ),
        //   )
        // ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
                child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (_, i) => _messages[i],
              physics: BouncingScrollPhysics(),
              reverse: true,
            )),

            Divider(height: 1),
            //TODO: Caja de texto
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handelSubmit,
              onChanged: (texto) {
                //TODO: Cuando hay un valor para poder postear
                setState(() {
                  if (texto.trim().length > 0) {
                    isWriting = true;
                  } else {
                    isWriting = false;
                  }
                });
              },
              decoration:
                  InputDecoration.collapsed(hintText: 'Escriba un mensaje'),
              focusNode: _focusNode,
            ),
          ),
          //Boton de enviar
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Platform.isIOS
                ? CupertinoButton(
                    child: Text('Enviar'),
                    onPressed: isWriting
                        ? () => _handelSubmit(_textController.text.trim())
                        : null,
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: Icon(
                          Icons.send,
                        ),
                        onPressed: isWriting
                            ? () => _handelSubmit(_textController.text.trim())
                            : null,
                      ),
                    ),
                  ),
          )
        ],
      ),
    ));
  }

  _handelSubmit(String texto) {
    if (texto.length == 0) return;
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new BurbleChat(
      uid: authService.usuario.id,
      texto: texto,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 400)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      isWriting = false;
    });

    this.socketService.emit('person-message', {
      'from': authService.usuario.id,
      'to': chatService.usuarioToWrite.id,
      'message': texto
    });
  }

  @override
  void dispose() {
    for (BurbleChat messagge in _messages) {
      messagge.animationController.dispose();
    }

    this.socketService.socket.off('person-message');

    super.dispose();
  }
}

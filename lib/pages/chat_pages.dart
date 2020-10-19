import 'dart:io';

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

  List<BurbleChat> _messages = [
    // BurbleChat(
    //   texto: 'Esto es un mensaje de prueba',
    //   uid: '123',
    // ),
    // BurbleChat(
    //   texto: 'Esto es un mensaje de prueba',
    //   uid: '12345',
    // ),
    // BurbleChat(
    //   texto:
    //       'Esto es un mensaje de prueba prueba hola mundo esto es una prueba de texto largo para mensage',
    //   uid: '123',
    // ),
    // BurbleChat(
    //   texto:
    //       'Esto es un mensaje de prueba prueba hola mundo esto es una prueba de texto largo para mensage',
    //   uid: '12335',
    // ),
    // BurbleChat(
    //   texto: 'Esto es un mensaje de prueba',
    //   uid: '123',
    // ),
  ];
  bool isWriting = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Positioned(
          child: Container(
            margin: EdgeInsets.only(top: 45),
            child: new Center(
                child: new Text(
              'Mario Villegas',
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
      uid: '123',
      texto: texto,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 400)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      isWriting = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement off socket

    for (BurbleChat messagge in _messages) {
      messagge.animationController.dispose();
    }

    super.dispose();
  }
}

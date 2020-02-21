import 'package:flutter/material.dart';

class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Medical Chat Bot"),
      ),
      body: new Column(
        children: <Widget>[
          new Flexible(child: Container(color: Colors.amber)),
          new Container(
            color: Colors.amber,
            padding: const EdgeInsets.all(8.0),
            // height: MediaQuery.of(context).size.height * 0.10,
            child: Row(
              children: <Widget>[
                new Flexible(
                  child: Container(
                    decoration: new BoxDecoration(
                      color: Colors.orange.shade400,
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: new TextFormField(
                      decoration: new InputDecoration(
                          hintText: "Your Message",
                          border: InputBorder.none,
                          prefixIcon: new Icon(
                            Icons.chat,
                            size: 30.0,
                            color: Colors.deepOrange,
                          ),
                          focusColor: Colors.deepOrange),
                    ),
                  ),
                ),
                new SizedBox(width: 20.0,),
                new ClipRRect(
                  borderRadius: new BorderRadius.circular(20.0),
                  child: new Container(
                    color: Colors.deepOrange,
                    child: IconButton(color: Colors.black,onPressed: (){}, icon: new Icon(Icons.send),iconSize: 25.0,),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

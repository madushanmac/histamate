 // gemini chat conversation

 import 'package:flutter/material.dart';
import 'package:flutter_gemini_bot/flutter_gemini_bot.dart';
import 'package:flutter_gemini_bot/models/chat_model.dart';

 class Chat extends StatefulWidget {
   const Chat({super.key, required this.title});

   final String title;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  List<ChatModel> chatList = []; // Your list of ChatModel objects
  String apiKey = 'AIzaSyCvZWx3Tiw7IEJ-nHb7YwbPrzq9ZkKx_IQ';

   @override
   Widget build(BuildContext context) {
     return  Scaffold(

       appBar: AppBar(
         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
         title: Text(widget.title,style: const TextStyle(fontWeight: FontWeight.bold),),
       ),
       body: FlutterGeminiChat(

         botChatBubbleTextColor: Colors.black87,
         chatContext: 'you are a histamate food assistant ',
         chatList: chatList,
         apiKey: apiKey,
       ), // This trailing comma makes auto-formatting nicer for build methods.
     );
   }
}

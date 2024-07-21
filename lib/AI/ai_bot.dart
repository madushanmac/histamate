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
  String apiKey = 'AIzaSyALKH6vnmGd9MHGAtveqyAzxzcC5YKcR28';

   @override
   Widget build(BuildContext context) {
     return  Scaffold(

       appBar: AppBar(
         backgroundColor: Theme.of(context).colorScheme.background,
         title: Text(widget.title,style: const TextStyle(fontWeight: FontWeight.bold),),
       ),
       body: FlutterGeminiChat(
         botChatBubbleTextColor: Colors.black87,
         botChatBubbleColor: Colors.black,
         userChatBubbleTextColor: Colors.black,
         userChatBubbleColor: Colors.black,
         hintText: 'hi ?',
         apiKey: apiKey,
         chatContext: 'you are a histamate food assistant you must only need to tell food related things when user ask you',
         chatList: [

         ],
       ), // This trailing comma makes auto-formatting nicer for build methods.
     );
   }
}



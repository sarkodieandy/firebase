import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? loggedInUser;
  late String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          loggedInUser = user;
        });
        print('Logged in user email: ${loggedInUser!.email}');
      }
    } catch (e) {
      print('Error fetching user: $e');
    }
  }

  //create a method to retrieve messages
  // void getMessages() async {
  //   final  messages =
  //       await FirebaseFirestore.instance.collection('messages').get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }

  //creating message stream for both the sender and the reciever
  void messageStream() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('messages').get();
      for (var message in snapshot.docs) {
        print(message.data());
      }
    } catch (e) {
      print('Error fetching messages: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('⚡️Chat'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              messageStream();
              // try {
              //   await _auth.signOut();
              //   // Navigate to login screen or any other desired screen
              // } catch (e) {
              //   print('Error during logout: $e');
              // }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Add chat messages widget here (e.g., ListView.builder)
            // You can use Firebase Firestore or any other backend for messages

            // Input field and send button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          messageText = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Type your message...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if (messageText.isNotEmpty) {
                        _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': loggedInUser!.email,
                        });
                        // Clear the input field after sending the message
                        setState(() {
                          messageText = '';
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

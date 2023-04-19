import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/chat_bloc.dart';
import 'msg_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gokito',
        theme: ThemeData.light(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: Colors.grey[200],
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 54, 177, 185),
            foregroundColor: Colors.white,
          ),
        ),
        home: const MessagePage(),
      ),
    );
  }
}

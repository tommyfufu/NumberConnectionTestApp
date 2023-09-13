import 'package:flutter/material.dart';
import 'package:number_connection_test/constants/routes.dart';
import 'package:number_connection_test/game/game_view.dart';
// import 'package:number_connection_test/game/game_view.dart';
import 'package:number_connection_test/game/ready_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Game'),
      routes: {
        gameRouteReady: (context) => const ReadyView(),
        gameRouteStart: (context) => const GameView(),
        // loginRoute: (context) => const LoginView(),
        // registerRoute: (context) => const RegisterView(),
        // notesRoute: (context) => const NotesView(),
        // verifyEmailRoute: (context) => const VerifyEmailView(),
        // createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(gameRouteReady);
          },
          child: const Text('New Game'),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: ,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

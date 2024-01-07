import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './todo.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _login();
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void _login() {
    String expectedUsername = dotenv.env['USERNAME'] ?? '';
    String expectedPassword = dotenv.env['PASSWORD'] ?? '';
    String enteredUsername = _usernameController.text;
    String enteredPassword = _passwordController.text;
    print('enteredUsername:' + enteredUsername);
    print('expectedPassword:' + expectedPassword);

    if (enteredUsername == expectedUsername &&
        enteredPassword == expectedPassword) {
      print('OK');

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => TodoScreen()),
      // );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid Credentials'),
            content: Text('The entered username or password is incorrect.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

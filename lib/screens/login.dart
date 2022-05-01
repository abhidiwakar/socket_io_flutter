import 'package:flutter/material.dart';
import 'package:flutter_socket_io/providers/home.dart';
import 'package:flutter_socket_io/providers/login.dart';
import 'package:flutter_socket_io/screens/home.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  _login() {
    final provider = Provider.of<LoginProvider>(context, listen: false);
    if (_usernameController.text.trim().isNotEmpty) {
      provider.setErrorMessage('');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => HomeProvider(),
            child: HomeScreen(
              username: _usernameController.text.trim(),
            ),
          ),
        ),
      );
    } else {
      provider.setErrorMessage('Username is required!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Selector<LoginProvider, String>(
                selector: (_, provider) => provider.errorMessage,
                builder: (_, errorMessage, __) => errorMessage != ''
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Card(
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              errorMessage,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ),
              Image.asset('assets/socket_icon.png'),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Flutter Socket.IO',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 40,
              ),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Who are you?',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Start Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key, required this.title});

  final String title;

  @override
  State<SigninPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  int _usernameLength = 0;

  final List<String> _userNameList = ['panisara'];

  String? validateTextFieldName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter username';
    }

    if (value.isNotEmpty && value.characters.length < 2) {
      return 'Please enter username more than 2 ';
    }

    if (value.isNotEmpty && _userNameList.contains(value)) {
      return 'This username not available';
    }

    return null;
  }

  String? validateTextFieldPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.isNotEmpty && value.characters.length < 8) {
      return 'Please enter password more than 8';
    }

    return null;
  }

  Widget? getIcon() {
    if (_usernameLength == 0) {
      return null;
    }
    if (!_userNameList.contains(_username)) {
      return const Icon(Icons.check);
    } else {
      return const Icon(Icons.close);
    }
  }

  void handleSignInPressed() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, '/1');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 15.0, left: 32.0, right: 32.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(32.0),
                  child: Image.asset(
                    'assets/images/healthme.png',
                    height: 120,
                  )),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 32.0, right: 32.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            icon: const Icon(Icons.person),
                            hintText: 'Please Enter username.',
                            labelText: 'Username',
                            suffixIcon: Align(
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child: getIcon())),
                        validator: (value) {
                          return validateTextFieldName(value);
                        },
                        onChanged: (String? value) {
                          setState(() {
                            _username = value!;
                            _usernameLength = value.length;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 32.0, right: 32.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          icon: Icon(Icons.key),
                          hintText: 'Please Enter your password.',
                          labelText: 'Password',
                        ),
                        validator: (value) {
                          return validateTextFieldPassword(value);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: ElevatedButton(
                          onPressed: () {
                            handleSignInPressed();
                          },
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 50.0),
                            backgroundColor:
                                Theme.of(context).colorScheme.inversePrimary,
                          )),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

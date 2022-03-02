// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var isLoading = false;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: "Email"),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(hintText: "Password"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      signIn();
                    },
                    // color: Colors.blue,
                    child: const Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      signUp();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          "Don`t have an account?",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Future signIn() async {
    // try {
    //   await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: emailController.text.trim(),
    //     password: passwordController.text.trim(),
    //   );
    // } catch (e) {
    //   print(e);
    // }
    // print('tugri');
  }

  Future signUp() async {
    // try {
    //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //       email: emailController.text.trim(),
    //       password: passwordController.text.trim());
    // } catch (e) {
    //   print(e);
    // }
    // print('otdiiii');
  }
}

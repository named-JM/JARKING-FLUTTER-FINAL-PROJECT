import 'package:final_project_for_flutter_by_jarling/User_Auth/firebase_auth_services.dart';
import 'package:final_project_for_flutter_by_jarling/User_Auth/form_container_widget.dart';
import 'package:final_project_for_flutter_by_jarling/User_Auth/signup.dart';
import 'package:final_project_for_flutter_by_jarling/global/common/toast.dart';
import 'package:final_project_for_flutter_by_jarling/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //auth instance (handling firebase for authentication)
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

//---DISPOSE TO FREE UP RESOURCES
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  //this method buiolds for UI
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                //l----LOGO
                Image.asset(
                  'Assets/images/icons/jarcrown.png',
                  height: 120,
                ),

                const SizedBox(height: 25),
                Text(
                  "Login",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 30,
                ),
                //EMAIL TEXTFIELD
                FormContainerWidget(
                  controller: _emailController,
                  hintText: "Email",
                  isPasswordField: false,
                ),
                SizedBox(
                  height: 10,
                ),
                //PASSWORD TEXTFIRELD
                FormContainerWidget(
                  controller: _passwordController,
                  hintText: "Password",
                  isPasswordField: true,
                ),
                SizedBox(
                  height: 30,
                ),
                //-----> LOGIN BUTTON
                GestureDetector(
                  onTap: _signIn,
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                //----> DONT HAVE AN ACCCOUNT?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupPage()),
                            (route) => false);
                      },
                      //SIGN UP BLUE TEXT
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

//SIGN IN FUNCTION  handles the signin process
  void _signIn() async {
    //this will add if we type in that testfield it will add into the firebase

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      showToast(message: "User is successfully signed in");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    } else {
      showToast(message: "check your credentials.");
    }
  }
}

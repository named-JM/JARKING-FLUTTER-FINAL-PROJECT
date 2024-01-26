import 'package:final_project_for_flutter_by_jarling/User_Auth/firebase_auth_services.dart';
import 'package:final_project_for_flutter_by_jarling/User_Auth/form_container_widget.dart';
import 'package:final_project_for_flutter_by_jarling/User_Auth/login.dart';
import 'package:final_project_for_flutter_by_jarling/global/common/toast.dart';
import 'package:final_project_for_flutter_by_jarling/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //auth - instance for FirebaseAuthService for handling Firebase authentication.
// Controllers for text input fields for username, email, and password.
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  //It disposes of the text editing controllers to free up resources.
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
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
                //logo
                Image.asset(
                  "Assets/images/icons/jarcrown.png",
                  height: 120,
                ),
                const SizedBox(height: 25),
                Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 30,
                ),
                FormContainerWidget(
                  controller: _usernameController,
                  hintText: "Username",
                  isPasswordField: false,
                ),
                SizedBox(
                  height: 10,
                ),

                //FORMCONTAINERWIDGET WE CREATED IN THE ANOTHER FILE
                //EMAIL TEXTFIELD
                FormContainerWidget(
                  controller: _emailController,
                  hintText: "Email",
                  isPasswordField: false,
                ),
                SizedBox(
                  height: 10,
                ),
                //PASSWORD TEXTFIELD
                FormContainerWidget(
                  controller: _passwordController,
                  hintText: "Password",
                  isPasswordField: true,
                ),
                SizedBox(
                  height: 30,
                ),
                //SIGN UP BUTTON!!
                GestureDetector(
                  onTap: _signUp,
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black),
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //-- ALREADY HAVE AN ACCOUNT?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    SizedBox(
                      width: 5,
                    ),
                    //LOGIN TEXT CLICKABLE TO DIRECT TO LOGIN PAGE
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false);
                      },
                      child: Text(
                        "Login",
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

//SIGN UP FUNCTION
  void _signUp() async {
    //this will add if we type in that texstfield it will add into the firebase
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
//await is used to wait for the complete of the method signupwith email and password. for the asynchronous function
// User? - nullable. if the user is succeful signup the user variable will be assgined to non-null value
    User? user = await _auth.signUpWithEmailAndPassword(email, password);

//if sucesfully sign up
    if (user != null) {
      //the username will save for our porfile page
      await _auth.updateUsername(user, username);

      showToast(message: "User is successfully created");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    } else {
      showToast(message: "Please check your credentials");
    }
  }
}

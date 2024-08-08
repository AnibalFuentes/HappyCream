// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:happycream/UI/pages/reset_password_page.dart';
import 'package:happycream/UI/pages/sign_up_page.dart';
import 'package:happycream/UI/widgets/form_container_widget.dart';
import 'package:happycream/UI/widgets/square_title_widget.dart';
import 'package:happycream/controllers/auth_controller.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigning = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
 var authenticationController = AuthenticationController.authController;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Gap(100),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.05),
                            spreadRadius: 10,
                            blurRadius: 10,
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/icon/icon.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Del campo a tu mesa.",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                const Text(
                  "Bienvenido",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                FormContainerWidget(
                  
                  hintText: "Correo electrónico",
                  controller: _emailController,
                  inputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 10,
                ),
                FormContainerWidget(
                  hintText: "Contraseña",
                  controller: _passwordController,
                  isPasswordField: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ResetPasswordPage()),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          "Olvidaste tu contraseña?",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: (){

                    if(_emailController.text.trim().isNotEmpty && _passwordController.text.trim().isNotEmpty){
                      
                    _signIn();

                    }
                    else{
                      Get.snackbar('Email/password is missing', 'Please fill a field.');
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.deepPurple.shade300,
                    ),
                    child: Center(
                      child: _isSigning
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Iniciar sesión",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    )),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "ó continua con",
                          style: TextStyle(color: Colors.grey[700]),
                        )),
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    )),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _signInWithGoogle,
                      child: const SquareTitleWidget(
                          imagePath: "assets/icon/google.png"),
                    ),
                    
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        "No tienes cuenta? ",
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          "Regístrate",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool? state;

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });
    
    await authenticationController.loginUser(
      _emailController.text.trim(), 
      _passwordController.text.trim());

    // String email = _emailController.text;
    // String password = _passwordController.text;

    // try {
    //   User? user = await _auth.signInWithEmailAndPassword(email, password);

    //   if (user != null) {
    //     final currentUser = FirebaseAuth.instance.currentUser!;
    //     // Verificar el estado del usuario en Firestore
    //     List<Map<String, dynamic>> usuarios = await getUserById(currentUser.uid);
    //     if (usuarios.isNotEmpty) {
    //       if (!mounted) return; // Verifica si el widget está montado
    //       setState(() {
    //         state = usuarios.first['state'];
    //       });
    //     }

    //     //if (state == true) {
    //      showToast(message: "Inicio de sesión exitoso");
    //       Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(builder: (builder) => const NavBar()),
    //         (route) => false,
    //       );
    //    // } else {
    //       // showToast(message: "Usuario inactivo. Contacta al administrador.");
    //       // await _firebaseAuth.signOut(); // Cerrar sesión del usuario inactivo
    //    // }
    //   } else {
    //     showToast(message: "Ha ocurrido un error");
    //   }
    // } catch (e) {
    //   showToast(message: "Error al iniciar sesión: $e");
    // } finally {
      setState(() {
        _isSigning = false;
      });
    }
  

  void _signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);

        // Verificar el estado del usuario en Firestore
        DocumentSnapshot userDoc = await _firestore
            .collection('usuarios')
            .doc(userCredential.user?.uid)
            .get();

        if (userDoc.exists &&
            userDoc.data() != null &&
            userDoc['state'] == true) {
          Navigator.pushNamed(context, "/home");
        } else {
          Get.snackbar('', 'Usuario inactivo. Contacta al administrador.');
          await _firebaseAuth.signOut(); // Cerrar sesión del usuario inactivo
        }
      }
    } catch (e) {
      Get.snackbar('', 'Error al iniciar sesión con Google: $e');
     
    }
  }

  

}
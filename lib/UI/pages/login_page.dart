import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:happycream/UI/pages/reset_password_page.dart';
import 'package:happycream/UI/pages/sign_up_page.dart';
import 'package:happycream/UI/widgets/form_container_widget.dart';
import 'package:happycream/UI/widgets/square_title_widget.dart';
import 'package:happycream/controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthenticationController authenticationController =
      AuthenticationController.authController;

  final Rx<TextEditingController> email = AuthenticationController().email;
  final Rx<TextEditingController> password =
      AuthenticationController().password;

  var _isSigning = false.obs;

  void _signIn(BuildContext context) async {
    _toggleSigningState();

    await authenticationController.loginUser(
      email.value.text.trim(),
      password.value.text.trim(),
    );

    _toggleSigningState();
  }

  void _toggleSigningState() {
    _isSigning.value = !_isSigning.value;
  }

  // void _signInWithGoogle(BuildContext context) async {
  //   final GoogleSignIn googleSignIn = GoogleSignIn();

  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await googleSignIn.signIn();

  //     if (googleSignInAccount != null) {
  //       final GoogleSignInAuthentication googleSignInAuthentication =
  //           await googleSignInAccount.authentication;

  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         idToken: googleSignInAuthentication.idToken,
  //         accessToken: googleSignInAuthentication.accessToken,
  //       );

  //       UserCredential userCredential =
  //           await _firebaseAuth.signInWithCredential(credential);

  //       // Verificar el estado del usuario en Firestore
  //       DocumentSnapshot userDoc = await _firestore
  //           .collection('usuarios')
  //           .doc(userCredential.user?.uid)
  //           .get();

  //       if (userDoc.exists &&
  //           userDoc.data() != null &&
  //           userDoc['state'] == true) {
  //         Navigator.pushNamed(context, "/home");
  //       } else {
  //         Get.snackbar('', 'Usuario inactivo. Contacta al administrador.');
  //         await _firebaseAuth.signOut(); // Cerrar sesión del usuario inactivo
  //       }
  //     }
  //   } catch (e) {
  //     Get.snackbar('', 'Error al iniciar sesión con Google: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Gap(MediaQuery.of(context).size.height * 0.01),
                    Image.asset(
                      'assets/icon/icon.png',
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.4,
                      fit: BoxFit.contain,
                    ),
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
                const SizedBox(height: 15),
                Obx(() {
                  return FormContainerWidget(
                    hintText: "Correo electrónico",
                    controller: email.value,
                    inputType: TextInputType.emailAddress,
                  );
                }),
                const SizedBox(height: 10),
                Obx(() {
                  return FormContainerWidget(
                    hintText: "Contraseña",
                    controller: password.value,
                    isPasswordField: true,
                  );
                }),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ResetPasswordPage()),
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
                  ],
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    if (email.value.text.trim().isNotEmpty &&
                        password.value.text.trim().isNotEmpty) {
                      _signIn(context);
                      email.value.clear();
                      password.value.clear();
                      print(email.value);
                    } else {
                      Get.snackbar(
                          'Email/password is missing', 'Please fill a field.');
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
                      child: _isSigning.value
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
                const SizedBox(height: 15),
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
                          "ó ",
                          style: TextStyle(color: Colors.grey[700]),
                        )),
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    )),
                  ],
                ),
                const SizedBox(height: 15),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: () => _signInWithGoogle(context),
                //       child: const SquareTitleWidget(

                //         imagePath: "assets/icon/google.png",
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 15),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text(
                //       "No tienes cuenta? ",
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         Navigator.pushAndRemoveUntil(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => const SignUpPage()),
                //           (route) => false,
                //         );
                //       },
                //       child: const Text(
                //         "Regístrate",
                //         style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

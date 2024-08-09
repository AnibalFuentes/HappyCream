import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happycream/UI/pages/home_page.dart';
import 'package:happycream/UI/widgets/drawer_widget.dart';
import 'package:happycream/controllers/theme_controller.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex = 0;
  static const List body = [
    HomePage(),
    //BatchPage(),
    // AnimalPage(),
    //ProductionPage(),
    // ProfilePage(),
  ];
  
  void _logout() async {
    try {
      await FirebaseAuth.instance.signOut();

      Navigator.pushNamed(context, "/login");
      Get.snackbar('', "Sesión cerrada exitosamente");
    } catch (e) {
      Get.snackbar('', "Error al cerrar sesión: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(
        onProfileTap: null,
        onSignUp: _logout,
        // onTrabajadorTap: _trabajador,
      ),
      appBar: AppBar(
          
          title: const Text(
            "Happy Cream",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.find<ThemeController>().toggleTheme();
                setState(() {
                  
                });
              },
              icon: Icon(
                Get.isDarkMode ?Icons.nightlight_round  : Icons.wb_sunny,
                
              ),
            ),
            IconButton(
                onPressed: _logout,
                icon: const Icon(Icons.logout),
                color: Colors.white)
          ],
          iconTheme: const IconThemeData(color: Colors.white)),
      body: Center(
        child: body.elementAt(currentIndex),
      ),
      bottomNavigationBar: NavigationBar(
        //indicatorColor: Colors.grey.shade300,
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.grey.shade600,
              size: 30,
            ),
            selectedIcon: const Icon(
              Icons.home,
              size: 30,
            ),
            label: 'Inicio',
          ),
          NavigationDestination(
              icon: Icon(
                Icons.agriculture_outlined,
                color: Colors.grey.shade600,
                size: 30,
              ),
              selectedIcon: const Icon(
                Icons.agriculture,
                size: 30,
              ),
              label: 'Finca'),
          NavigationDestination(
              icon: Icon(
                Icons.assignment_outlined,
                color: Colors.grey.shade600,
                size: 30,
              ),
              selectedIcon: const Icon(
                Icons.assignment,
                size: 30,
              ),
              label: 'Animales'),
          // NavigationDestination(
          //     icon:
          //         Icon(Icons.view_agenda_rounded, color: Colors.grey.shade600),
          //     label: 'Producción'),
          // NavigationDestination(
          //   icon: Icon(Icons.person_2, color: Colors.grey.shade600),
          //   label: 'Perfil',
          // ),
        ],
        selectedIndex: currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

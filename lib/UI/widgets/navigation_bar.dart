import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happycream/UI/pages/add_category.dart';
import 'package:happycream/UI/pages/add_syrup.dart';
import 'package:happycream/UI/pages/add_topping.dart';
import 'package:happycream/UI/pages/category_page.dart';
import 'package:happycream/UI/pages/home_page.dart';
import 'package:happycream/UI/pages/syrup_page.dart';
import 'package:happycream/UI/pages/topping_page.dart';
import 'package:happycream/UI/widgets/drawer_widget.dart';
import 'package:happycream/controllers/auth_controller.dart';
import 'package:happycream/controllers/theme_controller.dart';

class NavBar extends StatelessWidget {
  NavBar({Key? key}) : super(key: key);

  // Variables para la navegación y la selección de la página actual.
  final RxInt currentIndex = 0.obs;

  // Lista de las páginas que se mostrarán en la navegación.
  static const List<Widget> body = [
    HomePage(),
    CategoryPage(),
    ToppingPage(),
    SyrupPage()
    // BatchPage(),
    // AnimalPage(),
    // ProductionPage(),
    // ProfilePage(),
  ];

  // Función para cerrar sesión.
  void logout() {
    AuthenticationController.authController.logout();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      return Scaffold(
        drawer: DrawerWidget(
          onProfileTap: null,
          onSignUp: logout,
          // onTrabajadorTap: _trabajador,
        ),
        appBar: AppBar(
          title: currentIndex.value == 0
              ? const Text("Happy Cream")
              : currentIndex.value == 1
                  ? const Text('Categorias')
                  : const Text('Toppings'),
          actions: [
            Obx(() => IconButton(
                  onPressed: () {
                    themeController.toggleTheme();
                  },
                  icon: Icon(
                    themeController.themeMode.value == ThemeMode.dark
                        ? Icons.nightlight_round
                        : Icons.wb_sunny,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                child: CircleAvatar(
                  child: IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                ),
              ),
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: Obx(() => body.elementAt(currentIndex.value)),
        ),
        bottomNavigationBar: Obx(
          () => NavigationBar(
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
                  Icons.restaurant_menu,
                  color: Colors.grey.shade600,
                  size: 30,
                ),
                selectedIcon: const Icon(
                  Icons.restaurant_menu,
                  size: 30,
                ),
                label: 'Productos',
              ),
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
                label: 'Toppings',
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.water_drop_outlined,
                  color: Colors.grey.shade600,
                  size: 30,
                ),
                selectedIcon: const Icon(
                  Icons.water_drop,
                  size: 30,
                ),
                label: 'Salsas',
              ),
            ],
            selectedIndex: currentIndex.value,
            onDestinationSelected: (int index) {
              currentIndex.value = index;
            },
          ),
        ),
        floatingActionButton: currentIndex.value == 0
            ? null
            : FloatingActionButton(
                onPressed: () async {
                  switch (currentIndex.value) {
                    case 1:
                      return showCategoryDialog(
                          context: context, isEditing: false);

                    case 2:
                      return showToppingDialog(
                          context: context, isEditing: false);
                    case 3:
                      return showSyrupDialog(
                          context: context, isEditing: false);
                  }
                },
                child: const Icon(Icons.add),
              ),
      );
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happycream/models/product.dart';
import 'package:happycream/models/topping.dart';

class ToppingController extends GetxController {
  final Rx<TextEditingController> name = TextEditingController().obs;
  final Rx<TextEditingController> price = TextEditingController().obs;
  static ToppingController toppingController = Get.find();
  final RxList<Topping> toppingList = <Topping>[].obs;
  final db = FirebaseFirestore.instance;

  final RxBool isLoading = false.obs; // Añadido para el estado de carga

  var tTopings = 0.obs;
  String imgURL = '';

  @override
  void onInit() {
    super.onInit();
    getToppings();
  }

  void addTopping() async {
    try {
      var topping = Topping(
        id: '',
        name: name.value.text.toLowerCase(),
        state: true,
        image: imgURL,
        price: double.tryParse(price.value.text) ?? 0.0,
      );

      await db.collection('toppings').add(topping.toMap()).then((docRef) {
        toppingList.add(Topping(
            id: docRef.id,
            name: topping.name,
            state: topping.state,
            image: topping.image,
            price: topping.price));
        Get.snackbar(
          'topping Añadido',
          'El topping ${name.value.text} ha sido añadido exitosamente',
        );
        name.value.clear();
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Hubo un problema al añadir el topping: ${e.toString()}',
      );
    }
  }

  void getToppings() async {
    isLoading.value = true; // Comienza la carga
    try {
      var toppings = await db.collection('toppings').get();
      toppingList.clear();
      for (var product in toppings.docs) {
        toppingList.add(Topping.fromMap(product.data(), product.id));
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Hubo un problema al obtener los productos: ${e.toString()}',
      );
    } finally {
      isLoading.value = false; // Termina la carga
    }
  }

  void updateTopping(
    String toppingId,
    String newName,
    String newImage,
    double newPrice,
  ) async {
    try {
      // Actualiza los campos del producto en Firestore
      await db.collection('toppings').doc(toppingId).update({
        'name': newName.toLowerCase(),
        'image': newImage,
        'price': newPrice,
      }).then((_) {
        // Actualiza el producto en la lista observable
        int index =
            toppingList.indexWhere((topping) => topping.id == toppingId);
        if (index != -1) {
          toppingList[index] = Topping(
            id: toppingId,
            name: newName.toLowerCase(),
            image: newImage,
            state: toppingList[index].state,
            price: newPrice,
          );
          toppingList
              .refresh(); // Refresca la lista para actualizar la interfaz
        }
        Get.snackbar(
          'topping Actualizado',
          'El topping ha sido actualizado a $newName',
        );
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Hubo un problema al actualizar el topping: ${e.toString()}',
      );
    }
  }

  void updateToopingState(String toppingId, bool newState) async {
    try {
      // Actualiza solo el nombre de la categoría en Firestore
      await db.collection('toppings').doc(toppingId).update({
        'state': newState,
      }).then((_) {
        // Actualiza solo el nombre en la lista observable
        int index =
            toppingList.indexWhere((product) => product.id == toppingId);
        if (index != -1) {
          toppingList[index] = Topping(
            id: toppingId,
            name: toppingList[index].name.toLowerCase(),
            state: newState,

            image: toppingList[index].image,

            price: toppingList[index]
                .price
                .toDouble(), // Mantiene el estado existente,
          );
          toppingList
              .refresh(); // Refresca la lista para actualizar la interfaz
        }
        Get.snackbar(
          'Estado Actualizado',
          'El estado del topping ha sido actualizado',
        );
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Hubo un problema al actualizar el estado del topping: ${e.toString()}',
      );
    }
  }

  void deleteTopping(String toppingId, String name) async {
    try {
      await db.collection('toppings').doc(toppingId).delete().then((_) {
        // Actualiza la lista al eliminar la categoría
        toppingList.removeWhere((topping) => topping.id == toppingId);
        Get.snackbar(
          'topping Eliminado',
          'El topping $name ha sido eliminado exitosamente',
        );
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Hubo un problema al eliminar el topping: ${e.toString()}',
      );
    }
  }
}

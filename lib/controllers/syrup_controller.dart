import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happycream/models/syrup.dart';

class SyrupController extends GetxController {
  final Rx<TextEditingController> name = TextEditingController().obs;
  final Rx<TextEditingController> price = TextEditingController().obs;
  static SyrupController syrupController = Get.find();
  final RxList<Syrup> syrupList = <Syrup>[].obs;
  final db = FirebaseFirestore.instance;

  final RxBool isLoading = false.obs; // Añadido para el estado de carga

  var tTopings = 0.obs;
  String imgURL = '';

  @override
  void onInit() {
    super.onInit();
    getSyrups();
  }

  void addSyrup() async {
    try {
      var syrup = Syrup(
        id: '',
        name: name.value.text.toLowerCase(),
        state: true,
        image: imgURL,
        price: double.tryParse(price.value.text) ?? 0.0,
      );

      await db.collection('syrups').add(syrup.toMap()).then((docRef) {
        syrupList.add(Syrup(
            id: docRef.id,
            name: syrup.name,
            state: syrup.state,
            image: syrup.image,
            price: syrup.price));
        Get.snackbar(
          'salsa Añadido',
          'El salsa ${name.value.text} ha sido añadido exitosamente',
        );
        name.value.clear();
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Hubo un problema al añadir el salsa: ${e.toString()}',
      );
    }
  }

  void getSyrups() async {
    isLoading.value = true; // Comienza la carga
    try {
      var syrups = await db.collection('syrups').get();
      syrupList.clear();
      for (var syrup in syrups.docs) {
        syrupList.add(Syrup.fromMap(syrup.data(), syrup.id));
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

  void updateSyrup(
    String syrupId,
    String newName,
    String newImage,
    double newPrice,
  ) async {
    try {
      // Actualiza los campos del producto en Firestore
      await db.collection('syrups').doc(syrupId).update({
        'name': newName.toLowerCase(),
        'image': newImage,
        'price': newPrice,
      }).then((_) {
        // Actualiza el producto en la lista observable
        int index =
            syrupList.indexWhere((topping) => topping.id == syrupId);
        if (index != -1) {
          syrupList[index] = Syrup(
            id: syrupId,
            name: newName.toLowerCase(),
            image: newImage,
            state: syrupList[index].state,
            price: newPrice,
          );
          syrupList
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

  void updateSyrupState(String toppingId, bool newState) async {
    try {
      // Actualiza solo el nombre de la categoría en Firestore
      await db.collection('syrups').doc(toppingId).update({
        'state': newState,
      }).then((_) {
        // Actualiza solo el nombre en la lista observable
        int index =
            syrupList.indexWhere((syrup) => syrup.id == toppingId);
        if (index != -1) {
          syrupList[index] = Syrup(
            id: toppingId,
            name: syrupList[index].name.toLowerCase(),
            state: newState,

            image: syrupList[index].image,

            price: syrupList[index]
                .price
                .toDouble(), // Mantiene el estado existente,
          );
          syrupList
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

  void deleteSyrup(String syrupId, String name) async {
    try {
      await db.collection('syrups').doc(syrupId).delete().then((_) {
        // Actualiza la lista al eliminar la categoría
        syrupList.removeWhere((syrup) => syrup.id == syrupId);
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

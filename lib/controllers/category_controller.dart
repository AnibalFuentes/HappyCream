import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happycream/models/category.dart';

class CategoryController extends GetxController {
  final Rx<TextEditingController> name = TextEditingController().obs;
  static CategoryController categoryController = Get.find();
  final RxList<Category> categoryList = <Category>[].obs;
  final db = FirebaseFirestore.instance;
  final RxBool isLoading = false.obs; 

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  void addCategory() async {
    try {
      var category = Category(
        id: '', // No necesitas el id aquí, se genera automáticamente en Firestore
        tProduct: 0,
        name: name.value.text.toLowerCase(),
        state: true,
      );

      // Intenta añadir la categoría
      await db.collection('categories').add(category.toMap()).then((docRef) {
        // Actualiza la lista después de añadir la categoría
        categoryList.add(Category(
            id: docRef.id, name: category.name, tProduct: category.tProduct,state: category.state));
        Get.snackbar(
          'Categoría Añadida',
          'La categoría ${name.value.text} ha sido añadida exitosamente',
        );
        name.value.clear();
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Hubo un problema al añadir la categoría: ${e.toString()}',
      );
    }
  }

   getCategories() async {
    isLoading.value = true; 
    try {
      var categories = await db.collection('categories').get();
      categoryList.clear();
      for (var category in categories.docs) {
        // Incluye el id del documento al convertir a modelo
        categoryList.add(Category.fromMap(category.data(), category.id));
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Hubo un problema al obtener las categorías: ${e.toString()}',
      );
    }finally{
      isLoading.value = false;
    }
    
  }

  void updateCategoryName(String categoryId, String newName) async {
    try {
      // Actualiza solo el nombre de la categoría en Firestore
      await db.collection('categories').doc(categoryId).update({
        'name': newName.toLowerCase(),
      }).then((_) {
        // Actualiza solo el nombre en la lista observable
        int index =
            categoryList.indexWhere((category) => category.id == categoryId);
        if (index != -1) {
          categoryList[index] = Category(
            tProduct:categoryList[index].tProduct ,
            id: categoryId,
            name: newName.toLowerCase(),
            state: categoryList[index].state, // Mantiene el estado existente
          );
          categoryList
              .refresh(); // Refresca la lista para actualizar la interfaz
        }
        Get.snackbar(
          'Categoría Actualizada',
          'El nombre de la categoría ha sido actualizado a ${newName}',
        );
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Hubo un problema al actualizar el nombre de la categoría: ${e.toString()}',
      );
    }
  }

  void updateCategoryState(String categoryId, bool newState) async {
    try {
      // Actualiza solo el nombre de la categoría en Firestore
      await db.collection('categories').doc(categoryId).update({
        'state': newState,
      }).then((_) {
        // Actualiza solo el nombre en la lista observable
        int index =
            categoryList.indexWhere((category) => category.id == categoryId);
        if (index != -1) {
          categoryList[index] = Category(
            id: categoryId,
            tProduct: categoryList[index].tProduct,
            name: categoryList[index].name.toLowerCase(),
            state: newState,
          );
          categoryList
              .refresh(); // Refresca la lista para actualizar la interfaz
        }
        Get.snackbar(
          'Estado Actualizado',
          'El nombre de la categoría ha sido actualizado a ',
        );
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Hubo un problema al actualizar el nombre de la categoría: ${e.toString()}',
      );
    }
  }

 deleteCategory(String categoryId, String name) async {
    try {
      await db.collection('categories').doc(categoryId).delete().then((_) {
        // Actualiza la lista al eliminar la categoría
        categoryList.removeWhere((category) => category.id == categoryId);
        Get.snackbar(
          'Categoría Eliminada',
          'La categoría $name ha sido eliminada exitosamente',
        );
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Hubo un problema al eliminar la categoría: ${e.toString()}',
      );
    }
  }
}

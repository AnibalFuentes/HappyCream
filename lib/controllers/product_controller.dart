import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happycream/controllers/category_controller.dart';
import 'package:happycream/models/product.dart';

class ProductController extends GetxController {
  final Rx<TextEditingController> name = TextEditingController().obs;
  final Rx<TextEditingController> description = TextEditingController().obs;
  final Rx<TextEditingController> price = TextEditingController().obs;
  static ProductController productController = Get.find();
  final RxList<Product> productList = <Product>[].obs;

  final CategoryController categoryController = Get.find<CategoryController>();
  final db = FirebaseFirestore.instance;
  final RxString categoryId = ''.obs;
  final RxBool isLoading = false.obs; // Añadido para el estado de carga

  var tProducts = 0.obs;
  String imgURL = '';

  @override
  void onInit() {
    super.onInit();
    ever(categoryId, (_) => getProductosCategory());
  }

  void addProduct(String categoryId) async {
    try {
      var product = Product(
        id: '',
        name: name.value.text.toLowerCase(),
        state: true,
        description: description.value.text.toLowerCase(),
        image: imgURL,
        categoryId: categoryId,
        price: double.tryParse(price.value.text) ?? 0.0,
      );

      await db.collection('products').add(product.toMap()).then((docRef) {
        productList.add(Product(
            id: docRef.id,
            name: product.name,
            state: product.state,
            description: product.description,
            image: product.image,
            categoryId: product.categoryId,
            price: product.price));
        Get.snackbar(
          'Producto Añadido',
          'El producto ${name.value.text} ha sido añadido exitosamente',
        );
        name.value.clear();
      }).then((_) async {
        updateCategoryLength();
        await categoryController.getCategories();
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Hubo un problema al añadir el producto: ${e.toString()}',
      );
    }
  }

  void getProductosCategory() async {
    isLoading.value = true; // Comienza la carga
    try {
      var products = await db
          .collection('products')
          .where('categoryId', isEqualTo: categoryId.value)
          .get();
      productList.clear();
      for (var product in products.docs) {
        productList.add(Product.fromMap(product.data(), product.id));
      }
      tProducts.value = productList.length;
      print(tProducts.toString());
    } catch (e) {
      Get.snackbar(
        'Error',
        'Hubo un problema al obtener los productos: ${e.toString()}',
      );
    } finally {
      isLoading.value = false; // Termina la carga
    }
  }

  void updateProducto(
    String productId,
    String newName,
    String newDescription,
    String newImage,
    double newPrice,
  ) async {
    try {
      // Actualiza los campos del producto en Firestore
      await db.collection('products').doc(productId).update({
        'name': newName.toLowerCase(),
        'description': newDescription.toLowerCase(),
        'image': newImage,
        'price': newPrice,
      }).then((_) {
        // Actualiza el producto en la lista observable
        int index =
            productList.indexWhere((product) => product.id == productId);
        if (index != -1) {
          productList[index] = Product(
            id: productId,
            name: newName.toLowerCase(),
            description: newDescription.toLowerCase(),
            image: newImage,
            state: productList[index].state,
            price: newPrice,
            categoryId: productList[index].categoryId,
          );
          productList
              .refresh(); // Refresca la lista para actualizar la interfaz
        }
        Get.snackbar(
          'Producto Actualizado',
          'El producto ha sido actualizado a $newName',
        );
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Hubo un problema al actualizar el producto: ${e.toString()}',
      );
    }
  }

  void updateProductState(String productId, bool newState) async {
    try {
      // Actualiza solo el nombre de la categoría en Firestore
      await db.collection('products').doc(productId).update({
        'state': newState,
      }).then((_) {
        // Actualiza solo el nombre en la lista observable
        int index =
            productList.indexWhere((product) => product.id == productId);
        if (index != -1) {
          productList[index] = Product(
            id: productId,
            name: productList[index].name.toLowerCase(),
            state: newState,
            description: productList[index].description.toLowerCase(),
            image: productList[index].image,
            categoryId: productList[index].categoryId,
            price: productList[index]
                .price
                .toDouble(), // Mantiene el estado existente,
          );
          productList
              .refresh(); // Refresca la lista para actualizar la interfaz
        }
        Get.snackbar(
          'Estado Actualizado',
          'El estado del producto ha sido actualizado',
        );
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Hubo un problema al actualizar el estado del producto: ${e.toString()}',
      );
    }
  }

  void updateCategoryLength() async {
    try {
      // Actualiza solo el nombre de la categoría en Firestore
      await db.collection('categories').doc(categoryId.value).update({
        'tProduct': productList.length,
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Hubo un problema al actualizar el nombre de la categoría: ${e.toString()}',
      );
    }
  }

  void deleteProduct(String productId, String name) async {
    try {
      await db.collection('products').doc(productId).delete().then((_) {
        // Actualiza la lista al eliminar la categoría
        productList.removeWhere((product) => product.id == productId);
        Get.snackbar(
          'Producto Eliminado',
          'El producto $name ha sido eliminado exitosamente',
        );
      }).then((_) async {
        updateCategoryLength();
        await categoryController.getCategories();
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Hubo un problema al eliminar el producto: ${e.toString()}',
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happycream/UI/widgets/text_field.dart';
import 'package:happycream/controllers/category_controller.dart';
import 'package:happycream/controllers/product_controller.dart';
import 'package:happycream/models/category.dart';
import 'package:happycream/UI/widgets/alert_dialog_widget.dart';
import 'package:happycream/models/product.dart';

 showProductDialog({
  required BuildContext context,
  required bool isEditing,
  Product? product,
  String? categoryId,
}) {
  final ProductController controller = Get.find<ProductController>();

  if (isEditing && product != null) {
    // Inicializa los controladores con los valores actuales del producto para edición
    controller.name.value.text = product.name;
    controller.description.value.text = product.description;
    controller.price.value.text = product.price.toString();
   
  } else {
    // Limpia los controladores para agregar un nuevo producto
    controller.name.value.clear();
    controller.description.value.clear();
    controller.price.value.clear();
    
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialogWidget(
        title: isEditing ? 'Editar Producto' : 'Añadir Producto',
        contentWidgets: [
          CustomTextFormField(
            keyboardType: TextInputType.text,
            controller: controller.name.value,
            labelText: 'Nombre',
            hintText: 'Ingrese el nombre',
          ),
          CustomTextFormField(
            keyboardType: TextInputType.multiline,
            controller: controller.description.value,
            labelText: 'Descripción',
            hintText: 'Ingrese la descripción',
          ),
          CustomTextFormField(
            keyboardType: TextInputType.number,
            controller: controller.price.value,
            labelText: 'Precio',
            hintText: 'Ingrese el precio',
          ),
          
        ],
        onConfirm: () {
          final newName = controller.name.value.text.trim();
          final newDescription = controller.description.value.text.trim();
          final newPrice = double.tryParse(controller.price.value.text) ?? 0.0;
          final newImage = controller.imgURL;

          if (newName.isNotEmpty && newDescription.isNotEmpty ) {
            if (isEditing && product != null) {
              // Actualiza el producto existente
              controller.updateProducto(
                product.id,
                newName,
                newDescription,
                newImage,
                newPrice,
              );
            } else {
              // Añade un nuevo producto
              controller.addProduct(
                categoryId!

              );
            }
            Navigator.of(context).pop(); // Cierra el diálogo
          } else {
            Get.snackbar('Error', 'Por favor, completa todos los campos correctamente');
          }
        },
        onCancel: () {
          Navigator.of(context).pop(); // Cierra el diálogo
        },
      );
    },
  );
}

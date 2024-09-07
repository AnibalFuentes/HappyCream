import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happycream/UI/widgets/text_field.dart';
import 'package:happycream/controllers/topping_controller.dart';
import 'package:happycream/UI/widgets/alert_dialog_widget.dart';
import 'package:happycream/models/topping.dart';

showToppingDialog(
    {required BuildContext context,
    required bool isEditing,
    Topping? topping}) {
  final ToppingController controller = Get.find<ToppingController>();

  if (isEditing && topping != null) {
    // Inicializa los controladores con los valores actuales del producto para edición
    controller.name.value.text = topping.name;

    controller.price.value.text = topping.price.toString();
  } else {
    // Limpia los controladores para agregar un nuevo producto
    controller.name.value.clear();

    controller.price.value.clear();
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialogWidget(
        title: isEditing ? 'Editar Topping' : 'Añadir Topping',
        contentWidgets: [
          CustomTextFormField(
            keyboardType: TextInputType.text,
            controller: controller.name.value,
            labelText: 'Nombre',
            hintText: 'Ingrese el nombre',
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

          final newPrice = double.tryParse(controller.price.value.text) ?? 0.0;
          final newImage = controller.imgURL;

          if (newName.isNotEmpty) {
            if (isEditing && topping != null) {
              // Actualiza el producto existente
              controller.updateTopping(
                topping.id,
                newName,
                newImage,
                newPrice,
              );
            } else {
              // Añade un nuevo producto
              controller.addTopping();
            }
            Navigator.of(context).pop(); // Cierra el diálogo
          } else {
            Get.snackbar(
                'Error', 'Por favor, completa todos los campos correctamente');
          }
        },
        onCancel: () {
          Navigator.of(context).pop(); // Cierra el diálogo
        },
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:happycream/UI/widgets/text_field.dart';
import 'package:happycream/controllers/syrup_controller.dart';
import 'package:happycream/controllers/topping_controller.dart';
import 'package:happycream/UI/widgets/alert_dialog_widget.dart';
import 'package:happycream/models/syrup.dart';

showSyrupDialog(
    {required BuildContext context, required bool isEditing, Syrup? syrup}) {
  final SyrupController controller = Get.find<SyrupController>();

  if (isEditing && syrup != null) {
    // Inicializa los controladores con los valores actuales del producto para edición
    controller.name.value.text = syrup.name;

    controller.price.value.text = syrup.price.toString();
  } else {
    // Limpia los controladores para agregar un nuevo producto
    controller.name.value.clear();

    controller.price.value.clear();
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialogWidget(
        title: isEditing ? 'Editar salsa' : 'Añadir salsa',
        contentWidgets: [
          CustomTextFormField(
            keyboardType: TextInputType.text,
            controller: controller.name.value,
            labelText: 'Nombre',
            hintText: 'Ingrese el nombre',
          ),
          const Gap(15),
          CustomTextFormField(
            formater: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
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
            if (isEditing && syrup != null) {
              // Actualiza el producto existente
              controller.updateSyrup(
                syrup.id,
                newName,
                newImage,
                newPrice,
              );
            } else {
              // Añade un nuevo producto
              controller.addSyrup();
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

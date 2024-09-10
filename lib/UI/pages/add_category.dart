import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:happycream/UI/widgets/text_field.dart';
import 'package:happycream/controllers/category_controller.dart';
import 'package:happycream/models/category.dart';
import 'package:happycream/UI/widgets/alert_dialog_widget.dart';

showCategoryDialog({
  required BuildContext context,
  required bool isEditing,
  Category? category,
}) {
  final CategoryController controller = Get.find<CategoryController>();

  if (isEditing) {
    // Inicializa el controlador con el nombre actual para edición
    controller.name.value.text = category?.name ?? '';
    controller.description.value.text = category?.description ?? '';
  } else {
    // Limpia el controlador para nueva categoría
    controller.name.value.clear();
    controller.description.value.clear();
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialogWidget(
        title: isEditing ? 'Editar Categoría' : 'Añadir Categoría',
        contentWidgets: [
          CustomTextFormField(
            hintText: 'Ingrese el nombre',
            labelText: 'Nombre',
            controller: controller.name.value,
          ),
          const Gap(15),
          CustomTextFormField(
            hintText: 'Ingrese la descripcion',
            labelText: 'Descripcion',
            keyboardType: TextInputType.multiline,
            controller: controller.description.value,
            maxline: 5,
          ),
        ],
        onConfirm: () {
          final newName = controller.name.value.text.trim();
          final newDescription = controller.description.value.text.trim();
          if (newName.isNotEmpty) {
            if (isEditing) {
              // Actualiza la categoría
              if (category != null) {
                controller.updateCategoryName(
                    category.id, newName, newDescription);
              }
            } else {
              // Añade una nueva categoría
              controller.addCategory();
            }
            Navigator.of(context).pop(); // Cierra el diálogo
          } else {
            Get.snackbar('Error', 'El nombre no puede estar vacío');
          }
        },
        onCancel: () {
          Navigator.of(context).pop(); // Cierra el diálogo
        },
      );
    },
  );
}

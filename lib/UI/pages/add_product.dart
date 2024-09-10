import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
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
    controller.topping.value = product.topping;
    controller.syrup.value = product.syrup;
    controller.cTopping.value = product.cTopping;
    controller.cSyrup.value = product.cSyrup;
  } else {
    // Limpia los controladores para agregar un nuevo producto
    controller.name.value.clear();
    controller.description.value.clear();
    controller.price.value.clear();
    controller.topping.value = false;
    controller.syrup.value = false;
    controller.cTopping.value = 0;
    controller.cSyrup.value = 0;
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Obx(() {
        return AlertDialogWidget(
          title: isEditing ? 'Editar Producto' : 'Añadir Producto',
          contentWidgets: [
            CustomTextFormField(
              keyboardType: TextInputType.text,
              controller: controller.name.value,
              labelText: 'Nombre',
              hintText: 'Ingrese el nombre',
            ),
            const Gap(15),
            CustomTextFormField(
              keyboardType: TextInputType.number,
              controller: controller.price.value,
              labelText: 'Precio',
              hintText: 'Ingrese el precio',
              formater: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const Gap(15),
            CustomTextFormField(
              keyboardType: TextInputType.multiline,
              controller: controller.description.value,
              labelText: 'Descripción',
              hintText: 'Ingrese la descripción',
              maxline: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Topping'),
                Switch(
                    value: controller.topping.value,
                    onChanged: (newState) {
                      controller.topping.value = newState;
                    })
              ],
            ),
            controller.topping.value
                ? Row(
                    children: [
                      const Text('N° Toppings: '),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                if (controller.cTopping.value > 1) {
                                  controller.cTopping.value--;
                                }
                              },
                              icon: Icon(Icons.remove)),
                          Text(controller.cTopping.value.toString()),
                          IconButton(
                              onPressed: () {
                                controller.cTopping.value++;
                              },
                              icon: Icon(Icons.add))
                        ],
                      )
                    ],
                  )
                : Text(''),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Salsa'),
                Switch(
                    value: controller.syrup.value,
                    onChanged: (newState) {
                      controller.syrup.value = newState;
                    })
              ],
            ),
            controller.syrup.value
                ? Row(
                    children: [
                      Text('N° salsas: '),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                if (controller.cSyrup.value > 1) {
                                  controller.cSyrup.value--;
                                }
                              },
                              icon: Icon(Icons.remove)),
                          Text(controller.cSyrup.value.toString()),
                          IconButton(
                              onPressed: () {
                                controller.cSyrup.value++;
                              },
                              icon: Icon(Icons.add))
                        ],
                      )
                    ],
                  )
                : Text(''),
          ],
          onConfirm: () {
            final newName = controller.name.value.text.trim();
            final newDescription = controller.description.value.text.trim();
            final newImage = controller.imgURL;
            final newPrice =
                double.tryParse(controller.price.value.text) ?? 0.0;
            final newTopping = controller.topping.value;
            final newSyrup = controller.syrup.value;
            final newcTopping = controller.cTopping.value;
            final newcSyrup = controller.cSyrup.value;

            if (newName.isNotEmpty && newDescription.isNotEmpty) {
              if (isEditing && product != null) {
                // Actualiza el producto existente
                controller.updateProducto(
                    product.id,
                    newName,
                    newDescription,
                    newImage,
                    newPrice,
                    newTopping,
                    newSyrup,
                    newcTopping,
                    newcSyrup);
              } else {
                // Añade un nuevo producto
                controller.addProduct(categoryId!);
              }
              Navigator.of(context).pop(); // Cierra el diálogo
            } else {
              Get.snackbar('Error',
                  'Por favor, completa todos los campos correctamente');
            }
          },
          onCancel: () {
            Navigator.of(context).pop(); // Cierra el diálogo
          },
        );
      });
    },
  );
}

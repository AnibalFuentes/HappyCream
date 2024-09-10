import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happycream/UI/pages/add_syrup.dart';
import 'package:happycream/UI/pages/add_topping.dart';
import 'package:happycream/UI/widgets/alert_dialog_widget.dart';
import 'package:happycream/controllers/syrup_controller.dart';

class SyrupPage extends StatelessWidget {
  const SyrupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SyrupController controller = Get.find<SyrupController>();

    return Scaffold(
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.syrupList.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min, // Para centrar verticalmente
                mainAxisAlignment:
                    MainAxisAlignment.center, // Alineación vertical
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Alineación horizontal
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      size: 45,
                    ),
                    onPressed: () => showToppingDialog(
                      context: context,
                      isEditing: false,
                    ),
                  ),
                  const Text(
                    'Añade una salsa',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: controller.syrupList.map((syrup) {
                    return Card(
                      child: Dismissible(
                        key: ValueKey(syrup.id),
                        background: Container(
                          color: Colors.blue,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.edit, color: Colors.white),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete_forever,
                              color: Colors.white),
                        ),
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.startToEnd) {
                            // Acción para editar
                            final bool? shouldDismiss = await showSyrupDialog(
                              context: context,
                              isEditing: true,
                              syrup: syrup,
                            );
                            return shouldDismiss ?? false;
                          } else if (direction == DismissDirection.endToStart) {
                            // Acción para eliminar
                            final bool shouldDelete = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialogWidget(
                                  title: 'Eliminar salsa',
                                  contentWidgets: [
                                    Text(
                                      '¿Estás seguro de que deseas eliminar la salsa ${syrup.name}?',
                                    ),
                                  ],
                                  onCancel: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  onConfirm: () {
                                    Navigator.of(context).pop(true);
                                  },
                                );
                              },
                            );
                            if (shouldDelete) {
                              controller.deleteSyrup(syrup.id, syrup.name);
                            }
                            return shouldDelete;
                          }
                          return false;
                        },
                        child: ExpansionTile(
                            subtitle: Text(
                              syrup.state ? 'Visible' : 'Oculto',
                              style: TextStyle(
                                  color:
                                      syrup.state ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            leading: GestureDetector(
                              onTap: () {},
                              child: const CircleAvatar(
                                child: Icon(Icons.add_photo_alternate),
                              ),
                            ),
                            title: Text(
                              syrup.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            children: [
                              ListTile(
                                title: Text(
                                    '\$ ${syrup.price.toStringAsFixed(2)}'),
                                trailing: Switch(
                                  activeColor: Colors.grey,
                                  activeTrackColor: Colors.lightGreen,
                                  value: syrup.state,
                                  onChanged: (newState) {
                                    controller.updateSyrupState(
                                        syrup.id, newState);
                                  },
                                ),
                              ),
                            ]),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

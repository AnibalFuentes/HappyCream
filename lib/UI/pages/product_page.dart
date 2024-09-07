import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happycream/controllers/product_controller.dart';
import 'package:happycream/UI/pages/add_product.dart';

class ProductPage extends StatelessWidget {
  final String categoryId;
  final String categoryName;

  const ProductPage(
      {super.key, required this.categoryId, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();

    controller.categoryId.value = categoryId;

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName.toUpperCase()),
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: controller.productList.map((product) {
                    return Card(
                      child: Dismissible(
                        key: ValueKey(product.id),
                        direction: DismissDirection
                            .horizontal, // Permitir deslizamiento en ambas direcciones
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
                            final bool? shouldDismiss = await showProductDialog(
                              context: context,
                              isEditing: true,
                              product: product,
                            );
                            return shouldDismiss ?? false;
                          } else if (direction == DismissDirection.endToStart) {
                            // Acción para eliminar
                            final bool shouldDelete = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Eliminar producto'),
                                  content: Text(
                                    '¿Estás seguro de que deseas eliminar el producto ${product.name}?',
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text('Eliminar'),
                                    ),
                                  ],
                                );
                              },
                            );
                            if (shouldDelete) {
                              controller.deleteProduct(
                                  product.id, product.name);
                            }
                            return shouldDelete;
                          }
                          return false;
                        },
                        child: ExpansionTile(
                            subtitle: Text(
                              product.state ? 'Visible' : 'Oculto',
                              style: TextStyle(
                                  color:
                                      product.state ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            leading: GestureDetector(
                              onTap: () {},
                              child: const CircleAvatar(
                                child: Icon(Icons.add_photo_alternate),
                              ),
                            ),
                            title: Text(
                              product.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            children: [
                              ListTile(
                                title: Text(product.description.toString()),
                                subtitle:
                                    Text('precio\$${product.price.toString()}'),
                                trailing: Switch(
                                  activeColor: Colors.grey,
                                  activeTrackColor: Colors.lightGreen,
                                  value: product.state,
                                  onChanged: (newState) {
                                    controller.updateProductState(
                                        product.id, newState);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showProductDialog(
              context: context, isEditing: false, categoryId: categoryId);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

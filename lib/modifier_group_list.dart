import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modifier_group_form/modifier_group_form.dart';

import 'modifier_controller.dart';

class ModifierListScreen extends StatelessWidget {
  final ModifierController controller = Get.put(ModifierController());
  
  var modifier;

  ModifierListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchModifiers();

    return Scaffold(
      appBar: AppBar(title: Text("Modifier List")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.modifiers.length,
          itemBuilder: (context, index) {
            final modifier = controller.modifiers[index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: Offset(0, 4), // Shadow position
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                title: Text(modifier.name, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(modifier.description ?? "No description"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Edit Icon to navigate to the ModifierFormScreen for editing
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Navigate to the ModifierFormScreen for editing the selected modifier
                        Get.to(() => ModifierFormScreen(modifier: modifier));
                      },
                    ),
                    // Delete Icon to remove the modifier
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Confirm and delete the modifier
                        controller.deleteModifier(modifier.id, modifier.vendorId);
                      },
                    ),
                  ],
                ),
                onTap: () {
                  // Navigate to Edit Screen
                  Get.to(() => ModifierFormScreen(modifier: modifier));
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Create Modifier Screen
          Get.to(() => ModifierFormScreen(modifier: modifier));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

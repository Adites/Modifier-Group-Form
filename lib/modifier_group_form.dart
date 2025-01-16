import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modifier_group_form/modifier_group_model.dart';

import 'modifier_controller.dart';


class ModifierFormScreen extends StatelessWidget {
  final ModifierController controller = Get.find();

  final _formKey = GlobalKey<FormState>();

  // Text controllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController minQuantityController = TextEditingController();
  final TextEditingController maxQuantityController = TextEditingController();
  final TextEditingController pluController = TextEditingController();

  final ModifierGroup? modifier; // Pass this when editing

  ModifierFormScreen({Key? key, this.modifier}) : super(key: key) {
    // If editing, pre-fill the form fields with modifier data
    if (modifier != null) {
      nameController.text = modifier!.name;
      descriptionController.text = modifier!.description;
      skuController.text = modifier!.plu;
      minQuantityController.text = modifier!.min.toString();
      maxQuantityController.text = modifier!.max.toString();
      pluController.text = modifier!.plu;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(modifier == null ? "Create Modifier" : "Edit Modifier"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name Field
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the name.";
                  }
                  return null;
                },
              ),

              // Description Field
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),

              // SKU (PLU) Field
              TextFormField(
                controller: skuController,
                decoration: InputDecoration(labelText: "SKU (PLU)"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the SKU.";
                  }
                  return null;
                },
              ),

              // Min Quantity Field
              TextFormField(
                controller: minQuantityController,
                decoration: InputDecoration(labelText: "Min Quantity"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the minimum quantity.";
                  }
                  if (int.tryParse(value) == null) {
                    return "Please enter a valid number.";
                  }
                  return null;
                },
              ),

              // Max Quantity Field
              TextFormField(
                controller: maxQuantityController,
                decoration: InputDecoration(labelText: "Max Quantity"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the maximum quantity.";
                  }
                  if (int.tryParse(value) == null) {
                    return "Please enter a valid number.";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ModifierGroup newModifier = ModifierGroup(
                      id: modifier?.id ?? 0,
                      name: nameController.text,
                      nameLocale: "", // Placeholder for name locale
                      description: descriptionController.text,
                      descriptionLocale: "", // Placeholder for description locale
                      plu: skuController.text,
                      min: int.parse(minQuantityController.text),
                      max: int.parse(maxQuantityController.text),
                      active: true,
                      vendorId: 1,
                    );

                    if (modifier == null) {
                      // Create Modifier
                      controller.createModifier(newModifier);
                    } else {
                      // Edit Modifier
                      controller.editModifier(modifier!.id, newModifier);
                    }

                    Get.back(); // Return to the list screen
                  }
                },
                child: Text(modifier == null ? "Create" : "Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

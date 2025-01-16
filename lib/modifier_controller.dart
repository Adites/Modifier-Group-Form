import 'package:get/get.dart';
import 'package:modifier_group_form/modifier_group_model.dart';
import 'package:modifier_group_form/modifier_group_service.dart';

class ModifierController extends GetxController {
  var modifiers = <ModifierGroup>[].obs;
  var isLoading = false.obs;

  void fetchModifiers() async {
    try {
      isLoading.value = true;
      modifiers.value = await ApiService.fetchModifiers(1, 1, 10);
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void createModifier(ModifierGroup modifier) async {
    try {
      await ApiService.createModifier(modifier);
      fetchModifiers();
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void editModifier(int id, ModifierGroup modifier) async {
    try {
      await ApiService.editModifier(id, modifier);
      fetchModifiers();
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void deleteModifier(int modifierId, int vendorId) async {
    try {
      await ApiService.deleteModifier(modifierId, vendorId);
      fetchModifiers();
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}

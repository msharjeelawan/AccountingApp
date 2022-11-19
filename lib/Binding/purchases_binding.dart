
import 'package:get/get.dart';
import 'package:travel_accounting/Controller/purchase_controller.dart';

class PurchasesBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PurchasesController());
  }

}
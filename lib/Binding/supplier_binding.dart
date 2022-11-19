import 'package:get/get.dart';
import 'package:travel_accounting/Controller/supplier_controller.dart';

class SupplierBinding extends Bindings{

  @override
  void dependencies(){
    Get.lazyPut(() => SupplierController());
  }
}
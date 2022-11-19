
import 'package:get/get.dart';
import 'package:travel_accounting/Controller/sales_controller.dart';

class SalesBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => SalesController());
  }


}
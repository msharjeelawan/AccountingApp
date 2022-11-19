
import 'package:get/get.dart';
import 'package:travel_accounting/Controller/product_service_controller.dart';

class ProductServiceBinding extends Bindings{

  @override
  void dependencies(){
    Get.lazyPut(() => ProductServiceController());
  }

}
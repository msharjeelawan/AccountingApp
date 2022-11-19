
import 'package:get/get.dart';
import 'package:travel_accounting/Controller/clients_controller.dart';

class ClientsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ClientsController());
  }

}
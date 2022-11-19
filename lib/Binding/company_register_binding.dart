import 'package:get/get.dart';
import 'package:travel_accounting/Controller/company_register_controller.dart';

class CompanyRegisterBinding extends Bindings{

  @override
  void dependencies(){
    Get.lazyPut(() => CompanyRegisterController());
  }
}
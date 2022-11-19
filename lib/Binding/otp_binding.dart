

import 'package:get/get.dart';
import 'package:travel_accounting/Controller/otp_controller.dart';

class OtpBinding extends Bindings{

  @override
  void dependencies(){
    Get.lazyPut(() => OtpController());
  }

}
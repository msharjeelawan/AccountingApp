
import 'package:get/get.dart';
import 'package:travel_accounting/Controller/expense_controller.dart';

class ExpenseBinding extends Bindings{
  @override
  void dependencies() {
  Get.lazyPut(() => ExpenseController());
  }


}
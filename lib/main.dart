import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_accounting/Helper/Constant.dart';
import 'package:travel_accounting/Views/add_client.dart';
import 'package:travel_accounting/Views/add_product_service.dart';
import 'package:travel_accounting/Views/add_supplier.dart';
import 'package:travel_accounting/Views/company_register_screen.dart';
import 'package:travel_accounting/Views/dashboard_screen.dart';
import 'package:travel_accounting/Views/login_screen.dart';
import 'package:travel_accounting/Views/products_services_screen.dart';
import 'package:travel_accounting/widgets/search_modal.dart';

import 'Views/add_expense_screen.dart';
import 'Views/add_sales_screen.dart';
import 'Views/add_purchase.dart';
import 'Views/add_user_screen.dart';
import 'Views/all_users_screen.dart';
import 'Views/clients_screen.dart';
import 'Views/expenses_screen.dart';
import 'Views/main_screen.dart';
import 'Views/purchases_screen.dart';
import 'Views/register_screen.dart';
import 'Views/sales_screen.dart';
import 'Views/services_selection_screen.dart';
import 'Views/setting_screen.dart';
import 'Views/splash_screen.dart';
import 'Views/supplier_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Map<String,WidgetBuilder> routes = <String,WidgetBuilder>{
      '/splash': (context) => const SplashScreen(),
      '/register': (context) => const Register(),
      '/login': (context) => const LoginScreen(),
      '/companyRegisterScreen': (context) => CompanyRegisterScreen(),
      '/dashboard': (context) => const DashboardScreen(),
      '/clients': (context) => ClientScreen(),
      '/productService': (context) => ProductServiceScreen(),
      '/addClient': (context) => AddClient(),
      '/addProductService': (context) => AddProductService(),
      '/addSupplier': (context) => AddSupplier(),
      '/addExpense': (context) => AddExpenseScreen(),
      '/addSale': (context) => AddSalesScreen(),
      '/serviceSelectionScreen': (context) => ServiceSelectionScreen(),
      '/setting': (context) => SettingScreen(),
      '/allUser': (context) => const AllUserScreen(),
      '/addUser': (context) => const AddUserScreen(),
      '/main': (context) => const MainScreen(),
      '/suppliers': (context) => SupplierScreen(),
      '/purchases': (context) => PurchasesScreen(),
      '/addPurchase': (context) => AddPurchase(),
      '/sales': (context) => SalesScreen(),
      '/search': (context) => const SearchModal(),
      '/expenses': (context) => ExpensesScreen(),
    };

    return Sizer(
        builder: (context,orientation,deviceType){
          return GetMaterialApp(
            title: 'Travel Accounting',
            theme: ThemeData(
            //  appBarTheme: const AppBarTheme(backgroundColor: white,titleTextStyle: TextStyle(color: Colors.black,fontSize: 20,),systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light)),
              primarySwatch: const MaterialColor(0xFF9a46b4, primarySwatch),
              scaffoldBackgroundColor: white,
              iconTheme: const IconThemeData(
                  color: primaryColor2
              ),
              inputDecorationTheme: InputDecorationTheme(
                prefixStyle: const TextStyle(color: primaryColor1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:  const BorderSide(
                    color: Color.fromRGBO(154,70,180, 1),
                  ),
                ),
              )
            ),
            routes: routes,
            initialRoute: '/splash',
            debugShowCheckedModeBanner: false,
          );
        });
  }
}



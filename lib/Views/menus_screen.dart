import 'package:flutter/material.dart';

class MenusScreen extends StatefulWidget {
  const MenusScreen({Key? key}) : super(key: key);

  @override
  State<MenusScreen> createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
  List<String> menus=["Products & Services","Suppliers","Customers","Purchases","Sales","Expenses"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemCount: menus.length,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text(menus[index]),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: const BorderSide(color: Colors.black38)),
                onTap: (){
                  handleNavigation(index,context);
                },
              ),
            );
          }
      ),
    );
  }

  void handleNavigation(int index,context){
    if(index==0){
      Navigator.pushNamed(context, '/productService');
    }else if(index==1){
      Navigator.pushNamed(context, '/suppliers');
    }else if(index==2){
      Navigator.pushNamed(context, '/clients');
    }else if(index==3){
      Navigator.pushNamed(context, '/purchases');
    }else if(index==4){
      Navigator.pushNamed(context, '/sales');
    }else if(index==5){
      Navigator.pushNamed(context, '/expenses');
    }
  }
}

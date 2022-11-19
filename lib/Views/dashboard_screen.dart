import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:travel_accounting/Helper/Constant.dart';

class DashboardScreen extends GetView{

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      // appBar: AppBar(
      //   title: const Text("Todo List"),
      //   elevation: 0.0,
      //
      // ),
      body: SafeArea(
        child: GridView.builder(
            itemCount: 20,
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 5
            ),
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, '/clientScreen');
                },
                child: Card(
                  shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.black38),borderRadius: BorderRadius.circular(25)),
                  elevation: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(Icons.business,size: 50,color: Colors.black54,),
                      Text("Customer",style: TextStyle(fontSize: 15,color: Colors.black54),)
                    ],
                  ),
                ),
              );
            }
        )
      ),
    );
  }


}
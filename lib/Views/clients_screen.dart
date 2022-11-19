import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:travel_accounting/Controller/clients_controller.dart';
import 'package:travel_accounting/Model/client_model.dart';

import '../Helper/Constant.dart';

class ClientScreen extends GetView {
  @override
  final ClientsController controller = Get.put(ClientsController());
  ClientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text("Clients"),
        elevation: 0.0,
        // actions: [
        //   IconButton(
        //       onPressed: (){
        //
        //       },
        //       icon: const Icon(Icons.settings)
        //   )
        // ],
      ),
      body: SafeArea(
          child: FutureBuilder(
              future: controller.getClients(context),
              builder: (context, snapshot) {

                if(snapshot.connectionState==ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator());
                }

                if(!snapshot.hasData){
                  return const Center(child: Text("No data found"),);
                }

                var clientList = snapshot.data as List<ClientModel>;
                controller.lengthOfMyClientsInFirestore.value = clientList.length;

                if(clientList.isEmpty){
                  //when response return null
                  return const Center(child: Text("No data found"),);
                }

                return Obx(() {
                  return ListView.builder(
                      itemCount: controller.lengthOfMyClientsInFirestore.value,
                      itemExtent: 100,
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                      itemBuilder: (context,index){
                        return GestureDetector(
                          child: Card(
                            shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.black38),borderRadius: BorderRadius.circular(15)),
                            elevation: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(Icons.person_pin,size: 50,color: Colors.black54,),
                                Container(
                                  // color: Colors.black38,
                                  width: getWidth(context)*0.45,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Text(clientList[index].name,style: TextStyle(fontSize: 3.h,color: Colors.black54,overflow: TextOverflow.ellipsis),),
                                      Text(clientList[index].email,style: TextStyle(fontSize: 2.h,color: Colors.black54,overflow: TextOverflow.ellipsis),),
                                      Text(clientList[index].address,style: TextStyle(fontSize: 2.h,color: Colors.black54,overflow: TextOverflow.ellipsis),)
                                    ],
                                  ),
                                ),
                                Container(
                                  // color: Colors.black12,
                                  width: getWidth(context)*0.3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Flexible(child: Text(clientList[index].contact,style: TextStyle(fontSize: 2.h,color: Colors.black54),)),
                                      Flexible(child: Text(clientList[index].passport,style: TextStyle(fontSize: 2.h,color: Colors.black54),))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  );
                });
              }
          )
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: (){
            Navigator.pushNamed(context, '/addClient');
          }
      ),
    );
  }
}

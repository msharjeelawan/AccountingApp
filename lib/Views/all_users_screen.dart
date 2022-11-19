import 'package:flutter/material.dart';
import 'package:travel_accounting/Model/User.dart';
import 'package:travel_accounting/service/firebase_crud_methods.dart';

class AllUserScreen extends StatefulWidget {
  const AllUserScreen({Key? key}) : super(key: key);

  @override
  State<AllUserScreen> createState() => _AllUserScreenState();
}

class _AllUserScreenState extends State<AllUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Users"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add,),
            onPressed: () async {
              await Navigator.pushNamed(context, '/addUser');
              getAllCompanyUsers();
                  setState((){});
              })
        ],
      ),
      body: FutureBuilder(
        future: getAllCompanyUsers(),
        builder: (context,snapshot){

          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          if(!snapshot.hasData){
            return const Center(child: Text("No data found"),);
          }

          var userList = snapshot.data as List<UserModel>;
          if(userList.isEmpty){
            //when response return null
            return const Center(child: Text("No data found"),);
          }

          return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context,index){
                return ListTile(
                  title: Text(userList[index].name!),
                  subtitle: Text(userList[index].email!.isNotEmpty? userList[index].email! : userList[index].number!),
                );
              }
          );
        },
      ),
    );
  }


  Future<List<UserModel>> getAllCompanyUsers() async {
    var documentList = await FirebaseCrudMethods(context: context).query(collection: "users", field: "companyId", isEqualTo: UserModel.myInstance.companyId,showDialog: false);
    var list = UserModel.mapToModel(documentList);
    return list;
  }
}

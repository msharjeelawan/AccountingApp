import 'package:flutter/material.dart';

class SearchModal extends StatefulWidget {
  const SearchModal({Key? key}) : super(key: key);

  @override
  State<SearchModal> createState() => _SearchModalState();
}

class _SearchModalState extends State<SearchModal> {
  var leadingIcon = const Icon(Icons.search);
  Widget title = const Text("Search");
  var filter = TextEditingController();
  var searchText = "";
  var names = ["Muhammad Sharjeel Awan","Nauman Arshad","Atique ur Rehman","Anas Afzal"];
  var searchedNames = ["Muhammad Sharjeel Awan","Nauman Arshad","Atique ur Rehman","Anas Afzal"];
  _SearchModalState(){
    filter.addListener(() {
      if(filter.text.isEmpty){
        setState(() {
          searchText = "";
          searchedNames = names;
        });
      }else{
        setState(() {
          searchText = filter.text;
          search();
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
                searchBarHandler();
              },
              icon: leadingIcon
          ),
        ],
        // leading: IconButton(
        //     onPressed: (){
        //       searchBarHandler();
        //     },
        //     icon: leadingIcon
        // ),
        title: title,
      ),
      body: ListView.builder(
          itemCount: searchedNames.length,
          itemBuilder: (context,index){
            return ListTile(
              title: Text(searchedNames[index]),
              onTap: (){
               Navigator.pop(context,searchedNames[index]);
              },
            );
          }
      ),
    );
  }

  void search(){
    var tempNames = <String>[];
    names.forEach((name) {
      if(name.toLowerCase().contains(searchText.toLowerCase())){
        tempNames.add(name);
      }
    });
    searchedNames = tempNames;

  }

  void searchBarHandler(){
    if(leadingIcon.icon==Icons.search){
      leadingIcon = const Icon(Icons.close);
      title = TextFormField(
        controller: filter,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderSide: BorderSide.none
          ),
        ),
      );
    }else{
      leadingIcon = const Icon(Icons.search);
      title = const Text("Search");
      searchedNames = names;
    }
    setState(() {

    });
  }
}

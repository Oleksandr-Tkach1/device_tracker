import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_tracker/helper/creation_of_a_common_room.dart';
import 'package:device_tracker/helper/database.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchTextEditingController = TextEditingController();

  late QuerySnapshot searchSnapshot;

  Widget searchList() {
    return searchSnapshot != null && searchSnapshot.size > 0 ? ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 392.7,
      ),
      child: ListView.builder(
          itemCount: searchSnapshot.docs.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return SearchedItemTile(
              deviceName: searchSnapshot.docs[index]["name"],
              userEmail: searchSnapshot.docs[index]["email"],
            );
          }),
    )
        : Container();
  }

  initiateSearch() {
    databaseMethods
        .getUserByUsername(searchTextEditingController.text)
        .then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  Widget SearchedItemTile({String? userName, String? userEmail, deviceName}) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        children: [
          Container(padding: EdgeInsets.only(bottom: 28), width: 25, height: 45, child: Icon(Icons.phone_android, size: 30,)),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                deviceName,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Text(
                userEmail!,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              //Divider(color: Colors.white, height: 20,),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              creationOfACommonRoom(
                  deviceName: deviceName
              );
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  const Color(0xff6495ed),
                  const Color(0xff1e90ff),
                  const Color(0xff00bfff),
                ]),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              child: Text(
                'Connect',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              margin: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
  @override
  void initState() {
    initiateSearch();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(right: 50),
          child: Center(
            child: Text(
              'Adding a chat',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        // leading: IconButton(
        //     icon: Icon(
        //       Icons.arrow_back,
        //       color: Colors.white,
        //       size: 25,
        //     ),
        //     onPressed: () {
        //       Navigator.of(context).push(
        //         MaterialPageRoute(builder: (context) => ChatRoomsScreen()),
        //       );
        //     }),
      ),
      body: Container(
        //TODO
        child: Column(
          children: [
            Container(
              color: Colors.black54,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchTextEditingController,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                      decoration: InputDecoration(
                        hintText: 'Search username...',
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      initiateSearch();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          const Color(0xff6495ed),
                          const Color(0xff1e90ff),
                          const Color(0xff00bfff),
                        ]),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Icon(Icons.search, color: Colors.white),
                      // Image.asset(
                      //   "assets/image/search_icon.png",
                      //   color: Colors.white,
                      // ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            searchList(),
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

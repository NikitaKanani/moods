import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import 'chat.dart';

var mapResponse;
var listResponse;

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  Widget chips(String a, Color c) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
            onTap: () {},
            child: Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Text(a,
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                        color: Colors.white)),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: c,
              ),
            )));
  }

  Future apicall() async {
    http.Response response;
    response = await http
        .get(Uri.parse("https://631912b58e51a64d2bde2f2b.mockapi.io/MyTeam"));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse;
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Good morning!",
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins'),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Chat(),
                            ));
                      },
                      child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.chat_bubble,
                              size: 3.h,
                              color: Color.fromRGBO(209, 208, 213, 1),
                            ),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color.fromRGBO(242, 242, 242, 1),
                            borderRadius: BorderRadius.circular(10),
                          )),
                    )
                  ],
                ),
              ),
              flex: 2,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 20,
                          color: Color.fromARGB(255, 247, 247, 247),
                          offset: Offset(0.0, 10.0)),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.black26),
                          border: InputBorder.none,
                          hintText: "Search",
                          hintStyle: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black26,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins')),
                    ),
                  ),
                ),
              ),
              flex: -1,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      chips("Health", Color.fromRGBO(254, 118, 150, 1)),
                      chips("Relax", Color.fromRGBO(164, 181, 255, 1)),
                      chips("Psycology", Color.fromRGBO(119, 200, 165, 1)),
                      chips("Mentally ", Color.fromRGBO(255, 185, 116, 1)),
                    ],
                  ),
                ),
              ),
              flex: 2,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 13),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 5.h,
                                      width: 10.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                listResponse[index]
                                                    ['PersonImage']),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            listResponse[index]['Name']
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins'),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                listResponse[index]['Time']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black45),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Min ago",
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black45),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                    onTap: () {},
                                    child: Container(
                                        height: 6.h,
                                        width: 10.w,
                                        child: Icon(Icons.more_vert)))
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: Text(
                                    listResponse[index]['Info'].toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                        color: Colors.black54),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              height: 20.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        listResponse[index]['Image']),
                                    fit: BoxFit.fill),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                // ignore: unnecessary_null_comparison
                itemCount: listResponse == null ? 0 : listResponse.length,
              ),
              flex: 9,
            )
          ]),
        ));
  }
}

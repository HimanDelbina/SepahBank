// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sepah/Models/marker_model.dart';
import 'package:sepah/Page/Map/google_map_Marker.dart';
import 'package:sepah/Static/user.dart';

import 'Marketing/market.dart';
// import 'package:sepah/Models/shahrestan_model.dart';
// import 'package:sepah/Models/shobe_model.dart';

// import 'package:http/http.dart' as http;

// class Home extends StatefulWidget {
//   final String? user;
//   final String? userFamily;
//   final bool? admin;
//   final int? shobeCode;
//   Home({this.user, this.userFamily, this.shobeCode, this.admin});
//   @override
//   _HomeMapState createState() => _HomeMapState();
// }

// class _HomeMapState extends State<Home> {
//   var codeGetShobe;
//   List<Shobe>? shobe;
//   List<Shobe>? listShobe;
//   List<Shobe>? shahrestan;
//   List<ShahrestanModel>? listShahrestan;
//   var shobeImage;
//   var bazariabiJadidImage;
//   var moshtariGhabliImage;
//   String? shobeName;
//   int? shobeCode;
//   int? shobeID;
//   String? shahrestanName;
//   String? code;

//   Future<List<Shobe>> getShobe() async {
//     String url = "http://smartrebin.ir:2404/bank/shobe?id=" +
//         widget.shobeCode.toString();
//     try {
//       final response = await http.get(Uri.parse(url), headers: {
//         'Accept': 'application/json',
//         "Content-Type": "application/json",
//       });
//       if (response.statusCode == 200) {
//         var res = response.body;
//         listShobe = shobeFromJson(res);
//         shobe = listShobe;
//         for (var i = 0; i < shobe!.length; i++) {
//           setState(() {
//             shobeName = utf8.decode(shobe![i].name!.codeUnits);
//             shobeCode = shobe![i].code;
//             shobeID = shobe![i].id;
//           });
//         }
//         for (var i = 0; i < shobe!.length; i++) {
//           setState(() {
//             shahrestanName = utf8.decode(shobe![i].shahrestan!.name!.codeUnits);
//           });
//           print(shahrestanName);
//         }
//         return shobe!;
//       } else {
//         return shobe!;
//       }
//     } catch (e) {
//       return shobe!;
//     }
//   }

//   void getShobeSync() async {
//     await getShobe();
//   }

//   @override
//   void initState() {
//     code = widget.shobeCode.toString();
//     getShobeSync();
//     super.initState();
//     codeGetShobe = widget.shobeCode;
//   }

//   void _showDialogNavigator() {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             shape:
//                 OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
//             title: const Text(
//               "لطفا چند لحظه صبر کنید",
//               style: TextStyle(fontSize: 14.0),
//             ),
//             actions: <Widget>[
//               RaisedButton(
//                 color: Colors.orange,
//                 child: const Center(
//                     child: Text(
//                   "تایید",
//                   style: TextStyle(color: Colors.white),
//                 )),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               )
//             ],
//           );
//         });
//   }

//   void _adminDialog() {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             shape:
//                 OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
//             title: const Text(
//               "شما به این قسمت دسترسی ندارید",
//               style: TextStyle(fontSize: 14.0),
//             ),
//             actions: <Widget>[
//               RaisedButton(
//                 color: Colors.orange,
//                 child: const Center(
//                     child: Text(
//                   "تایید",
//                   style: TextStyle(color: Colors.white),
//                 )),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               )
//             ],
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double myHeight = MediaQuery.of(context).size.height;
//     double myWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: Container(
//           height: myHeight,
//           width: myWidth,
//           child: Column(
//             children: [
//               Container(
//                 height: myHeight * 0.1,
//                 width: myWidth,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     height: myHeight * 0.09,
//                     width: myWidth,
//                     decoration: BoxDecoration(
//                       color: Colors.orange,
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         "بانک سپه",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 22.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 height: myHeight * 0.25,
//                 width: myWidth,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                       height: myHeight * 0.09,
//                       width: myWidth,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[100],
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                               vertical: 10.0,
//                               horizontal: 15.0,
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 shobe!.length != 0
//                                     ? Text(
//                                         widget.user!,
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.bold),
//                                       )
//                                     : const Text(""),
//                                 const SizedBox(
//                                   width: 10.0,
//                                 ),
//                                 shobe!.length != 0
//                                     ? Text(
//                                         widget.userFamily!,
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.bold),
//                                       )
//                                     : const Text(""),
//                               ],
//                             ),
//                           ),
//                           const Divider(
//                             indent: 15.0,
//                             endIndent: 15.0,
//                             color: Colors.orange,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                               vertical: 10.0,
//                               horizontal: 15.0,
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Text(
//                                       "شعبه :",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     const SizedBox(
//                                       width: 10.0,
//                                     ),
//                                     shobe!.length != 0
//                                         ? Text(
//                                             shobeName!,
//                                             style: const TextStyle(
//                                                 fontWeight: FontWeight.bold),
//                                           )
//                                         : const Text("")
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Text(
//                                       "کد :",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     const SizedBox(
//                                       width: 10.0,
//                                     ),
//                                     shobe!.length != 0
//                                         ? Text(
//                                             shobeCode.toString(),
//                                             style: const TextStyle(
//                                                 fontWeight: FontWeight.bold),
//                                           )
//                                         : const Text("")
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const Divider(
//                             indent: 15.0,
//                             endIndent: 15.0,
//                             color: Colors.orange,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                               vertical: 10.0,
//                               horizontal: 15.0,
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   "شهرستان :",
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 const SizedBox(
//                                   width: 10.0,
//                                 ),
//                                 shobe!.length != 0
//                                     ? Text(
//                                         shahrestanName!,
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.bold),
//                                       )
//                                     : const Text("")
//                               ],
//                             ),
//                           ),
//                         ],
//                       )),
//                 ),
//               ),
//               const Divider(
//                 indent: 10.0,
//                 endIndent: 10.0,
//                 color: Colors.orange,
//               ),
//               Expanded(
//                 child: Container(
//                   width: myWidth,
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 if (widget.admin == false) {
//                                   // Navigator.push(
//                                   //     context,
//                                   //     MaterialPageRoute(
//                                   //         builder: (context) => BazariabiFirst(
//                                   //               user: widget.user!,
//                                   //               shobeCode: widget.shobeCode!,
//                                   //               shahrestan: shahrestanName!,
//                                   //             )));
//                                 } else {
//                                   _adminDialog();
//                                 }
//                               },
//                               child: Container(
//                                 height: myHeight * 0.2,
//                                 width: myWidth * 0.45,
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.withOpacity(0.2),
//                                   borderRadius: BorderRadius.circular(10.0),
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Image.asset(
//                                       "assets/delivery.png",
//                                       height: 50.0,
//                                     ),
//                                     const Text(
//                                       "بازاریابی های من",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 18.0,
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 if (widget.admin != false) {
//                                   // Navigator.push(
//                                   //     context,
//                                   //     MaterialPageRoute(
//                                   //         builder: (context) => MapTest(
//                                   //               adminUser: widget.admin!,
//                                   //               shahrestanUser: shahrestanName!,
//                                   //             )));
//                                 } else {
//                                   _adminDialog();
//                                 }
//                               },
//                               child: Container(
//                                 height: myHeight * 0.2,
//                                 width: myWidth * 0.45,
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.withOpacity(0.2),
//                                   borderRadius: BorderRadius.circular(10.0),
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Image.asset(
//                                       "assets/map.png",
//                                       height: 50.0,
//                                     ),
//                                     const Text(
//                                       "مشاهده نقشه",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 18.0,
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 20.0),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 if (widget.admin == false) {
//                                   // Navigator.push(context, MaterialPageRoute(
//                                   //   builder: (context) {
//                                   //     return TaghirVaziat();
//                                   //   },
//                                   // ));
//                                 } else {
//                                   _adminDialog();
//                                 }
//                               },
//                               child: Container(
//                                 height: myHeight * 0.2,
//                                 width: myWidth * 0.45,
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.withOpacity(0.2),
//                                   borderRadius: BorderRadius.circular(10.0),
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Image.asset(
//                                       "assets/shuffle.png",
//                                       height: 50.0,
//                                     ),
//                                     const Text(
//                                       "تغییر وضعیت",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 18.0,
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: myHeight,
          width: myWidth,
          child: Column(
            children: [
              Container(
                height: myHeight * 0.2,
                width: myWidth,
                child: Row(
                  children: [
                    Container(
                      height: myHeight,
                      width: myWidth * 0.3,
                      // color: Colors.amber,
                      child: Center(
                        child: Image.asset(
                          "assets/logo1.png",
                          height: 150.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            UserStaticFile.first_name.toString() +
                                " " +
                                UserStaticFile.last_name.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("نام کاربری : " +
                              UserStaticFile.nameKarbari.toString()),
                          Text("شماره موبایل : " +
                              UserStaticFile.phone_number.toString()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("شهرستان : " +
                                  UserStaticFile.shahrestan.toString()),
                              Flexible(
                                  child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "شعبه : " + UserStaticFile.shobe.toString(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(indent: 15, endIndent: 15),
              const SizedBox(height: 20.0),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MarketPage()));
                      },
                      child: Container(
                        height: myHeight * 0.1,
                        width: myWidth,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey.withOpacity(0.1)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "بازاریابی های من",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                              Image.asset(
                                "assets/shuffle.png",
                                height: 30.0,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GoogleMapMarker(),
                            ));
                      },
                      child: Container(
                        height: myHeight * 0.1,
                        width: myWidth,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey.withOpacity(0.1)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "مشاهده نقشه",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                              Image.asset(
                                "assets/map.png",
                                height: 30.0,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sepah/Models/my_market.dart';
import 'package:http/http.dart' as http;
import 'package:sepah/Page/Marketing/edit_marketing.dart';
import 'package:sepah/Static/url.dart';
import 'package:sepah/Static/user.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyMarketing extends StatefulWidget {
  const MyMarketing({Key? key}) : super(key: key);

  @override
  _MyMarketingState createState() => _MyMarketingState();
}

class _MyMarketingState extends State<MyMarketing> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    searchController.addListener(onSearchChanged);
    getMyMarker();
  }

  onSearchChanged() {
    print(searchController.text);
  }

  @override
  void dispose() {
    searchController.removeListener(onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  List<MyMarketModel> search(List<MyMarketModel>? employee) {
    if (searchString.isNotEmpty == true) {
      return employee
              ?.where((element) => element.name!.contains(searchString))
              .toList() ??
          <MyMarketModel>[];
    }

    return employee ?? <MyMarketModel>[];
  }

  int? selectMarker;
  String searchString = "";

  bool filter1 = false;
  bool filter2 = false;
  bool filter3 = false;
  bool filter4 = false;

  var result;

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Container(
            height: myHeight * 0.07,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchString = value;
                });
              },
              controller: searchController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                labelText: 'جستجو',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: getMyMarker(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              result = search(snapshot.data);
              if (!snapshot.hasData) {
                return Center(
                  child: Lottie.asset("assets/animation/loading.json",
                      height: 40.0),
                );
              } else {
                return ListView.builder(
                  itemCount: result.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: result[index].selectMode! == "4"
                                ? Colors.redAccent.withOpacity(0.1)
                                : result[index].selectMode! == "3"
                                    ? Colors.blue.withOpacity(0.1)
                                    : result[index].selectMode! == "2"
                                        ? Colors.green.withOpacity(0.1)
                                        : result[index].selectMode! == "1"
                                            ? Colors.amber.withOpacity(0.1)
                                            : Colors.grey.withOpacity(0.1)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(result[index].name!),
                                  Row(
                                    children: [
                                      Text(
                                        result[index].selectMode! == "4"
                                            ? "تغییر وضعیت"
                                            : result[index].selectMode! == "3"
                                                ? "شعبه"
                                                : result[index].selectMode! ==
                                                        "2"
                                                    ? "مشتری قدیمی"
                                                    : result[index]
                                                                .selectMode! ==
                                                            "1"
                                                        ? "بازاریابی جدید"
                                                        : "",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 15.0),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditMarketing(
                                                        data: result[index]),
                                              ));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    blurRadius: 1.0,
                                                    blurStyle: BlurStyle.outer)
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          child: const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(3.0),
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.amber,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15.0),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectMarker = result[index].id!;
                                          });
                                          Delete();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    blurRadius: 1.0,
                                                    blurStyle: BlurStyle.outer)
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          child: const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(3.0),
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(result[index].selectMode! == "3"
                                      ? result[index].shobeBoss
                                      : result[index].zirsenf!.name.toString()),
                                  Text(
                                    result[index]
                                        .listDate!
                                        .toString()
                                        .toPersianDate(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }

  List? myMarkerData = [];
  var myMarkerList;
  Future<List<MyMarketModel>?> getMyMarker() async {
    String infourl = UrlStaticFile.url +
        'marker/get_marker_user/' +
        UserStaticFile.user_id.toString() +
        "/";
    var response = await http
        .get(Uri.parse(infourl), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var x = response.body;
      myMarkerList = myMarketModelFromJson(x);
      return myMarkerList;
    }
  }

  Delete() async {
    String url = UrlStaticFile.url +
        'marker/delete_marker/' +
        selectMarker.toString() +
        "/";
    final responce = await http
        .post(Uri.parse(url), headers: {"Content-Type": "application/json"});
    if (responce.statusCode == 200) {
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
        duration: const Duration(seconds: 2),
        content: const Text(
          "حذف با موفقیت انجام شد",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: "Vazir",
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
        duration: const Duration(seconds: 2),
        content: const Text(
          "حذف انجام نشد لطفا دوباره تلاش کنید",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: "Vazir",
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persian_number_utility/src/extensions.dart';
import 'package:sepah/Models/my_market.dart';
import 'package:http/http.dart' as http;
import 'package:sepah/Static/url.dart';

class AllMarket extends StatefulWidget {
  const AllMarket({Key? key}) : super(key: key);

  @override
  _AllMarketState createState() => _AllMarketState();
}

class _AllMarketState extends State<AllMarket> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMyMarker(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Lottie.asset("assets/animation/loading.json", height: 40.0),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: snapshot.data[index].selectMode! == "4"
                          ? Colors.redAccent.withOpacity(0.1)
                          : snapshot.data[index].selectMode! == "3"
                              ? Colors.blue.withOpacity(0.1)
                              : snapshot.data[index].selectMode! == "2"
                                  ? Colors.green.withOpacity(0.1)
                                  : snapshot.data[index].selectMode! == "1"
                                      ? Colors.amber.withOpacity(0.1)
                                      : Colors.grey.withOpacity(0.1)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(snapshot.data[index].selectMode! == "4"
                                ? "تغییر وضعیت"
                                : snapshot.data[index].selectMode! == "3"
                                    ? "شعبه"
                                    : snapshot.data[index].selectMode! == "2"
                                        ? "مشتری قدیمی"
                                        : snapshot.data[index].selectMode! ==
                                                "1"
                                            ? "بازاریابی جدید"
                                            : "",style:const TextStyle(fontWeight: FontWeight.bold),),
                            const SizedBox(width: 15.0),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(snapshot.data[index].name!),
                            Text(snapshot.data[index].selectMode! == "3"
                                ? snapshot.data[index].shobeBoss
                                : snapshot.data[index].zirsenf!.name
                                    .toString()),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(snapshot.data[index].shahrestan!.name),
                            Text(
                              snapshot.data[index].listDate!
                                  .toString()
                                  .toPersianDate(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12.0),
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
    );
  }

  List? myMarkerData = [];
  var myMarkerList;
  Future<List<MyMarketModel>?> getMyMarker() async {
    String infourl = UrlStaticFile.url + 'marker/get_all_marker';
    var response = await http
        .get(Uri.parse(infourl), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var x = response.body;
      myMarkerList = myMarketModelFromJson(x);
      setState(() {
        myMarkerData = myMarkerList;
      });
      return myMarkerList;
    }
  }
}

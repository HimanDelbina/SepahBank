import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sepah/Models/noe_hesab_model.dart';
import 'package:sepah/Models/senf_model.dart';
import 'package:sepah/Models/zirsenf_model.dart';
import 'package:sepah/Static/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditMarketing extends StatefulWidget {
  var data;
  EditMarketing({Key? key, this.data}) : super(key: key);

  @override
  _EditMarketingState createState() => _EditMarketingState();
}

class _EditMarketingState extends State<EditMarketing> {
  final formkey = GlobalKey<FormState>();

  TextEditingController textEditingControllerSenf = TextEditingController();
  TextEditingController textEditingControllerZirSenf = TextEditingController();
  TextEditingController textEditingControllerNoeHesab = TextEditingController();

  TextEditingController controllerName = TextEditingController();
  String? name;

  TextEditingController controllerPhone = TextEditingController();
  String? phone;
  TextEditingController controllerHesab = TextEditingController();
  String? hesab;
  TextEditingController controllerNoeHesab = TextEditingController();
  String? noeHesab;

  TextEditingController controllerDescription = TextEditingController();
  String? description;

  TextEditingController controllerposNumber = TextEditingController();
  String? posNumber;

  String? senfSelectnameFinal = '';
  int? senfSelectIDFinal = 0;
  List<String>? itemsSenfString = [];
  List itemsSenfSelected = [];

  List itemsNoeHesabSelected = [];
  List<String>? itemsNoeHesabString = [];
  String? noeHesabSelectnameFinal = '';
  int? noeHesabSelectIDFinal = 0;

  bool isPos = false;
  String? posCount;

  List<SenfModel>? senf;
  List<SenfModel>? listSenf;
  List<ZirSenf>? zirSenf;
  List<ZirSenf>? listZirSenf;
  List<SenfModel>? filteredSenf = [];

  Key? filterKey;
  int? filterInt = 0;
  String? filterString = '';
  int? selectedIndex = 0;
  String? selectMode = "1";

  bool validAndSaveUser() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void ValidAndSubmitUser() {
    if (validAndSaveUser()) {
      formkey.currentState!.reset();
      EditMarker();
    }
  }

  @override
  void initState() {
    super.initState();
    getSenf();
    getNoeHesab();
    textEditingControllerSenf.text = widget.data.senf.name.toString();
    textEditingControllerZirSenf.text = widget.data.zirsenf.name.toString();
    controllerName.text = widget.data.name;
    controllerPhone.text = widget.data.mobile;
    controllerHesab.text = widget.data.shomarehesab;
    textEditingControllerNoeHesab.text = widget.data.noeHesab.name.toString();
    if (widget.data.isPos == true) {
      isPos = true;
    } else {
      isPos = false;
    }
    controllerposNumber.text = widget.data.posNumber.toString();
    controllerDescription.text = widget.data.description.toString();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Form(
      key: formkey,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: myHeight,
            width: myWidth,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Container(
                          height: myHeight * 0.07,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: TypeAheadField<String>(
                              keepSuggestionsOnSuggestionSelected: false,
                              getImmediateSuggestions: true,
                              textFieldConfiguration: TextFieldConfiguration(
                                // autofocus: true,
                                controller: textEditingControllerSenf,
                                decoration: const InputDecoration.collapsed(
                                  hintText:
                                      'لطفا صنف مورد نظر خود را انتخاب کنید',
                                ),
                              ),
                              suggestionsCallback: (String pattern) async {
                                return itemsSenfString!
                                    .where((x) => x.contains(pattern))
                                    .toList();
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },
                              onSuggestionSelected: (String suggestion) {
                                textEditingControllerSenf.text = suggestion;
                                Text(suggestion);
                                for (var i = 0; i < senf!.length; i++) {
                                  if (utf8.decode(senf![i].name!.codeUnits) ==
                                      suggestion) {
                                    itemsSenfSelected.add(senf![i]);
                                    senfSelectnameFinal =
                                        utf8.decode(senf![i].name!.codeUnits);
                                    senfSelectIDFinal = senf![i].id;
                                    setState(() {
                                      getZirSenf(senfSelectIDFinal);
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Container(
                          height: myHeight * 0.07,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: TypeAheadField<String>(
                              keepSuggestionsOnSuggestionSelected: false,
                              getImmediateSuggestions: true,
                              textFieldConfiguration: TextFieldConfiguration(
                                // autofocus: true,
                                controller: textEditingControllerZirSenf,
                                decoration: const InputDecoration.collapsed(
                                  hintText:
                                      'لطفا رسته مورد نظر خود را انتخاب کنید',
                                ),
                              ),
                              suggestionsCallback: (String pattern) async {
                                return itemsZirSenfString!
                                    .where((x) => x.contains(pattern))
                                    .toList();
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },
                              onSuggestionSelected: (String suggestion) {
                                textEditingControllerZirSenf.text = suggestion;
                                Text(suggestion);
                                print("Suggestion selected");
                                for (var i = 0; i < zirSenf!.length; i++) {
                                  if (utf8.decode(
                                          zirSenf![i].name!.codeUnits) ==
                                      suggestion) {
                                    itemsZirSenfSelected.add(zirSenf![i]);
                                    zirSenfSelectnameFinal = utf8
                                        .decode(zirSenf![i].name!.codeUnits);
                                    zirSenfSelectIDFinal = zirSenf![i].id;
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextFormField(
                              controller: controllerName,
                              validator: (value) => value!.isEmpty
                                  ? "لطفا نام مکان مورد نظر وارد کنید"
                                  : null,
                              onSaved: (value) => name = value,
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.start,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(Icons.assignment_ind),
                                  hintText: "نام فروشگاه",
                                  hintStyle: TextStyle(fontSize: 14.0)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextFormField(
                              controller: controllerPhone,
                              validator: (value) => value!.isEmpty
                                  ? "لطفا شماره موبایل را وارد کنید"
                                  : null,
                              onSaved: (value) => phone = value,
                              keyboardType: TextInputType.phone,
                              textAlign: TextAlign.start,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(Icons.phone),
                                  hintText: "شماره موبایل",
                                  hintStyle: TextStyle(fontSize: 14.0)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextFormField(
                              controller: controllerHesab,
                              validator: (value) => value!.isEmpty
                                  ? "لطفا شماره حساب را وارد کنید"
                                  : null,
                              onSaved: (value) => hesab = value,
                              keyboardType: TextInputType.phone,
                              textAlign: TextAlign.start,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(Icons.phone),
                                  hintText: "شماره حساب",
                                  hintStyle: TextStyle(fontSize: 14.0)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Container(
                          height: myHeight * 0.07,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: TypeAheadField<String>(
                              keepSuggestionsOnSuggestionSelected: false,
                              getImmediateSuggestions: true,
                              textFieldConfiguration: TextFieldConfiguration(
                                // autofocus: true,
                                controller: textEditingControllerNoeHesab,
                                decoration: const InputDecoration.collapsed(
                                  hintText:
                                      'لطفا نوع حساب مورد نظر خود را انتخاب کنید',
                                ),
                              ),
                              suggestionsCallback: (String pattern) async {
                                return itemsNoeHesabString!
                                    .where((x) => x.contains(pattern))
                                    .toList();
                              },
                              itemBuilder: (context, String suggestion) {
                                return ListTile(
                                  title: Text(suggestion),
                                );
                              },
                              onSuggestionSelected: (String suggestion) {
                                textEditingControllerNoeHesab.text = suggestion;
                                Text(suggestion);
                                for (var i = 0; i < senf!.length; i++) {
                                  if (utf8.decode(senf![i].name!.codeUnits) ==
                                      suggestion) {
                                    itemsNoeHesabSelected.add(senf![i]);
                                    noeHesabSelectnameFinal =
                                        utf8.decode(senf![i].name!.codeUnits);
                                    noeHesabSelectIDFinal = senf![i].id;
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        child: Row(
                          children: [
                            const Text("آیا دستگاه پوز (POS) دارد ؟"),
                            const SizedBox(width: 20),
                            Switch(
                              value: isPos,
                              onChanged: (value) {
                                setState(() {
                                  isPos = value;
                                });
                              },
                              activeTrackColor: Colors.deepOrange,
                              activeColor: Colors.orange,
                            ),
                            isPos == true
                                ? Expanded(
                                    child: TextFormField(
                                      controller: controllerposNumber,
                                      onSaved: (value) => posNumber = value,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.start,
                                      decoration: const InputDecoration(
                                          suffixIcon:
                                              Icon(Icons.format_list_numbered),
                                          border: OutlineInputBorder(),
                                          hintText: "تعداد",
                                          hintStyle: TextStyle(fontSize: 14.0)),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Container(
                          height: myHeight * 0.2,
                          width: myWidth,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextFormField(
                              controller: controllerDescription,
                              validator: (value) => value!.isEmpty
                                  ? "لطفا توضیحات را وارد کنید"
                                  : null,
                              onSaved: (value) => description = value,
                              minLines: 1,
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              textAlign: TextAlign.start,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(Icons.description),
                                  hintText: "توضیحات",
                                  hintStyle: TextStyle(fontSize: 14.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: myHeight * 0.1,
                  width: myWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: GestureDetector(
                      onTap: ValidAndSubmitUser,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: const Center(
                          child: Text(
                            "تغییر وضعیت",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String url = UrlStaticFile.url + "bank/get_senf";

  Future<List<SenfModel>> getSenf() async {
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
      });
      if (response.statusCode == 200) {
        var res = response.body;
        listSenf = senfModelFromJson(res);
        senf = listSenf;
        for (var i = 0; i < senf!.length; i++) {
          setState(() {
            itemsSenfString!.add(utf8.decode(senf![i].name!.codeUnits));
          });
        }
        return senf!;
      } else {
        return senf!;
      }
    } catch (e) {
      return senf!;
    }
  }

  String? zirSenfSelectnameFinal = '';
  int? zirSenfSelectIDFinal = 0;
  List<String>? itemsZirSenfString = [];
  List itemsZirSenfSelected = [];

  Future<List<ZirSenf>> getZirSenf(int? senfID) async {
    String urlZieSenf =
        UrlStaticFile.url + "bank/get_zirsenf/" + senfID.toString() + "/";
    // senfSelectIDFinal.toString();
    try {
      final response = await http.get(Uri.parse(urlZieSenf), headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
      });
      if (response.statusCode == 200) {
        var res = response.body;
        listZirSenf = zirSenfFromJson(res);
        zirSenf = listZirSenf;
        itemsZirSenfString = [];
        for (var i = 0; i < zirSenf!.length; i++) {
          setState(() {
            itemsZirSenfString!.add(utf8.decode(zirSenf![i].name!.codeUnits));
          });
        }
        return zirSenf!;
      } else {
        return zirSenf!;
      }
    } catch (e) {
      return zirSenf!;
    }
  }

  List<NoeHesabModel>? noeHesabGet;
  List<NoeHesabModel>? listNoeHesabGet;
  List<String> itemNoeHesbaSelected = [];

  Future<List<NoeHesabModel>> getNoeHesab() async {
    String url = UrlStaticFile.url + "marker/get_noe_hesab";
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
      });
      if (response.statusCode == 200) {
        var res = response.body;
        listNoeHesabGet = noeHesabModelFromJson(res);
        noeHesabGet = listNoeHesabGet;
        for (int i = 0; i < noeHesabGet!.length; i++) {
          setState(() {
            itemNoeHesbaSelected.add(noeHesabGet![i].name!);
          });
        }
        return noeHesabGet!;
      } else {
        return noeHesabGet!;
      }
    } catch (e) {
      return noeHesabGet!;
    }
  }

  EditMarker() async {
    String url = UrlStaticFile.url +
        'marker/edit_marker/' +
        widget.data.id.toString() +
        "/";
    var data = json.encode({
      "id": widget.data.id,
      "selectMode": "4",
      "name": name,
      "mobile": phone,
      "description": description,
      "image": "",
      "long": widget.data.long,
      "lut": widget.data.lut,
      "shobeCode": widget.data.shobeCode,
      "shomarehesab": controllerHesab.text,
      "is_pos": isPos,
      "pos_number": int.parse(controllerposNumber.text),
      "noe_hesab": widget.data.noeHesab.id,
      "senf": widget.data.senf.id,
      "zirsenf": widget.data.zirsenf.id,
      // "shahrestan": widget.data.shahrestan.id,
    });
    print(data);
    final responce = await http.post(Uri.parse(url),
        body: data, headers: {"Content-Type": "application/json"});
    if (responce.statusCode == 200) {
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
        duration: const Duration(seconds: 2),
        content: const Text(
          "تغییر وضعیت با موفقیت انجام شد",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: "Vazir",
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) => Home(),
      // ));
    } else {
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
        duration: const Duration(seconds: 2),
        content: const Text(
          "تغییر وضعیت انجام نشد",
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

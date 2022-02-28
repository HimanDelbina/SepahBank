import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sepah/Models/noe_hesab_model.dart';
import 'package:sepah/Models/senf_model.dart';
import 'package:sepah/Models/zirsenf_model.dart';
import 'package:http/http.dart' as http;
import 'package:sepah/Page/Marketing/market.dart';
import 'package:sepah/Static/url.dart';
import 'package:sepah/Static/user.dart';

class AddMarket extends StatefulWidget {
  double? lat;
  double? long;
  AddMarket({Key? key, this.lat, this.long}) : super(key: key);

  @override
  _AddMarketState createState() => _AddMarketState();
}

class _AddMarketState extends State<AddMarket>
    with SingleTickerProviderStateMixin {
  TabController? controllerTab;
  final formkey = GlobalKey<FormState>();

  TextEditingController textEditingControllerSenf = TextEditingController();
  TextEditingController textEditingControllerZirSenf = TextEditingController();
  TextEditingController textEditingControllerNoeHesab = TextEditingController();

  TextEditingController controllerName = TextEditingController();
  String? name;
  TextEditingController controllerShobeName = TextEditingController();
  String? shobeName;
  TextEditingController controllerShobeShakhes = TextEditingController();
  String? shobeShakhes;
  TextEditingController controllerShobeBoss = TextEditingController();
  String? shobeBoss;

  TextEditingController controllerPhone = TextEditingController();
  String? phone;
  TextEditingController controllerHesab = TextEditingController();
  String? hesab;

  TextEditingController controllerDescription = TextEditingController();
  String? description;

  TextEditingController controllerposNumber = TextEditingController();
  String? posNumber;

  String? senfSelectnameFinal = '';
  int? senfSelectIDFinal = 0;
  List<String>? itemsSenfString = [];
  List itemsSenfSelected = [];

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
  @override
  void initState() {
    super.initState();
    getSenf();
    getNoeHesab();
    controllerTab = TabController(length: 3, vsync: this);

    controllerTab!.addListener(() {
      setState(() {
        selectedIndex = controllerTab!.index;
      });
      if (selectedIndex! == 0) {
        selectMode = "1";
        controllerDescription.clear();
        controllerPhone.clear();
        controllerName.clear();
      } else if (selectedIndex! == 1) {
        selectMode = "2";
        controllerDescription.clear();
        controllerPhone.clear();
        controllerName.clear();
      } else if (selectedIndex! == 2) {
        selectMode = "3";
        senfSelectnameFinal = "شعبه";
        zirSenfSelectnameFinal = "شعبه";
        controllerDescription.clear();
        controllerPhone.clear();
        controllerName.clear();
      }
    });
  }

  @override
  void dispose() {
    controllerTab!.dispose();
    super.dispose();
  }

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
      postMarker();
    }
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Form(
      key: formkey,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 10.0,
            bottom: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.orange,
              controller: controllerTab,
              tabs: const [
                Tab(text: "بازاریابی جدید"),
                Tab(text: "مشتری قدیمی"),
                Tab(text: "مکان شعبه"),
              ],
            ),
          ),
          body: TabBarView(controller: controllerTab, children: [
            //////////////////////////////////////////////////////////////////////////////////////////////////// بازاریابی جدید
            Container(
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
                                  textEditingControllerZirSenf.text =
                                      suggestion;
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
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
                                  textEditingControllerNoeHesab.text =
                                      suggestion;
                                  Text(suggestion);
                                  print("Suggestion selected");
                                  for (var i = 0; i < noeHesab!.length; i++) {
                                    if (noeHesab![i].name! == suggestion) {
                                      itemNoeHesbaSelected.add(noeHesab![i]);
                                      noeHesabSelectnameFinal =
                                          noeHesab![i].name!;
                                      noeHesabSelectIDFinal = noeHesab![i].id;
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
                                            suffixIcon: Icon(
                                                Icons.format_list_numbered),
                                            border: OutlineInputBorder(),
                                            hintText: "تعداد",
                                            hintStyle:
                                                TextStyle(fontSize: 14.0)),
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
                              "ثبت شناسه",
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
            ////////////////////////////////////////////////////////////////////////////////////////////////////مشتری قدیمی
            Container(
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
                                  textEditingControllerZirSenf.text =
                                      suggestion;
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
                        /////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
                                  textEditingControllerNoeHesab.text =
                                      suggestion;
                                  Text(suggestion);
                                  print("Suggestion selected");
                                  for (var i = 0; i < noeHesab!.length; i++) {
                                    if (noeHesab![i].name! == suggestion) {
                                      itemNoeHesbaSelected.add(noeHesab![i]);
                                      noeHesabSelectnameFinal =
                                          noeHesab![i].name!;
                                      noeHesabSelectIDFinal = noeHesab![i].id;
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
                                            suffixIcon: Icon(
                                                Icons.format_list_numbered),
                                            border: OutlineInputBorder(),
                                            hintText: "تعداد",
                                            hintStyle:
                                                TextStyle(fontSize: 14.0)),
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
                              "ثبت شناسه",
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
            //////////////////////////////////////////////////////////////////////////////////////////////////// مکان شعبه
            Container(
              height: myHeight,
              width: myWidth,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: myWidth,
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: TextFormField(
                                  controller: controllerName,
                                  validator: (value) => value!.isEmpty
                                      ? "لطفا نام شعبه مورد نظر وارد کنید"
                                      : null,
                                  onSaved: (value) => name = value,
                                  keyboardType: TextInputType.emailAddress,
                                  textAlign: TextAlign.start,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.assignment_ind),
                                      hintText: "نام شعبه",
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: TextFormField(
                                  controller: controllerShobeBoss,
                                  validator: (value) => value!.isEmpty
                                      ? "لطفا نام رییس شعبه را وارد کنید"
                                      : null,
                                  onSaved: (value) => shobeBoss = value,
                                  keyboardType: TextInputType.name,
                                  textAlign: TextAlign.start,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.person),
                                      hintText: "رییس شعبه",
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: TextFormField(
                                  controller: controllerShobeShakhes,
                                  validator: (value) => value!.isEmpty
                                      ? "لطفا نام شاخص شعبه را وارد کنید"
                                      : null,
                                  onSaved: (value) => shobeShakhes = value,
                                  keyboardType: TextInputType.phone,
                                  textAlign: TextAlign.start,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.format_list_numbered),
                                      hintText: "شاخص شعبه",
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: TextFormField(
                                  controller: controllerPhone,
                                  validator: (value) => value!.isEmpty
                                      ? "لطفا شماره تلفن را وارد کنید"
                                      : null,
                                  onSaved: (value) => phone = value,
                                  keyboardType: TextInputType.phone,
                                  textAlign: TextAlign.start,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.phone),
                                      hintText: "شماره تلفن",
                                      hintStyle: TextStyle(fontSize: 14.0)),
                                ),
                              ),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
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
                              "ثبت شناسه",
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
          ]),
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

  List<NoeHesabModel>? noeHesab;
  List<NoeHesabModel>? listNoeHesab;
  List<String>? itemsNoeHesabString = [];
  List itemNoeHesbaSelected = [];
  String? noeHesabSelectnameFinal = '';
  int? noeHesabSelectIDFinal = 0;

  Future<List<NoeHesabModel>> getNoeHesab() async {
    String url = UrlStaticFile.url + "marker/get_noe_hesab";
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
      });
      if (response.statusCode == 200) {
        var res = response.body;
        listNoeHesab = noeHesabModelFromJson(res);
        noeHesab = listNoeHesab;
        for (var i = 0; i < noeHesab!.length; i++) {
          setState(() {
            itemsNoeHesabString!.add(noeHesab![i].name!);
          });
        }
        return noeHesab!;
      } else {
        return noeHesab!;
      }
    } catch (e) {
      return noeHesab!;
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

  bool isPos = false;
  String? posCount;

  Future postMarker() async {
    var body = jsonEncode({
      "user": UserStaticFile.user_id,
      "selectMode": selectMode,
      "shobe_shkhes":
          shobeShakhes == null ? 0 : int.parse(shobeShakhes.toString()),
      "shobe_boss": shobeBoss == null ? '' : shobeBoss,
      "name": name,
      "mobile": phone,
      "senf": senfSelectIDFinal == 0 ? null : senfSelectIDFinal,
      "zirsenf": zirSenfSelectIDFinal == 0 ? null : zirSenfSelectIDFinal,
      "description": description,
      "image": "",
      "shahrestan": UserStaticFile.shahrestan_int,
      "long": widget.long,
      "lut": widget.lat,
      "shobeCode": UserStaticFile.code.toString(),
      "shomarehesab": hesab == null ? "1" : hesab!,
      "noe_hesab": noeHesabSelectIDFinal == 0 ? null : noeHesabSelectIDFinal,
      "is_pos": isPos,
      "pos_number": posCount == null ? 0 : int.parse(posCount!),
    });
    String _url = UrlStaticFile.url + 'marker/create_marker';
    final response = await http.post(Uri.parse(_url),
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
        },
        body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MarketPage(),
          ));
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
        duration: const Duration(seconds: 2),
        content: const Text(
          "ثبت با موفقیت انجام شد",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.0,
            fontFamily: "Vazir",
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent.withOpacity(0.5),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
        duration: const Duration(seconds: 2),
        content: const Text(
          "متاسفانه ثبت انجام نشد ",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.0,
            fontFamily: "Vazir",
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

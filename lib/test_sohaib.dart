import 'package:flutter/material.dart';

class TestSohaib extends StatefulWidget {
  const TestSohaib({Key? key}) : super(key: key);

  @override
  _TestSohaibState createState() => _TestSohaibState();
}

class _TestSohaibState extends State<TestSohaib> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(),
            Container(
              height: 100.0,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Container(
                      height: 50,
                      width: 50.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.amber),
                    ),
                  );
                },
              ),
            ),
            Expanded(child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
              
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100.0,width: double.infinity,
                  decoration: BoxDecoration(color: Colors.amber.withOpacity(0.2),borderRadius: BorderRadius.circular(10.0)),
                ),
              );
            },))
          ],
        ),
      ),
    );
  }
}

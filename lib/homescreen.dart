import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  // bool _ischecked = false;
  bool toggle = false;
  TextEditingController namedcontroller = TextEditingController();
  void visibility() {}
  @override
  void initState() {
    super.initState();
    namedcontroller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.black,
        title: Text(
          'Simple TODO List',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Checkbox(
          //   valu:{Panged: (value) {
          //     setState(() {
          //       _ischecked = value ?? false;
          //     });
          //   },
          //   activeColor: Colors.red,
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.visiblePassword,
              controller: namedcontroller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: toggle
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility_sharp),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Colors.blue.shade400,
                    width: 5,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

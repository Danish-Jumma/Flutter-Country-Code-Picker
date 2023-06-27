// ignore_for_file: avoid_unnecessary_containers

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const HomeView());
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController phoneController = TextEditingController();
  final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Code Picker'),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Country Flage
              Container(
                margin: const EdgeInsets.only(right: 4),
                width: 40,
                child: countryCode != null ? countryCode!.flagImage() : null,
              ),
              // Country Code Container
              InkWell(
                onTap: () async {
                  final code = await countryPicker.showPicker(
                      context: context,
                      pickerMaxHeight: MediaQuery.of(context).size.height * .6);
                  setState(() {
                    countryCode = code;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 6),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    countryCode?.dialCode ?? "+1",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              // TextField
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                width: MediaQuery.of(context).size.width * .7,
                child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    hintText: 'enter phone number',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          // Elevated Button
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width * .6,
            child: ElevatedButton(
              onPressed: () {
                if (countryCode != null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text(countryCode!.dialCode + phoneController.text)));
                }
              },
              child: const Text('Login'),
            ),
          )
        ],
      ),
    );
  }
}

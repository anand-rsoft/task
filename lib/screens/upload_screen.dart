import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFCE6E6EE),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Upload Product\n\n",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'SourceSans3',
                    fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  buildTextFields(
                      "Product Name",
                      Icon(Icons.drive_file_rename_outline_sharp),
                      false,
                      TextInputType.text,
                      nameController),
                  buildTextFields("Brand", Icon(Icons.branding_watermark),
                      false, TextInputType.number, brandController),
                  buildTextFields("Size", Icon(Icons.format_size), false,
                      TextInputType.number, sizeController),
                  buildTextFields("Price", Icon(Icons.attach_money_rounded),
                      false, TextInputType.number, priceController),
                  buildTextFields("Discount", Icon(Icons.discount), false,
                      TextInputType.text, discountController),
                  InkWell(
                    onTap: () {
                      _pickFiles();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      margin: EdgeInsets.only(left: 40, right: 40, bottom: 20),
                      child: TextField(
                          enabled: false,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff666262),
                          ),
                          onChanged: (_) {},
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.image),
                            suffixIcon: Icon(Icons.upload),
                            hintStyle: TextStyle(color: Colors.grey),
                            counterText: '',
                            hintText: "Product Image",
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: Text('       Cancel       '),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: Text('       Upload       '),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildTextFields(String hintText, Icon prefixIcon, bool obsecureText,
      TextInputType keyboardType, var v) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      height: 40,
      margin: EdgeInsets.only(left: 40, right: 40, bottom: 20),
      child: TextField(
          controller: v,
          obscureText: obsecureText,
          keyboardType: keyboardType,
          textInputAction: TextInputAction.next,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff666262),
          ),
          onChanged: (_) {},
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            hintStyle: TextStyle(color: Colors.grey),
            counterText: '',
            contentPadding: EdgeInsets.only(left: 15, right: 10, top: 4),
            enabledBorder: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.white),
            ),
            hintText: hintText,
          )),
    );
  }

  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  late List<PlatformFile>? _paths;
  late FileType _pickingType = FileType.any;
  List<PlatformFile> allFiles = [];

  void _pickFiles() async {
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
      ))
          ?.files;

      for (var i = 0; i < _paths!.length; i++) {
        PlatformFile allFiles1 = _paths![i];
        allFiles.add(allFiles1);

        final bytes = File(allFiles1.path.toString()).readAsBytesSync();
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref =
            storage.ref().child("image1" + DateTime.now().toString());
        final File fileForFirebase = File(allFiles1.path.toString());
        UploadTask uploadTask = ref.putFile(fileForFirebase);
        uploadTask.then((res) {
          res.ref.getDownloadURL();
        });
      }
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {});
  }

  void _logException(String message) {
    print(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqflite/app/components/cupertino_action.dart';
import 'package:flutter_sqflite/core/components/cupertino_alert.dart';
import '../app/constants/application_constants.dart';
import '../app/helper/database_helper.dart';
import '../app/model/blood_pressure.dart';
import '../core/components/auto_sized_text.dart';
import '../core/extensions/context_extension.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  DatabaseHelper _dbHelper;

  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController systolicBloodPressure = TextEditingController();
    TextEditingController diastolicBloodPressure = TextEditingController();
    TextEditingController heartRhythm = TextEditingController();

    return Scaffold(
      body: Container(
        height: context.mediaQuery.size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizedText(text: ApplicationConstants.ADD_BLOOD_PRESSURE_TITLE),
            SizedBox(height: context.mediaQuery.size.height * 0.03),
            buildInputTextFormField(context.mediaQuery.size, ApplicationConstants.SYSTOLIC, 3, systolicBloodPressure),
            buildInputTextFormField(context.mediaQuery.size, ApplicationConstants.DIASTOLIC, 3, diastolicBloodPressure),
            buildInputTextFormField(context.mediaQuery.size, ApplicationConstants.HEART_RHYTHM, 3, heartRhythm),
            CupertinoButton(
              child: AutoSizedText(text: ApplicationConstants.SAVE),
              onPressed: () {
                // if user entered all required fields data will insert to database
                if (systolicBloodPressure.text.isNotEmpty && diastolicBloodPressure.text.isNotEmpty && heartRhythm.text.isNotEmpty) {
                  _setLocalStorage(int.parse(systolicBloodPressure.text), int.parse(diastolicBloodPressure.text), int.parse(heartRhythm.text));
                  Navigator.of(context).pop();
                } 
                // if user don't enter all required fields alert will pop-up
                else {
                  return showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return CupertinoAlert(
                        title: ApplicationConstants.EMPTY_FIELD_WARNING,
                        actions: [CupertinoAction(text: ApplicationConstants.OK)],
                      );
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void _setLocalStorage(int systolicBloodPressure, int diastolicBloodPressure, int heartRhythm) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy | kk:mm', 'en_US').format(now);
    final bloodPressure = BloodPressure(systolicBloodPressure, diastolicBloodPressure, heartRhythm, formattedDate);
    await _dbHelper.insert(bloodPressure);
  }

  Container buildInputTextFormField(Size size, String labelText, int maxLength, controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.10, vertical: size.height * 0.01),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: maxLength,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}

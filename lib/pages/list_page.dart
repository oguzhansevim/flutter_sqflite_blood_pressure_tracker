import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqflite/core/components/cupertino_alert.dart';
import '../app/constants/application_constants.dart';
import '../app/helper/color_picker_helper.dart';
import '../app/helper/database_helper.dart';
import '../app/model/blood_pressure.dart';
import '../core/components/auto_sized_text.dart';
import 'add_page.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  DatabaseHelper _dbHelper;

  @override
  void initState() {
    super.initState();

    _dbHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: AutoSizedText(text: ApplicationConstants.BLOOD_PRESSURE_TITLE),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openBottomModal(),
      ),
      body: Container(
        color: Colors.white70,
        child: FutureBuilder(
          future: _dbHelper.get(),
          builder: (BuildContext context, AsyncSnapshot<List<BloodPressure>> snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (snapshot.data.isEmpty)
              return Center(
                child: AutoSizedText(text: ApplicationConstants.NO_DATA),
              );
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                BloodPressure bloodPressure = snapshot.data[index];
                return Container(
                  height: size.height * 0.15,
                  padding: EdgeInsets.only(right: 8.0),
                  margin: EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        buildCategoryColorColumn(size, bloodPressure),
                        buildBloodPressureDataColumn(bloodPressure, size),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Column buildCategoryColorColumn(Size size, BloodPressure bloodPressure) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildCategoryColor(size, 'SYS', bloodPressure.systolicBloodPressure),
        buildCategoryColor(size, 'DIA', bloodPressure.diastolicBloodPressure),
      ],
    );
  }

  Expanded buildBloodPressureDataColumn(BloodPressure bloodPressure, Size size) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildBloodPressureDate(bloodPressure.date),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildColumn('SYS', bloodPressure.systolicBloodPressure),
              buildCustomDivider(size),
              buildColumn('DIA', bloodPressure.diastolicBloodPressure),
              buildColumn('BPM', bloodPressure.heartRhythm),
              buildIconButton(bloodPressure),
            ],
          ),
        ],
      ),
    );
  }

  Padding buildBloodPressureDate(String date) {
    return Padding(
      padding: EdgeInsets.only(left: 5.0, top: 5.0),
      child: Text(date),
    );
  }

  Container buildCustomDivider(Size size) {
    return Container(
      height: size.height * 0.004,
      width: size.width * 0.03,
      color: Colors.grey[600],
    );
  }

  IconButton buildIconButton(BloodPressure bloodPressure) {
    return IconButton(
      icon: Icon(
        Icons.delete,
        color: Colors.red,
      ),
      onPressed: () => {
        _showCupertinoDialog(bloodPressure.id),
      },
    );
  }

  Container buildCategoryColor(Size size, String colorPickerType, int bloodPressureType) {
    return Container(
      width: size.width * 0.025,
      height: size.height * 0.075,
      color: colorPicker(
        colorPickerType,
        bloodPressureType,
      ),
    );
  }

  Column buildColumn(String type, int value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        (type == 'SYS' || type == 'DIA')
            ? Text(
                type,
                style: TextStyle(
                  color: colorPicker(
                    type,
                    value,
                  ),
                ),
              )
            : Icon(
                Icons.favorite,
                color: Colors.red,
                size: 20.0,
              ),
        Text(
          value.toString(),
          style: TextStyle(
            color: colorPicker(
              type,
              value,
            ),
            fontSize: 32.0,
          ),
        ),
        type == 'SYS'
            ? Text('mmHg', style: TextStyle(color: Colors.grey[700], fontSize: 10.0))
            : type == 'BPM'
                ? Text('BPM', style: TextStyle(color: Colors.grey[700], fontSize: 10.0))
                : Text('', style: TextStyle(color: Colors.grey[700], fontSize: 10.0)),
      ],
    );
  }

  Future<void> _showCupertinoDialog(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlert(
            title: ApplicationConstants.DELETE_CONFIRM,
            actions: [buildDialogAction(ApplicationConstants.NO, false, id), buildDialogAction(ApplicationConstants.YES, true, id)]);
      },
    );
  }

  buildDialogAction(String text, bool type, int id) {
    return CupertinoDialogAction(
      child: Text(text),
      onPressed: () {
        if (type == true) {
          setState(() {
            _delete(id);
          });
        }
        Navigator.of(context).pop();
      },
    );
  }

  void _delete(int id) async {
    await _dbHelper.delete(id);
  }

  void _openBottomModal() {
    var modalBottom = showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AddPage();
      },
    );

    modalBottom.whenComplete(
      () => {
        setState(() {
          _dbHelper.get();
        }),
      },
    );
  }
}

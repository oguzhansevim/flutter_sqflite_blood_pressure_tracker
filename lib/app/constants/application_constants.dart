import 'package:flutter/material.dart';

class ApplicationConstants {
  // STRING CONSTANTS
  static const BLOOD_PRESSURE_TITLE = 'Tansiyon Verilerim';
  static const SYSTOLIC = 'Büyük Tansiyon';
  static const DIASTOLIC = 'Küçük Tansiyon';
  static const HEART_RHYTHM = 'Kalp Ritmi';
  static const DELETE_CONFIRM = 'Bu kayıdı silmek istediğinize emin misiniz?';
  static const NO = 'Hayır';
  static const YES = 'Evet';
  static const NO_DATA = 'Sistemde tansiyon veriniz bulunmamaktadır.';
  static const ADD_BLOOD_PRESSURE_TITLE = 'Tansiyon Bilginizi Giriniz';
  static const ADD = 'Giriniz';
  static const SAVE = 'Kaydet';
  static const EMPTY_FIELD_WARNING = 'Tansiyon verinizin sisteme kayıt edilebilmesi için tüm alanları eksiksiz doldurmanız gerekmektedir.';
  static const OK = 'Tamam';

  // DATABASE CONSTANTS
  static const DATABASE = 'BloodPressureTracker.db';
  static const DATABASE_CREATE_QUERY =
      'CREATE TABLE BloodPressures(id INTEGER PRIMARY KEY, systolic_blood_pressure INTEGER, diastolic_blood_pressure INTEGER, heart_rhythm INTEGER, date TEXT)';
  static const DATABASE_TABLE = 'BloodPressures';

  /*
  $imperial-red: #e63946ff;
  $honeydew: #f1faeeff;
  $powder-blue: #a8dadcff;
  $celadon-blue: #457b9dff;
  $prussian-blue: #1d3557ff;
  $amaranth-red: #d90429ff;

  ALL COLORS
  https://coolors.co/e63946-f1faee-a8dadc-457b9d-1d3557
  THE LATEST COLOR
  https://coolors.co/2b2d42-8d99ae-edf2f4-ef233c-d90429
  */
  final imperialRed = Color(0xFFE63946);
  final honeyDew = Color(0xFFF1FAEE);
  final powderBlue = Color(0xFFA8DADC);
  final celadonBlue = Color(0xFF457B9D);
  final prussianBlue = Color(0xFF1D3557);
  final amaranthRed = Color(0xFF1d90429);

  static const kPrimaryColor = Color(0xFFE63946);
}

import 'package:flutter/material.dart';
import 'package:revision_contact_diary_app/models/contact_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ContactController extends ChangeNotifier {
  // State

  ContactModel contact = ContactModel(
    nameList: [],
    phoneList: [],
    emailList: [],
  );

  // Methods

  // Default Constructor
  ContactController() {
    initSharedPreferenceObject();

    contact.nameList = preferences.getStringList('nameList') ?? [];
    contact.phoneList = preferences.getStringList('phoneList') ?? [];
    contact.emailList = preferences.getStringList('emailList') ?? [];
  }

  Future<void> initSharedPreferenceObject() async {
    preferences = await SharedPreferences.getInstance();
  }

  // CRUD => C -> Create  R -> Read, Fetch  U -> Update  D -> Delete

  // To Insert Contact Data
  void addContactData({
    required String name,
    required String phone,
    required String email,
  }) async {
    contact.nameList.add(name);
    contact.phoneList.add(phone);
    contact.emailList.add(email);

    await preferences.setStringList('nameList', contact.nameList);
    await preferences.setStringList('phoneList', contact.phoneList);
    await preferences.setStringList('emailList', contact.emailList);

    notifyListeners();
  }

  // To Update Contact Data
  void updateContactData({
    required String name,
    required String phone,
    required String email,
    required int index,
  }) {
    contact.nameList[index] = name;
    contact.phoneList[index] = phone;
    contact.emailList[index] = email;

    notifyListeners();
  }

  // To Delete Contact Data
  void deleteContactData({required int index}) async {
    contact.nameList.removeAt(index);
    contact.phoneList.removeAt(index);
    contact.emailList.removeAt(index);

    await preferences.setStringList('nameList', contact.nameList);
    await preferences.setStringList('phoneList', contact.phoneList);
    await preferences.setStringList('emailList', contact.emailList);

    notifyListeners();
  }
}

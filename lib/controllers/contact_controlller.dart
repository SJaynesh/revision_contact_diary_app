import 'package:flutter/material.dart';
import 'package:revision_contact_diary_app/models/contact_model.dart';

class ContactController extends ChangeNotifier {
  // State
  ContactModel contact = ContactModel(
    nameList: [],
    phoneList: [],
    emailList: [],
  );

  // Methods

  // CRUD => C -> Create  R -> Read, Fetch  U -> Update  D -> Delete

  // To Insert Contact Data
  void addContactData({
    required String name,
    required String phone,
    required String email,
  }) {
    contact.nameList.add(name);
    contact.phoneList.add(phone);
    contact.emailList.add(email);

    notifyListeners();
  }

  // To Delete Contact Data
  void deleteContactData({required int index}) {
    contact.nameList.removeAt(index);
    contact.phoneList.removeAt(index);
    contact.emailList.removeAt(index);

    notifyListeners();
  }
}

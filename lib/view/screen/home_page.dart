import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revision_contact_diary_app/controllers/contact_controlller.dart';

GlobalKey<FormState> formKey = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController emailController = TextEditingController();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Diary Page"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("ADD CONTACT"),
                content: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        validator: (val) =>
                            (val!.isEmpty) ? "Enter your name.." : null,
                        decoration: const InputDecoration(
                          labelText: "Name",
                          hintText: "Enter your name",
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: phoneController,
                        textInputAction: TextInputAction.next,
                        maxLength: 10,
                        validator: (val) =>
                            (val!.isEmpty) ? "Enter your phone.." : null,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Phone Number",
                          hintText: "Enter your phone",
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: emailController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) =>
                            (val!.isEmpty) ? "Enter your email.." : null,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          hintText: "Enter your email",
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  FloatingActionButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        String name = nameController.text;
                        String phone = phoneController.text;
                        String email = emailController.text;

                        log("Name : $name \nPhone : $phone\nEmail : $email");

                        Provider.of<ContactController>(context, listen: false)
                            .addContactData(
                          name: name,
                          phone: phone,
                          email: email,
                        );

                        Navigator.pop(context);

                        nameController.clear();
                        phoneController.clear();
                        emailController.clear();
                      }
                    },
                    child: const Text("Add"),
                  )
                ],
              );
            },
          );
        },
        child: const Icon(Icons.contact_page),
      ),
      body: Consumer<ContactController>(
        builder: (ctx, provider, _) => (provider.contact.emailList.isNotEmpty)
            ? ListView.separated(
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  String name = provider.contact.nameList[index];
                  String phone = provider.contact.phoneList[index];
                  String email = provider.contact.emailList[index];
                  return Card(
                    color: Colors.grey[300],
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurpleAccent,
                        child: Text(
                          name[0],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text(name),
                      subtitle: Text(phone),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              provider.deleteContactData(index: index);

                              SnackBar snackBar = SnackBar(
                                content: Text(
                                  "$name is deleted..",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.redAccent,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin: const EdgeInsets.all(5),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: Divider(),
                ),
                itemCount: provider.contact.nameList.length,
              )
            : const Center(
                child: Text("No Contact Available.."),
              ),
      ),
    );
  }
}

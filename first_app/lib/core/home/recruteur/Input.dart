import 'package:first_app/core/home/recruteur/added.dart';
import 'package:flutter/material.dart';

class recInput extends StatefulWidget {
  const recInput({Key? key}) : super(key: key);

  @override
  State<recInput> createState() => _recInputState();
}

class _recInputState extends State<recInput> {
  final _formKey = GlobalKey<FormState>();
  var profile = TextEditingController();
  var periode = TextEditingController();
  var requirement = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Create requirement ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextFormField(
                        controller: profile,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter  profile ";
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.person_outline),
                          hintText: "Profile",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextFormField(
                        controller: periode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter periode";
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.person_outline),
                          hintText: "Periode",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    //requirement  field
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextFormField(
                        controller: requirement,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter requirement";
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.person_outline),
                          hintText: "requirement",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    //+add Button

                    MaterialButton(
                      color: Colors.grey,
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 50,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const added()));
                      },
                      child: const Text(
                        "+add",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

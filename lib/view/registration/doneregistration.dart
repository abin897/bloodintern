import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
import '../helper/dbhelper.dart';
import '../helper/model.dart';
import 'donerlist.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Dbhealper dbhealper = Dbhealper();
  Gender defaultgender = Gender.male;

  TextEditingController nameclr = TextEditingController();
  TextEditingController phclr = TextEditingController();
  TextEditingController wigtclr = TextEditingController();
  TextEditingController ageclr = TextEditingController();
  TextEditingController ldonatclr = TextEditingController();
  TextEditingController bloodclr = TextEditingController();
  TextEditingController Genderclr = TextEditingController();
  TextEditingController placeclr = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Blood group dropdown
  List<String> bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String? selectedBloodType;

  showmydatepicker(BuildContext context) async {
    DateTime? pickdate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (pickdate != null) {
      String formatedate = DateFormat("yyyy/MM/dd").format(pickdate);
      setState(() {
        ldonatclr.text = formatedate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        toolbarHeight: 80,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red.shade500, Colors.blue.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          "DONER REGISTRATION",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fill out the form to add a Donor",
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      color: Color(0xFF050622),
                      letterSpacing: .5,
                      decoration: TextDecoration.underline,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                buildTextField(nameclr, "Name", "Enter your name", Icons.person),
                SizedBox(height: 20),
                buildTextField(phclr, "Phone Number", "Enter your phone number", Icons.phone, isNumber: true),
                SizedBox(height: 20),

                // Date of Birth Picker
                buildDateField(ageclr, "Date of Birth", Icons.calendar_today, context),
                SizedBox(height: 20),

                // Gender Selection
                Text("Gender:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Radio(
                      value: Gender.male,
                      groupValue: defaultgender,
                      onChanged: (value) {
                        setState(() => defaultgender = Gender.male);
                      },
                    ),
                    Text("Male"),
                    Radio(
                      value: Gender.female,
                      groupValue: defaultgender,
                      onChanged: (value) {
                        setState(() => defaultgender = Gender.female);
                      },
                    ),
                    Text("Female"),
                    Radio(
                      value: Gender.other,
                      groupValue: defaultgender,
                      onChanged: (value) {
                        setState(() => defaultgender = Gender.other);
                      },
                    ),
                    Text("Other"),
                  ],
                ),
                SizedBox(height: 10),

                // Weight
                buildTextField(wigtclr, "Weight", "Enter your weight", Icons.fitness_center, isNumber: true),
                SizedBox(height: 20),
                SizedBox(height: 20),
                buildTextField(placeclr, "Place", "Enter your place", Icons.location_on),
                SizedBox(height: 20),

                // Blood Group Dropdown
                DropdownButtonFormField<String>(
                  value: selectedBloodType,
                  items: bloodTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: "Blood Group",
                    prefixIcon: Icon(Icons.bloodtype, color: Colors.red.shade800),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedBloodType = value;
                      bloodclr.text = value!;
                    });
                  },
                  validator: (value) => value == null ? "Please select your blood group" : null,
                ),
                SizedBox(height: 20),

                // Last Donation Date
                buildDateField(ldonatclr, "Last Donated Date", Icons.calendar_today, context),
                SizedBox(height: 40),

                // Register Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        User u = User(
                          name: nameclr.text,
                          ph: phclr.text,
                          age: ageclr.text,
                          blood: bloodclr.text,
                          gender: defaultgender.name,
                          donated: ldonatclr.text,
                          weight: wigtclr.text,
                          place: placeclr.text,
                        );

                        dbhealper.insertuser(u).then((onValue) {
                          notifications.add("Registration successful for ${u.name}");
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DonorListPage(specificDonor: u),
                            ),
                          );
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF050622),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: Text("Register", style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      TextEditingController controller,
      String label,
      String hint,
      IconData icon, {
        bool isNumber = false,
      }) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.red.shade800),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: (value) => value!.isEmpty ? "This field is required" : null,
    );
  }

  Widget buildDateField(
      TextEditingController controller,
      String label,
      IconData icon,
      BuildContext context,
      ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.red.shade800),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickdate = await showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
          initialDate: DateTime.now(),
        );
        if (pickdate != null) {
          setState(() {
            controller.text = DateFormat("yyyy/MM/dd").format(pickdate);
          });
        }
      },
      validator: (value) => value!.isEmpty ? "This field is required" : null,
    );
  }
}

enum Gender { male, female, other }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login/applogin.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final placeController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? selectedBloodType;
  final List<String> bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/images/background.png'),
    fit: BoxFit.cover,
    ),
    ),

      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 5,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        "Create New Account",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),
        
                      buildInputField(
                          controller: nameController,
                          hint: "Full Name",
                          icon: Icons.person),
                      const SizedBox(height: 16),
        
                      buildInputField(
                          controller: ageController,
                          hint: "Age",
                          icon: Icons.cake,
                          keyboard: TextInputType.number),
                      const SizedBox(height: 16),
        
                      buildInputField(
                          controller: placeController,
                          hint: "Place",
                          icon: Icons.location_on),
                      const SizedBox(height: 16),
        
                      buildInputField(
                          controller: emailController,
                          hint: "Email",
                          icon: Icons.email,
                          keyboard: TextInputType.emailAddress),
                      const SizedBox(height: 16),
        
                      buildInputField(
                          controller: passwordController,
                          hint: "Password",
                          icon: Icons.lock,
                          obscure: true),
                      const SizedBox(height: 16),
        
                      // Blood Type Dropdown
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.bloodtype, color: Colors.redAccent),
                          hintText: "Select Blood Type",
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        value: selectedBloodType,
                        items: bloodTypes.map((String type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        validator: (value) =>
                        value == null ? "Please select your blood type" : null,
                        onChanged: (value) {
                          setState(() {
                            selectedBloodType = value;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
        
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final prefs = await SharedPreferences.getInstance();
                              await prefs.setString("name", nameController.text);
                              await prefs.setString("age", ageController.text);
                              await prefs.setString("place", placeController.text);
                              await prefs.setString("email", emailController.text);
                              await prefs.setString("password", passwordController.text);
                              await prefs.setString("bloodType", selectedBloodType!);
        
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Registration Successful"),
                                  backgroundColor: Colors.green,
                                ),
                              );
        
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const Loginscreen()),
                              );
                            }
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
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
      ),
    ));
  }

  Widget buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboard = TextInputType.text,
    bool obscure = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboard,
      validator: (value) => value == null || value.isEmpty ? "Required" : null,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.pinkAccent),
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

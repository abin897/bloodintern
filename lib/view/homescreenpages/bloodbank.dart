import 'package:flutter/material.dart';
import '../helper/dbhelper.dart';
import '../helper/model.dart';
import 'package:url_launcher/url_launcher.dart';

class BloodGroupSearchPage extends StatefulWidget {
  const BloodGroupSearchPage({super.key});

  @override
  State<BloodGroupSearchPage> createState() => _BloodGroupSearchPageState();
}

class _BloodGroupSearchPageState extends State<BloodGroupSearchPage> {
  final Dbhealper dbhelper = Dbhealper();
  List<User> allDonors = [];
  List<User> filteredDonors = [];
  String? selectedBloodGroup;

  final List<String> bloodGroups = [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
  ];

  @override
  void initState() {
    super.initState();
    fetchAllDonors();
  }

  Future<void> fetchAllDonors() async {
    final donors = await dbhelper.getAllUsers();
    setState(() {
      allDonors = donors ?? [];
    });
  }

  void filterDonors() {
    if (selectedBloodGroup != null) {
      filteredDonors = allDonors
          .where((donor) =>
      donor.blood.toLowerCase().trim() ==
          selectedBloodGroup!.toLowerCase().trim())
          .toList();
      setState(() {});
    }
  }

  void voiceCall(String phoneNumber) {
    final Uri uri = Uri.parse("tel:$phoneNumber");
    launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(toolbarHeight: 80,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red.shade500, Colors.blue.shade500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text("Search by Blood Group"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Select Blood Group",
                border: OutlineInputBorder(),
              ),
              items: bloodGroups
                  .map((bg) => DropdownMenuItem(
                value: bg,
                child: Text(bg),
              ))
                  .toList(),
              value: selectedBloodGroup,
              onChanged: (value) {
                setState(() => selectedBloodGroup = value);
              },
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: filterDonors,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
              ),
              child: const Text("Search Now"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: filteredDonors.isEmpty
                  ? const Text("No matching donors found.")
                  : ListView.builder(
                itemCount: filteredDonors.length,
                itemBuilder: (context, index) {
                  final donor = filteredDonors[index];
                  return Card(
                    child: ListTile(
                      leading: ElevatedButton(
                        onPressed: () => voiceCall(donor.ph),
                        child: const Icon(Icons.call),
                      ),
                      title: Text(donor.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Phone: ${donor.ph}"),
                          Text("Age: ${donor.age}"),
                          Text("Blood Group: ${donor.blood}"),
                          Text("Gender: ${donor.gender}"),
                          Text("Last Donation: ${donor.donated}"),
                          Text("Weight: ${donor.weight}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

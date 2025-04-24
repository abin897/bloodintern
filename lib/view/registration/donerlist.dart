import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/dbhelper.dart';
import '../helper/model.dart';

class DonorListPage extends StatefulWidget {
  final User? specificDonor;

  const DonorListPage({Key? key, this.specificDonor}) : super(key: key);

  @override
  State<DonorListPage> createState() => _DonorListPageState();
}

class _DonorListPageState extends State<DonorListPage> {
  Dbhealper dbhelper = Dbhealper();
  List<User> donorList = [];

  @override
  void initState() {
    super.initState();
    if (widget.specificDonor != null) {
      donorList = [widget.specificDonor!];
    } else {
      fetchDonors();
    }
  }

  Future<void> fetchDonors() async {
    final List<User>? donors = await dbhelper.getAllUsers();
    setState(() {
      donorList = donors ?? [];
    });
  }

  // void voicecall(String? phone){
  //   Uri uri=Uri.parse("tel:$phone"
  //   );
  //   launchUrl(uri);
  // }
  void voiceCall(String phoneNumber) async {
    // Ensure the phone number is properly formatted
    final Uri uri = Uri.parse('tel:$phoneNumber');

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        // If launching fails, show a snackbar
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not launch dialer')),
          );
        }
      }
    } catch (e) {
      print('Error launching dialer: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red.shade400, Colors.purple.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          "Donor List",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: donorList.isEmpty
          ? const Center(
        child: Text(
          "No donors found.",
          style: TextStyle(fontSize: 18, color: Colors.black54),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: donorList.length,
        itemBuilder: (context, index) {
          final donor = donorList[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          donor.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.call, color: Colors.green),
                        onPressed: () {
                          // Make sure we have a non-empty phone number
                          if (donor.ph.isNotEmpty) {
                            String sanitizedPhoneNumber = donor.ph.replaceAll(RegExp(r'[^0-9+]'), '');
                            print('Attempting to call: $sanitizedPhoneNumber');
                            voiceCall(sanitizedPhoneNumber);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('No phone number available')),
                            );
                          }
                        },
                      )
                    ],
                  ),
                  const Divider(height: 20),
                  InfoRow(label: "Phone", value: donor.ph),
                  InfoRow(label: "Age", value: donor.age),
                  InfoRow(label: "Blood Group", value: donor.blood),
                  InfoRow(label: "Gender", value: donor.gender),
                  InfoRow(label: "Last Donation", value: donor.donated),
                  InfoRow(label: "Weight", value: donor.weight),
                  InfoRow(label: "Place", value: donor.place),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

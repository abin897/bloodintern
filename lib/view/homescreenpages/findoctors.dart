import 'package:flutter/material.dart';

class FindDoctors extends StatefulWidget {
  const FindDoctors({super.key});

  @override
  State<FindDoctors> createState() => _FindDoctorsState();
}

class _FindDoctorsState extends State<FindDoctors> {
  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr. Kamala Bhai',
      'specialty': 'Cardiologist',
      'rating': 4.9,
      'time': '10:30 AM - 2:00 PM',
      'image': 'assets/images/kamala.png',
      'patients': '100+',
      'experience': '10+',
      'reviews': '100',
      'about':
      "She is one of the most experienced cardiologists at Chri Hospital, London. She has achieved several awards in health organizations and is one of the best doctors in the world."
    },
    {
      'name': 'Dr. Jacob Jones',
      'specialty': 'Pediatrician',
      'rating': 4.8,
      'time': '10:30 AM - 4:30 PM',
      'image': 'assets/images/doctors.png',
      'patients': '150+',
      'experience': '6+',
      'reviews': '120',
      'about':
      "He is a leading pediatrician at Apollo Hospital, Chennai. He has achieved several awards and is considered one of the best in India."
    },
    {
      'name': 'Dr. Sofia Williams',
      'specialty': 'Neurologist',
      'rating': 4.7,
      'time': '9:00 AM - 1:00 PM',
      'image': 'assets/images/women.png',
      'patients': '120+',
      'experience': '8+',
      'reviews': '80',
      'about':
      "She is a top neurologist at CMS Hospital, London. She has received many awards and is renowned globally."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text("Our  Doctors"),

      ),
      body: ListView.builder(
        itemCount: doctors.length,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        itemBuilder: (context, index) {
          final doctor = doctors[index];

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Doctor's Image
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: AssetImage(doctor['image']),
                  ),
                  SizedBox(width: 12),

                  // Doctor Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor['name'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          doctor['specialty'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Rating + Button
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 18),
                          SizedBox(width: 4),
                          Text(
                            doctor['rating'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Navigate to doctor details screen
                          // You can pass doctor details using Navigator
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "VIEW",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:bloodintern/view/homescreenpages/findoctors.dart';
import 'package:bloodintern/view/homescreenpages/hospital%20list.dart';
import 'package:bloodintern/view/pages/profile.dart';
import 'package:bloodintern/view/pages/soscreen.dart';
import 'package:bloodintern/view/registration/donerlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloodbank.dart';

class Hospitalpage extends StatefulWidget {
   final String hospitalName;
   final String specialty;
   final String imagePath;
   final String rating;
   final String place;
   final String about;final String reviews;
  Hospitalpage({
    super.key,
    required this.hospitalName,
    required this.specialty,
    required this.imagePath,
    required this.rating,
    required this.place,
    required this.about,
    required this.reviews,
  });


  @override
  State<Hospitalpage> createState() => _HospitalpageState();
}

class _HospitalpageState extends State<Hospitalpage> {
  final List<String> facilities = [
    'EMERGENCY  CARE',
    'ICU',
    'SURGERY',

  ];
  final List<String> facilitie = [
    'Cardiology',
    'Neurology',
    'Pediatrics',

  ];


  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr. Kamala bhai',
      'specialty': 'Cardiologist',
      'rating': 4.9,
      'time': '10:30 AM - 2:00 PM',
      'image': 'assets/images/kamala.png',
      'patients':'100+',
      'experience':'10+',
      'reviews':'100',
      'about':"She is one of the most cardioligist specialist in chri Hospital London,UK,She achived several awards in health organisation and one of the best doctor in the World "
    },
    {
      'name': 'Dr. Jacob Jones',
      'specialty': 'Pediatrician',
      'rating': 4.8,
      'time': '10:30 AM - 4:30 PM',
      'image': 'assets/images/doctors.png',
      'patients':'150+',
      'experience':'6+',
      'reviews':'120',
      'about':"he is one of the most pediatrican specialist in appolo Hospital cheenai,,he achived several awards in health organisation and one of the best doctor in the india "



    },
    {
      'name': 'Dr. Sofia Williams',
      'specialty': 'Neurologist',
      'rating': 4.7,
      'time': '9:00 AM - 1:00 PM',
      'image': 'assets/images/women.png',
      'about':"she is one of the most neurologist  specialist in cms Hospital London,UK,she achived several awards in health organisation and one of the best doctor in the World "

    },
  ];
  final List<Map<String, dynamic>> gridItems = [
    {
      'icon': Icons.bloodtype,
      'title': 'Donors',
      'subtitle': 'Check the donor list to choose donors.',
      'page':DonorListPage(),

    },
    {
      'icon': Icons.medical_services_outlined,
      'title': 'Doctors',
      'subtitle': 'Find doctor to get prescription',
      'page':FindDoctors(),
    },
    {
      'icon': Icons.bloodtype_outlined,
      'title': 'find Blood',
      'subtitle': 'Find Suitable Donor and Request Blood',
      'page':BloodGroupSearchPage(),
    },


    {
      'icon': Icons.contact_support_outlined,
      'title': 'Contact Us',
      'subtitle': 'See Our Contact Information',
      'page':hospitalist(),
    },
  ];
  @override
  Widget build(BuildContext context) {
    return      Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 4,
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
          leading: IconButton(
            icon: Icon(CupertinoIcons.back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "HOSPITAL DETAILS",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(


                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(

                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    widget.hospitalName,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Text(
                    widget.specialty,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),


                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensures proper spacing
                    children: [
                      _infoCard(Icons.location_on,
                          widget.place, ''),
                      SizedBox(height: 10,),
                      _infoCard(Icons.star, widget.rating.toString(), ''),

                    ],

                  ),
                  SizedBox(height: 30,),
                  Row(
children: [
  Expanded(
    child: GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: gridItems.map((item) {
        return GestureDetector(
          onTap: () {
            // Navigate to the corresponding page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => item['page']),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item['icon'],
                  size: 32,
                  color: Colors.red,
                ),
                SizedBox(height: 10),
                Text(
                  item['title'],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 6),
                Text(
                  item['subtitle'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    ),
  )

],
                  ),
                  SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.start,mainAxisSize: MainAxisSize.min,crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // Center(
                        //   child: Text(
                        //     'OUR DOCTORS',
                        //     style: TextStyle(fontSize:25, fontWeight: FontWeight.bold, color: Colors.blue),
                        //   ),
                        // ),
                        // ListView.builder(
                        //   shrinkWrap: true,
                        //   physics: NeverScrollableScrollPhysics(),
                        //   itemCount: doctors.length,
                        //   itemBuilder: (context, index) {
                        //     final doctor = doctors[index];
                        //     return Padding(
                        //       padding: const EdgeInsets.symmetric(
                        //         horizontal: 3,
                        //         vertical: 10,
                        //       ),
                        //       child: Card(
                        //         shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(16),
                        //         ),
                        //         elevation: 4, // Added shadow effect
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(12.0),
                        //           child: Row(
                        //             crossAxisAlignment:
                        //             CrossAxisAlignment
                        //                 .center, // Align items vertically
                        //             children: [
                        //               // Doctor's Image
                        //               CircleAvatar(
                        //                 radius: 35,
                        //                 backgroundColor:
                        //                 Colors.grey[200], // Placeholder color
                        //                 backgroundImage:
                        //                    AssetImage('assets/images/abz.jpg'),
                        //
                        //
                        //               ),
                        //               SizedBox(
                        //                 width: 12,
                        //               ), // Spacing between image and text
                        //               // Doctor's Details (Name, Specialty)
                        //               Expanded(
                        //                 child: Column(
                        //                   crossAxisAlignment: CrossAxisAlignment.start,
                        //                   children: [
                        //                     // Doctor's Name
                        //                     Text(
                        //                       doctor['name'] ?? "",
                        //                       style: TextStyle(
                        //                         fontSize: 16,
                        //                         fontWeight: FontWeight.bold,
                        //                       ),
                        //                     ),
                        //                     SizedBox(height: 4),
                        //
                        //                     // Specialty
                        //                     Text(
                        //                       doctor['specialty'],
                        //                       style: TextStyle(
                        //                         color: Colors.grey[600],
                        //                         fontSize: 14,
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //
                        //               // Rating & Button Column
                        //               Column(
                        //                 crossAxisAlignment: CrossAxisAlignment.center,
                        //                 children: [
                        //                   // Rating Row (Star Icon + Rating Value)
                        //                   Row(
                        //                     children: [
                        //                       Icon(
                        //                         Icons.star,
                        //                         color: Colors.amber,
                        //                         size: 18,
                        //                       ),
                        //                       SizedBox(width: 4),
                        //                       Text(
                        //                         doctor['rating'].toString(),
                        //                         style: TextStyle(
                        //                           fontWeight: FontWeight.bold,
                        //                           fontSize: 14,
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   SizedBox(height: 6),
                        //
                        //                   // "Book Now" Button
                        //                   ElevatedButton(
                        //                     onPressed: () {
                        //                       // Navigator.push(
                        //                       //
                        //                         // MaterialPageRoute(
                        //                         //   builder: (context) => DoctorDetailsScreen(
                        //                         //     doctorName: doctor[index].name.toString(),
                        //                         //     specialty:doctor[index].speciality.toString(),
                        //                         //     imagePath:doctor![index].image != null ?
                        //                         //     "${doctor![index].image}" : "https://images.pexels.com/photos/4769130/pexels-photo-4769130.jpeg?auto=compress&cs=tinysrgb&w=600",
                        //                         //     experience: doctor[index].experience.toString(),
                        //                         //     rating: doctor[index].rating.toString(),
                        //                         //     reviews: doctors[index]['reviews']?.toString() ?? 'No reviews available',
                        //                         //     patients:doctors[index]['patients']?.toString() ?? 'No patients available',
                        //                         //     about: doctor[index].about.toString(),
                        //                         //   ),
                        //                         // ),
                        //                       // );
                        //
                        //
                        //
                        //
                        //                     },
                        //                     style: ElevatedButton.styleFrom(
                        //                       backgroundColor: Colors.blue,
                        //                       shape: RoundedRectangleBorder(
                        //                         borderRadius: BorderRadius.circular(8),
                        //                       ),
                        //                       padding: EdgeInsets.symmetric(
                        //                         horizontal: 12,
                        //                         vertical: 8,
                        //                       ),
                        //                     ),
                        //                     child: Text(
                        //                       "VIEW",
                        //                       style: TextStyle(
                        //                         fontSize: 12,
                        //                         color: Colors.white,
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // ),
                      ],
                    ),
                  ),


                ],

              ),
            ),
          ),
        );
  }
  Widget _infoCard(IconData icon, String value, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.red, size: 28),
        SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      ],

    );

  }
}


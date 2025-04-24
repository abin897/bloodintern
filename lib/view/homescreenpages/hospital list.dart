import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'hospitalpage.dart';

class hospitalist extends StatefulWidget {
  const hospitalist({super.key});

  @override
  State<hospitalist> createState() => _hospitalistState();
}

class _hospitalistState extends State<hospitalist> {
  final List<Map<String, dynamic>> hospital = [
    {
      'name': 'Appollo  Hospital',
      'specialty': 'multti Speciality ',
      'rating': 4.7,
      'Location': 'chennai',
      'place': 'delhi',
      'image': 'assets/images/apolo.png',
    },
    {
      'name': 'Amritha Hospital',
      'specialty': 'multi speciality',
      'rating': 4.7,
      'place': 'kochi',
      'image': 'assets/images/amritha.png',
    },
    {
      'name': 'Rajagiri Hospital',
      'specialty': 'multi speciality',
      'rating': 4.9,
      'place': 'aluva',
      'image': 'assets/images/rajagiri.png',
    },
    {
      'name': 'Lissie Hospital',
       'specialty':'multi speciality',
      'rating':4.6,
      'place': 'Ernakulam',
      'image':'assets/images/lissie.png',
    },
    {
      'name': 'astermedcity Hospital',
      'specialty':'multi speciality',
      'rating':4.6,
      'place': 'mumbai',
      'image':'assets/images/astermedcity.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.deepPurple.shade100,
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
          "HOSPITALS",
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
      body:                   ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount:   hospital.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 4, // Added shadow effect
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, ),
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .center, // Align items vertically
                  children: [
                    // Doctor's Image
                    // CircleAvatar(
                    //   radius: 35,
                    //   backgroundColor: Colors.grey[200], // Placeholder color
                    //   backgroundImage: AssetImage(doctor['image']),
                    //   child: ClipOval(
                    //     child: Image.asset(
                    //       doctor['image'],
                    //       fit: BoxFit.cover,
                    //       width: 70,
                    //       height: 70,
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 6),
                      child: Container(
                        height:100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.contain,
                           image: AssetImage(hospital[index]['image'],)

                            // value.Hospitallist![index].image != null
                            //     ? "${ApiEnvironment.dev.baseUrl}/${value.Hospitallist![index].image}"
                            //     : "https://images.pexels.com/photos/17795207/pexels-photo-17795207/free-photo-of-turtle-on-a-tropical-reef.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 12,
                    ), // Spacing between image and text
                    // Doctor's Details (Name, Specialty)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Doctor's Name
                          Text(
                            hospital[index]['name'] ?? "",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),

                          // Specialty
                          Text(
                            hospital[index]['specialty'],
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 5,),

                          Row(
                            children: [
                              Icon(Icons.location_on_outlined),
                              SizedBox(height: 2),
                              Text(
                                hospital[index]['place'] ?? "",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Rating & Button Column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Rating Row (Star Icon + Rating Value)
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${hospital[index]['rating'].toString()}/5 rating",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),

                        // "Book Now" Button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Hospitalpage(
                                  reviews: hospital[index]['rating'].toString(),
                                  hospitalName: hospital[index]['name'] ?? "",
                                  specialty: hospital[index]['specialty'] as String,
                                  about: "About information not available", // Placeholder for missing data
                                  imagePath: hospital[index]['image'],
                                  rating: hospital[index]['rating'].toString(),
                                  place: hospital[index]['place'] ?? "",
                                ),
                              ),
                            );

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          child: Text(
                            "view",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

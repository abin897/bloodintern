import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../registration/donerlist.dart';


class NotificationScreen extends StatefulWidget {
  final List<String> notifications;

  const NotificationScreen({super.key, required this.notifications});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late List<String> localNotifications;
  Set<int> selectedIndexes = {};

  @override
  void initState() {
    super.initState();
    localNotifications = List.from(widget.notifications); // Make a local copy
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

        title: Center(
          child: Text(
            "INBOX",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {              if (selectedIndexes.isNotEmpty) {
                // Delete only selected items
                localNotifications = [
                  for (int i = 0; i < localNotifications.length; i++)
                    if (!selectedIndexes.contains(i)) localNotifications[i]
                ];
                selectedIndexes.clear();
              } else {
                // Delete all
                localNotifications.clear();
              }

              });
            },
            icon: const Icon(Icons.delete, color: Colors.white),
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
        child: localNotifications.isEmpty
            ? Center(
          child: Text(
            "No notifications available",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
        )
            : ListView.separated(
          itemCount: localNotifications.length,
          separatorBuilder: (context, index) =>
          const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                tileColor: Colors.white,
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.notifications_active,
                      color: Colors.blue, size: 24),
                ),
                title: Text(
                  localNotifications[index],
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),

                onTap: () {
                  // Navigate to DonorListPage

                },
              ),
            );
          },
        ),
      ),
    );
  }
}

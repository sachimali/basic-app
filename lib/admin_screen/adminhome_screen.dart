import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../user_screens/signin_screen.dart';
import 'admincomplaint_screen.dart';

// ignore: use_key_in_widget_constructors
class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaints'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SignInScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('complaints').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> complaints = snapshot.data!.docs;
          return ListView.builder(
            itemCount: complaints.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(complaints[index]['title']),
                subtitle: Text(complaints[index]['description']),
                onTap: () {
                  // Navigate to the AdminComplaintScreen and pass the complaint ID as a parameter
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminComplaintScreen(
                            complaintId: complaints[index].id)),
                  );
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // Delete the complaint from Firestore
                    FirebaseFirestore.instance
                        .collection('complaints')
                        .doc(complaints[index].id)
                        .delete();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

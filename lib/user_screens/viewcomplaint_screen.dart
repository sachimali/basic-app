import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'complaintdetail_screen.dart';

class ViewComplaintsScreen extends StatelessWidget {
  const ViewComplaintsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Complaints'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('complaints')
            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final complaints = snapshot.data!.docs;

          if (complaints.isEmpty) {
            return const Center(child: Text('No complaints found'));
          }

          return ListView.builder(
            itemCount: complaints.length,
            itemBuilder: (BuildContext context, int index) {
              final complaint =
                  complaints[index].data() as Map<String, dynamic>;

              return GestureDetector(
                onTap: () {
                  // Navigate to the ComplaintDetailScreen with the complaint ID as a parameter
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ComplaintDetailScreen(
                        complaintId: complaints[index].id,
                      ),
                    ),
                  );
                },
                child: Card(
                  child: ListTile(
                    title: Text(complaint['title']),
                    subtitle: Text(complaint['description']),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        // Delete the complaint from Firebase Firestore
                        await FirebaseFirestore.instance
                            .collection('complaints')
                            .doc(complaints[index].id)
                            .delete();
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

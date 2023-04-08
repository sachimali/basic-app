import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterComplaintScreen extends StatefulWidget {
  const RegisterComplaintScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterComplaintScreenState createState() =>
      _RegisterComplaintScreenState();
}

class _RegisterComplaintScreenState extends State<RegisterComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  String _complaintTitle = '';
  String _complaintDescription = '';
  String _selectedDepartment = 'IT';
  // ignore: prefer_final_fields
  List<String> _departments = ['IT', 'CO', 'EJ'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register a Complaint'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter complaint title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter complaint title';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _complaintTitle = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter complaint description',
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter complaint description';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _complaintDescription = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                value: _selectedDepartment,
                items: _departments
                    .map(
                      (department) => DropdownMenuItem(
                        value: department,
                        child: Text(department),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDepartment = value.toString();
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Select department',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Save the complaint to Firebase Firestore
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      await FirebaseFirestore.instance
                          .collection('complaints')
                          .add({
                        'title': _complaintTitle,
                        'description': _complaintDescription,
                        'department': _selectedDepartment,
                        'userId': user.uid,
                        'createdAt': DateTime.now(),
                      });
                      // Show success message and go back to home screen
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Complaint submitted successfully!')),
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    } else {
                      // Show error message if user is not logged in
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Please log in to submit a complaint.')),
                      );
                    }
                  }
                },
                child: const Text('Submit Complaint'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

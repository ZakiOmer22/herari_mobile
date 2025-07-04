// lib/widgets/edit_patient_form.dart

import 'package:flutter/material.dart';

class EditPatientForm extends StatefulWidget {
  final Map<String, String> patient;
  final void Function(Map<String, String>) onSave;

  const EditPatientForm({Key? key, required this.patient, required this.onSave})
    : super(key: key);

  @override
  State<EditPatientForm> createState() => _EditPatientFormState();
}

class _EditPatientFormState extends State<EditPatientForm> {
  late TextEditingController _nameController;
  late TextEditingController _dobController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  String _gender = 'Male';
  String? _bloodType;

  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  final List<String> bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.patient['full_name']);
    _dobController = TextEditingController(
      text: widget.patient['date_of_birth'],
    );
    _phoneController = TextEditingController(
      text: widget.patient['phone_number'] ?? '',
    );
    _emailController = TextEditingController(
      text: widget.patient['email'] ?? '',
    );
    _addressController = TextEditingController(
      text: widget.patient['address'] ?? '',
    );
    _gender = widget.patient['gender'] ?? 'Male';
    _bloodType = widget.patient['blood_type'];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Patient'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _dobController,
              decoration: const InputDecoration(
                labelText: 'Date of Birth (YYYY-MM-DD)',
              ),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _gender,
              items: genderOptions
                  .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _gender = val);
              },
              decoration: const InputDecoration(labelText: 'Gender'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
              maxLines: 2,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _bloodType,
              items: bloodTypes
                  .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                  .toList(),
              onChanged: (val) {
                setState(() => _bloodType = val);
              },
              decoration: const InputDecoration(labelText: 'Blood Type'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSave({
              'full_name': _nameController.text.trim(),
              'date_of_birth': _dobController.text.trim(),
              'gender': _gender,
              'phone_number': _phoneController.text.trim(),
              'email': _emailController.text.trim(),
              'address': _addressController.text.trim(),
              'blood_type': _bloodType ?? '',
            });
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

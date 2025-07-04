// lib/widgets/edit_branch_form.dart

import 'package:flutter/material.dart';

class EditBranchForm extends StatefulWidget {
  final Map<String, String> branch;
  final void Function(Map<String, String>) onSave;

  const EditBranchForm({Key? key, required this.branch, required this.onSave})
    : super(key: key);

  @override
  State<EditBranchForm> createState() => _EditBranchFormState();
}

class _EditBranchFormState extends State<EditBranchForm> {
  late TextEditingController _nameController;
  late TextEditingController _locationController;
  String _status = 'Active';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.branch['name']);
    _locationController = TextEditingController(
      text: widget.branch['location'],
    );
    _status = widget.branch['status'] ?? 'Active';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Branch'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Branch Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _status,
              items: const [
                DropdownMenuItem(value: 'Active', child: Text('Active')),
                DropdownMenuItem(value: 'Inactive', child: Text('Inactive')),
              ],
              onChanged: (val) {
                if (val != null) setState(() => _status = val);
              },
              decoration: const InputDecoration(labelText: 'Status'),
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
              'name': _nameController.text,
              'location': _locationController.text,
              'status': _status,
            });
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

// lib/widgets/edit_department_form.dart

import 'package:flutter/material.dart';

class EditDepartmentForm extends StatefulWidget {
  final Map<String, String> department;
  final void Function(Map<String, String>) onSave;

  const EditDepartmentForm({
    Key? key,
    required this.department,
    required this.onSave,
  }) : super(key: key);

  @override
  State<EditDepartmentForm> createState() => _EditDepartmentFormState();
}

class _EditDepartmentFormState extends State<EditDepartmentForm> {
  late TextEditingController _nameController;
  late TextEditingController _floorController;
  String _status = 'Active';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.department['name']);
    _floorController = TextEditingController(text: widget.department['floor']);
    _status = widget.department['status'] ?? 'Active';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _floorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Department'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Department Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _floorController,
              decoration: const InputDecoration(labelText: 'Floor'),
              keyboardType: TextInputType.number,
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
              'name': _nameController.text.trim(),
              'floor': _floorController.text.trim(),
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

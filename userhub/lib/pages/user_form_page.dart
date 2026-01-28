import 'package:flutter/material.dart';
import 'package:userhub/models/user.dart';

class UserFormPage extends StatefulWidget {
  final User? initialUser;
  const UserFormPage({super.key, this.initialUser});
  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _ageController;
  bool get _isEdit => widget.initialUser != null;
  @override
  void initState() {
    super.initState();
    final u = widget.initialUser;
    _nameController = TextEditingController(text: u?.name ?? '');
    _ageController = TextEditingController(text: u?.age.toString() ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final name = _nameController.text.trim();
    final age = int.parse(_ageController.text.trim());
    final id = _isEdit
        ? widget.initialUser!.id
        : DateTime.now().microsecondsSinceEpoch.toString();
    final result = User(id: id, name: name, age: age);
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(_isEdit ? 'Edit User' : 'Add User')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Name is required';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Age is required';
                  final age = int.tryParse(v.trim());
                  if (age == null) return 'Age must be a number';
                  if (age < 0) return 'Age must be > 0';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: Text(_isEdit ? 'Save Changes' : 'Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

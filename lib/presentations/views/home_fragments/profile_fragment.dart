import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({super.key});

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  bool _isEditing = false;
  XFile? _image;

  // TextEditingControllers initialized without parameters
  TextEditingController _englishNameController = TextEditingController();
  TextEditingController _arabicNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _msisdnController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Initialize fields with some data
    _englishNameController.text = 'John Doe';
    _arabicNameController.text = 'جون دو';
    _emailController.text = 'john.doe@example.com';
    _msisdnController.text = '+1234567890';
    _passwordController.text = 'password123';
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = pickedFile;
        });
      }
    } catch (e) {
      // Handle errors or lack of permissions
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required bool readOnly,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        border: readOnly ? InputBorder.none : OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          GestureDetector(
            onTap: _isEditing ? _pickImage : null,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: _image != null
                  ? FileImage(File(_image!.path))
                  : AssetImage('assets/placeholder.png') as ImageProvider,
              backgroundColor: Colors.grey[200],
            ),
          ),
          SizedBox(height: 20),
          _buildTextField(
            controller: _englishNameController,
            label: 'English Name',
            readOnly: !_isEditing,
          ),
          SizedBox(height: 10),
          _buildTextField(
            controller: _arabicNameController,
            label: 'Arabic Name',
            readOnly: !_isEditing,
          ),
          SizedBox(height: 10),
          _buildTextField(
            controller: _emailController,
            label: 'Email',
            readOnly: !_isEditing,
          ),
          SizedBox(height: 10),
          _buildTextField(
            controller: _msisdnController,
            label: 'MSISDN',
            readOnly: !_isEditing,
          ),
          SizedBox(height: 10),
          _buildTextField(
            controller: _passwordController,
            label: 'Password',
            readOnly: !_isEditing,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_isEditing) {
            // TODO: Implement the submit functionality
            print('Submit profile updates');
          }
          setState(() {
            _isEditing = !_isEditing;
          });
        },
        child: Icon(_isEditing ? Icons.check : Icons.edit),
      ),
    );
  }
}

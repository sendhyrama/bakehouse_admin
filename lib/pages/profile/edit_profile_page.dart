import 'dart:io';
import 'package:bakehouse_admin/pages/navbar_state.dart';
import 'package:bakehouse_admin/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../utils/text_styles.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/custom_button.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const EditProfilePage({required this.userData, super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fullNameController =
        TextEditingController(text: widget.userData['fullname']);
    _phoneController = TextEditingController(text: widget.userData['phone']);
    _emailController = TextEditingController(text: widget.userData['email']);
  }

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<String> _uploadImage() async {
    if (_image == null) return widget.userData['profileImageUrl'] ?? '';

    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('${userId}_${DateTime.now().toIso8601String()}.jpg');

      await ref.putFile(_image!);
      return await ref.getDownloadURL();
    } catch (e) {
      print("Error mengunggah foto: $e");
      return widget.userData['profileImageUrl'] ?? '';
    }
  }

  Future<void> _updateUser(String userId, String imageUrl) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'fullname': _fullNameController.text.trim(),
      'phone': _phoneController.text.trim(),
      'email': _emailController.text.trim(),
      'profileImageUrl': imageUrl,
    });
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final userId = FirebaseAuth.instance.currentUser!.uid;

      try {
        final imageUrl = await _uploadImage();
        await _updateUser(userId, imageUrl);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil berhasil di-update.')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NavbarAdmin(initialIndex: 3),
          ),
        );
      } catch (error) {
        print("Error updating profile: $error");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengupdate profil: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profil',
          style: TextStyles.h3,
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: _image != null
                                ? FileImage(_image!)
                                : (widget.userData['profileImageUrl'] != null &&
                                        widget.userData['profileImageUrl'] !=
                                            '')
                                    ? NetworkImage(
                                        widget.userData['profileImageUrl'])
                                    : null,
                            child: _image == null &&
                                    (widget.userData['profileImageUrl'] ==
                                            null ||
                                        widget.userData['profileImageUrl'] ==
                                            '')
                                ? const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.grey,
                                  )
                                : null,
                          ),
                          TextButton(
                            onPressed: _getImage,
                            child: Text('Ganti Foto',
                                style: TextStyles.b1
                                    .copyWith(color: PrimaryColor.c8)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField("Nama", _fullNameController, 'Nama'),
                    const SizedBox(height: 16),
                    _buildTextField("Alamat Email", _emailController,
                        'Alamat Email', TextInputType.emailAddress),
                    const SizedBox(height: 16),
                    _buildTextField("Nomor Telepon", _phoneController,
                        'Nomor Telepon', TextInputType.phone),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomButton(
              text: 'Simpan',
              onPressed: _saveProfile,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, String hintText,
      [TextInputType inputType = TextInputType.text, int maxLines = 1]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyles.b1),
        const SizedBox(height: 4),
        CustomTextField(
          controller: controller,
          hintText: hintText,
          keyboardType: inputType,
          maxLines: maxLines,
        ),
      ],
    );
  }
}

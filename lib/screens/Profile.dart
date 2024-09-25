import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/model.dart';
import 'package:flutter_application_1/widgets/navbar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../widgets/profile_input.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _waterController = TextEditingController();
  final TextEditingController _stepController = TextEditingController();

  File? _profileImage;
  List<File> _selectedImages = [];

  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final box = await Hive.openBox<Profiles>('profiles');
    Profiles? profile = box.get('profile');

    if (profile != null) {
      setState(() {
        _nameController.text = profile.name;
        _usernameController.text = profile.username;
        _emailController.text = profile.email;
        _heightController.text = profile.height.toString() ; 
        _weightController.text = profile.weight.toString() ; 
        _waterController.text = profile.waterGoal.toString();
        _stepController.text = profile.stepGoal.toString() ;
        _selectedGender = profile.gender;
        if (profile.profilePicturePath != null &&
            profile.profilePicturePath!.isNotEmpty) {
          _profileImage = File(profile.profilePicturePath!);
        }
        if (profile.imagePaths != null && profile.imagePaths!.isNotEmpty) {
          _selectedImages =
              profile.imagePaths!.map((path) => File(path)).toList();
        }
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _waterController.dispose();
    _stepController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickGalleryImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }

  Widget _buildGenderDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const Expanded(
            flex: 1,
            child: Text(
              'Gender',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Expanded(
            flex: 2,
            child: DropdownButtonFormField<String>(
              value: _selectedGender != null && 
                     ['male', 'female', 'prefer not to say'].contains(_selectedGender)
                  ? _selectedGender
                  : null,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 26, 198, 195)),
                ),
              ),
              dropdownColor: Colors.black,
              items: ['male', 'female', 'prefer not to say']
                  .map((label) => DropdownMenuItem(
                        value: label,
                        child: Text(
                          label,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                  print('Selected gender: $_selectedGender');
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select gender';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showSaveDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Profile Saved'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text('Your profile has been successfully saved.')],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showWarning() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text('Do you want to make the change?')],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const CustomNavbarWidget(),
                  ),
                );
                _saveProfile();
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      Profiles profile = Profiles(
        name: _nameController.text,
        username: _usernameController.text,
        email: _emailController.text,
        height: int.tryParse(_heightController.text) ?? 0,
        weight: int.tryParse(_weightController.text) ?? 0, 
        gender: _selectedGender!,
        waterGoal: int.tryParse(_waterController.text) ?? 0, 
        stepGoal: int.tryParse(_stepController.text) ?? 0, 
        profilePicturePath: _profileImage?.path,
        imagePaths: _selectedImages.map((e) => e.path).toList(),
      );

      final box = await Hive.openBox<Profiles>('profiles');
      await box.put('profile', profile);

      _showSaveDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Account Information'),
              Tab(text: 'Post Pump Pictures'),
            ],
            labelColor: Colors.blue,
            indicatorColor: Colors.blue,
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          toolbarHeight: 100,
          foregroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CustomNavbarWidget()),
              );
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : const NetworkImage(
                                    'https://via.placeholder.com/150')
                                as ImageProvider,
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: _pickImage,
                        child: const Text(
                          'Edit profile picture',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ProfileInputs(
                        label: "Name",
                        controller: _nameController, inputType: TextInputType.name,
                      ),
                      ProfileInputs(
                        label: "Username",
                        controller: _usernameController, inputType: TextInputType.name,
                      ),
                      ProfileInputs(
                        label: "Email",
                        controller: _emailController,
                        inputType: TextInputType.emailAddress,
                      ),
                      ProfileInputs(
                        label: "Height (cm)",
                        controller: _heightController,
                        inputType: TextInputType.number,
                      ),
                      ProfileInputs(
                        label: "Weight (kg)",
                        controller: _weightController,
                        inputType: TextInputType.number,
                      ),
                      _buildGenderDropdown(),
                      ProfileInputs(
                        label: "Daily Water Goal (L)",
                        controller: _waterController,
                        inputType: TextInputType.number,
                      ),
                      ProfileInputs(
                        label: "Daily Step Goal",
                        controller: _stepController,
                        inputType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 10,
                          ),
                        ),
                        onPressed: _showWarning,
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: _selectedImages.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      if (index == _selectedImages.length) {
                        return IconButton(
                          icon: const Icon(Icons.add_a_photo, color: Colors.white),
                          onPressed: _pickGalleryImage,
                        );
                      } else {
                        return Image.file(
                          _selectedImages[index],
                          fit: BoxFit.cover,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'You can only upload up to 3 images.',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

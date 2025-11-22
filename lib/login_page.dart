import 'package:flutter/material.dart';
import 'patients_page.dart';
import 'doctors_page.dart';


// void main() {
//   runApp(const DocNavAuthApp());
// }

class DocNavAuthApp extends StatelessWidget {
  const DocNavAuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DocNav Auth',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Poppins',
      ),
      home: const AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _role = "Patient";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left side illustration placeholder
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal, Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Icon(Icons.medical_services, size: 180, color: Colors.white),
              ),
            ),
          ),
          // Right side form
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("DocNav",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal)),
                  const SizedBox(height: 20),
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.teal,
                    unselectedLabelColor: Colors.black45,
                    tabs: const [
                      Tab(text: "Login"),
                      Tab(text: "Sign Up"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _roleToggle(),
                  const SizedBox(height: 20),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _loginForm(),
                        _role == "Patient" ? _signupPatientForm() : _signupDoctorForm(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Icon(Icons.lock, size: 16, color: Colors.grey),
                  const Text("Your data is private and secure",
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _roleToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChoiceChip(
          label: const Text("Patient 👤"),
          selected: _role == "Patient",
          onSelected: (selected) {
            setState(() => _role = "Patient");
          },
        ),
        const SizedBox(width: 12),
        ChoiceChip(
          label: const Text("Doctor 🧑‍⚕️"),
          selected: _role == "Doctor",
          onSelected: (selected) {
            setState(() => _role = "Doctor");
          },
        ),
      ],
    );
  }

  Widget _loginForm() {
    return SingleChildScrollView(
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  labelText: "Email or Phone",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  labelText: "Password",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: () {}, child: const Text("Forgot Password?")),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (_role == "Patient") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const PatientsPage()),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const DoctorsPage()),
                    );
                  }
                },
                child: const Text("Login"),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => _tabController.animateTo(1),
                child: const Text("Don’t have an account? Sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signupPatientForm() {
    return SingleChildScrollView(
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              _textField(Icons.person, "Full Name"),
              const SizedBox(height: 12),
              _textField(Icons.cake, "Age"),
              const SizedBox(height: 12),
              _textField(Icons.wc, "Gender"),
              const SizedBox(height: 12),
              _textField(Icons.email, "Email or Phone"),
              const SizedBox(height: 12),
              _textField(Icons.lock, "Password", obscure: true),
              const SizedBox(height: 12),
              _textField(Icons.lock, "Confirm Password", obscure: true),
              const SizedBox(height: 12),
              _textField(Icons.location_city, "Location (City/Pin)"),
              const SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (v) {}),
                  const Text("Add Medical History"),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const PatientsPage()),
                  );
                },
                child: const Text("Create Patient Account"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signupDoctorForm() {
    return SingleChildScrollView(
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              _textField(Icons.person, "Full Name"),
              const SizedBox(height: 12),
              _textField(Icons.email, "Email or Phone"),
              const SizedBox(height: 12),
              _textField(Icons.lock, "Password", obscure: true),
              const SizedBox(height: 12),
              _textField(Icons.lock, "Confirm Password", obscure: true),
              const SizedBox(height: 12),
              _textField(Icons.badge, "Medical Registration Number"),
              const SizedBox(height: 12),
              _textField(Icons.work, "Specialty"),
              const SizedBox(height: 12),
              _textField(Icons.timeline, "Years of Experience"),
              const SizedBox(height: 12),
              _textField(Icons.local_hospital, "Clinic/Hospital Name"),
              const SizedBox(height: 12),
              _textField(Icons.location_city, "Location (City/State/Pin)"),
              const SizedBox(height: 12),
              _textField(Icons.access_time, "Availability Hours"),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.upload_file),
                label: const Text("Upload Certification"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const DoctorsPage()),
                  );
                },
                child: const Text("Create Doctor Account"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField(IconData icon, String label, {bool obscure = false}) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

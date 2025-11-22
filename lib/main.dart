// import 'dart:js_interop';

import 'package:doc_nav_demo/doctors_page.dart';
import 'package:doc_nav_demo/patients_page.dart';
import 'package:doc_nav_demo/login_page.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

void main() {
  runApp(const DocNavLandingApp());
}

class DocNavLandingApp extends StatefulWidget {
  const DocNavLandingApp({super.key});


  State<DocNavLandingApp> createState() => _DocNavLandingAppState();
}

class _DocNavLandingAppState extends State<DocNavLandingApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DocNav Landing Page',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.teal,
      ),
        // Define routes here
        home: const LandingPage(),
        // routes: {
        //   // '/': (_) => const LandingPage(),
        //   '/patients': (context) => const PatientsPage(),
        //   '/doctors': (context) => const DoctorsPage(),
        //   '/logins': (context) => const AuthPage(),
        // }

    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {    // you cannot hardcode inside widget pehle se route ka batana padhega
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _topNavBar(),
            _heroSection(context),
            _featuresSection(),
            _whySection(),
            _testimonialsSection(),
            _finalCTASection(),
            _footerSection(),
          ],
        ),
      ),
    );
  }

  Widget _topNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('DocNav',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal)),
          Row(
            children: [
              _navLink('Home'),
              _navLink('Features'),
              _navLink('Patients'),
              _navLink('Doctors'),
              _navLink('About'),
              _navLink('Contact'),
              _navLink('Login/Register'),
            ],
          )
        ],
      ),
    );
  }

  Widget _navLink(String text) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Text(text, style: const TextStyle(fontSize: 14, color: Colors.black87)),
  );

  Widget _heroSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 32),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFe0f7fa), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          // Placeholder illustration: AI brain between patient and doctor
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.person, size: 64, color: Colors.teal),
              SizedBox(width: 40),
              Icon(Icons.memory, size: 80, color: Colors.teal),
              SizedBox(width: 40),
              Icon(Icons.local_hospital, size: 64, color: Colors.teal),
            ],
          ),
          const SizedBox(height: 40),
          const Text(
            "Your AI-Powered Healthcare Navigator",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            "Find the right doctor, upload your reports, and get simple AI-powered insights with doctor-reviewed accuracy.",
            style: TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  // Navigator.pushReplacementNamed(context, '/logins');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AuthPage(),   //  goes to login/signup
                    ),
                  );
                  },
                child: const Text('For Patients'),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.teal),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  // Navigator.pushNamed(context, '/logins');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AuthPage()),
                  );
                  },
                child: const Text('For Doctors'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _featuresSection() {
    final features = [
      {'icon': Icons.calendar_month, 'title': 'Doctor Search & Booking'},
      {'icon': Icons.assignment, 'title': 'AI Medical Reports'},
      {'icon': Icons.cloud, 'title': 'Digital Health Records'},
      {'icon': Icons.laptop_mac, 'title': 'Doctor Support Tools'},
    ];

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          const Text("Key Features",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: features
                .map((f) => _featureCard(f['icon'] as IconData, f['title'] as String))
                .toList(),
          )
        ],
      ),
    );
  }

  Widget _featureCard(IconData icon, String title) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Icon(icon, size: 48, color: Colors.teal),
              const SizedBox(height: 16),
              Text(title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _whySection() {
    final highlights = [
      {'icon': Icons.visibility, 'text': 'Explainable AI (doctor in the loop)'},
      {'icon': Icons.language, 'text': 'Multilingual support (Hindi & regional)'},
      {'icon': Icons.offline_bolt, 'text': 'Offline-ready for rural India'},
    ];

    return Container(
      padding: const EdgeInsets.all(32),
      color: Colors.blue.shade50,
      child: Column(
        children: [
          const Text("Why DocNav is Different?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: highlights
                .map((h) => Expanded(
              child: Column(
                children: [
                  Icon(h['icon'] as IconData, size: 48, color: Colors.blueAccent),
                  const SizedBox(height: 12),
                  Text(h['text'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14, color: Colors.black87)),
                ],
              ),
            ))
                .toList(),
          )
        ],
      ),
    );
  }

  Widget _testimonialsSection() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          const Text("Testimonials",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("\"I understood my reports for the first time!\" — Patient"),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("\"DocNav saves me 40% paperwork time.\" — Doctor"),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _finalCTASection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 32),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Colors.teal, Colors.blueAccent]),
      ),
      child: Column(
        children: [
          const Text("DocNav bridges the gap between doctors & patients",
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {},
                child: const Text('Join as Patient'),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {},
                child: const Text('Join as Doctor'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _footerSection() {
    final links = ["About", "Privacy", "Terms", "Careers", "Contact"];

    return Container(
      color: const Color(0xFF062A3A),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            spacing: 16,
            children: links
                .map((l) => Text(l, style: const TextStyle(color: Colors.white70)))
                .toList(),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.facebook, color: Colors.white70),
              SizedBox(width: 12),
              Icon(Icons.crop_square_sharp, color: Colors.white70),
              SizedBox(width: 12),
              Icon(Icons.inbox, color: Colors.white70),
            ],
          ),
          const SizedBox(height: 16),
          const Text("DocNav — Because every second in healthcare counts.",
              style: TextStyle(color: Colors.white54)),
        ],
      ),
    );
  }
}
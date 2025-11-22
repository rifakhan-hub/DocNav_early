import 'package:flutter/material.dart';


// void main() {
//   runApp(const PatientsPage());
// }

class PatientsPage extends StatelessWidget {
  const PatientsPage({super.key});

// class DocNavApp extends StatelessWidget {
//   const DocNavApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DocNav Patient Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Roboto',
      ),
      home: const PatientDashboard(),
    );
  }
}

class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            Text(
              'DocNav',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
          ],
        ),
        actions: const [
          Icon(Icons.notifications_none, color: Colors.black54),
          SizedBox(width: 16),
          CircleAvatar(backgroundColor: Colors.teal, child: Icon(Icons.person, color: Colors.white)),
          SizedBox(width: 16),
        ],
      ),
      body: Row(
        children: [
          // Sidebar
          NavigationRail(
            backgroundColor: Colors.white,
            selectedIndex: 0,
            onDestinationSelected: (_) {},
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.dashboard), label: Text('Dashboard')),
              NavigationRailDestination(icon: Icon(Icons.search), label: Text('Search Doctor')),
              NavigationRailDestination(icon: Icon(Icons.calendar_today), label: Text('Appointments')),
              NavigationRailDestination(icon: Icon(Icons.upload_file), label: Text('Upload Reports')),
              NavigationRailDestination(icon: Icon(Icons.folder), label: Text('Health Records')),
              NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Settings')),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome card
                  _buildCard(
                    child: Text(
                      '👋 Welcome back, John!',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.teal.shade900),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Quick Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _quickAction(Icons.search, 'Find Doctor'),
                      _quickAction(Icons.calendar_today, 'Book Appointment'),
                      _quickAction(Icons.upload_file, 'Upload Report'),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Upcoming Appointment
                  _buildCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Upcoming Appointment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 8),
                        const Text('Dr. Sarah Johnson — Cardiologist'),
                        const Text('Tomorrow, 10:30 AM'),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Reschedule'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Recent Reports
                  _buildCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Recent Reports', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(height: 8),
                        ListTile(
                          title: Text('Blood Test'),
                          trailing: Text('Reviewed', style: TextStyle(color: Colors.green)),
                        ),
                        ListTile(
                          title: Text('X-Ray Chest'),
                          trailing: Text('Pending', style: TextStyle(color: Colors.orange)),
                        ),
                        ListTile(
                          title: Text('MRI Scan'),
                          trailing: Text('Reviewed', style: TextStyle(color: Colors.green)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // AI Insights
                  _buildCard(
                    child: Row(
                      children: const [
                        Icon(Icons.insights, color: Colors.teal),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text('AI Suggestion: Your Hemoglobin is low — eat iron-rich foods.',
                              style: TextStyle(fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Health Score / Trendline Placeholder
                  _buildCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Health Score Progress', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(height: 120, child: Center(child: Text('📈 Trendline Graph Placeholder'))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }

  Widget _quickAction(IconData icon, String label) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 32, color: Colors.teal),
                const SizedBox(height: 12),
                Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

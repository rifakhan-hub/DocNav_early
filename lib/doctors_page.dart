import 'package:flutter/material.dart';
// If you want charts, add fl_chart to pubspec and uncomment imports / sample usage
// import 'package:fl_chart/fl_chart.dart';

// void main() {
//   runApp(const DoctorsPage());
// }

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({super.key});

// class DocNavDoctorApp extends StatelessWidget {
//   const DocNavDoctorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DocNav — Doctor Dashboard',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF071027),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.tealAccent),
        textTheme: Typography.whiteMountainView,
      ),
      home: const DoctorDashboard(),
    );
  }
}

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _timelineSlots = [
    {'time': '08:30', 'patient': 'Mr. Patel', 'status': 'completed'},
    {'time': '09:00', 'patient': 'Ms. Rao', 'status': 'pending'},
    {'time': '09:30', 'patient': 'Mr. Kumar', 'status': 'pending'},
    {'time': '10:15', 'patient': 'Mrs. Iyer', 'status': 'canceled'},
    {'time': '11:00', 'patient': 'Mr. Mehta', 'status': 'pending'},
  ];

  final List<Map<String, String>> _recentReports = [
    {'name': 'Mr. Patel', 'test': 'CBC', 'date': '2025-09-17', 'status': 'Reviewed'},
    {'name': 'Ms. Rao', 'test': 'X-Ray Chest', 'date': '2025-09-18', 'status': 'Pending'},
    {'name': 'Mrs. Iyer', 'test': 'MRI Brain', 'date': '2025-09-16', 'status': 'Reviewed'},
  ];

  final Map<String, List<String>> _kanban = {
    'Pending Review': ['Ms. Rao — X-Ray Chest', 'Mr. Mehta — Blood Test'],
    'In Progress': ['Mr. Kumar — ECG'],
    'Reviewed': ['Mr. Patel — CBC', 'Mrs. Iyer — MRI Brain'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            // Logo
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF0EA5C9), Color(0xFF0B75A6)]),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('DocNav', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            const SizedBox(width: 16),
            const Text('Doctor Dashboard', style: TextStyle(color: Colors.white70)),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: Colors.white70)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CircleAvatar(backgroundColor: Colors.blueGrey.shade700, child: const Icon(Icons.person)),
          ),
        ],
      ),
      body: Row(
        children: [
          // LEFT SIDEBAR
          Container(
            width: 92,
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                _sidebarIcon(Icons.dashboard, 0, label: 'Dashboard'),
                _sidebarIcon(Icons.folder_shared, 1, label: 'Patient Cases'),
                _sidebarIcon(Icons.calendar_month, 2, label: 'Appointments'),
                _sidebarIcon(Icons.pending_actions, 3, label: 'Pending Reports'),
                _sidebarIcon(Icons.receipt_long, 4, label: 'Prescriptions'),
                const Spacer(),
                _sidebarIcon(Icons.settings, 5, label: 'Settings'),
                const SizedBox(height: 8),
              ],
            ),
          ),

          // MAIN CONTENT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row: Welcome + small stats
                  Row(
                    children: [
                      Expanded(child: _welcomeCard()),
                      const SizedBox(width: 16),
                      SizedBox(width: 300, child: _analyticsCard()),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Middle row: Timeline and Pending Cases + AI Assistant (AI in right column later)
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left: Timeline + Pending + Recent Reports + Kanban
                        Expanded(
                          flex: 3,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _timelineCard(),
                                const SizedBox(height: 12),
                                _pendingCasesCard(),
                                const SizedBox(height: 12),
                                _recentReportsCard(),
                                const SizedBox(height: 12),
                                _kanbanBoard(),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Right: AI Assistant sidebar
                        Container(
                          width: 320,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF081422),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text('AI Assistant', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 12),
                              TextField(
                                style: const TextStyle(color: Colors.white70),
                                decoration: InputDecoration(
                                  hintText: 'Summarize this patient\'s history',
                                  hintStyle: TextStyle(color: Colors.white38),
                                  filled: true,
                                  fillColor: Colors.white10,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                ),
                                minLines: 3,
                                maxLines: 5,
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.auto_fix_high),
                                label: const Text('Generate Prescription'),
                                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0EA5C9)),
                              ),
                              const SizedBox(height: 8),
                              OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.description_outlined),
                                label: const Text('Draft Report'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white70,
                                  side: const BorderSide(color: Colors.white12),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Divider(color: Colors.white10),
                              const SizedBox(height: 8),
                              const Text('Quick Actions', style: TextStyle(color: Colors.white70)),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  _chipAction(Icons.search, 'Teleconsult'),
                                  _chipAction(Icons.upload_file, 'Upload'),
                                  _chipAction(Icons.share, 'Share Summary'),
                                ],
                              ),
                              const Spacer(),
                              const Text('Model: DocAssist v1.2', style: TextStyle(color: Colors.white38, fontSize: 12)),
                            ],
                          ),
                        ),
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

  // ------------------- Widgets -------------------
  Widget _sidebarIcon(IconData icon, int index, {required String label}) {
    final selected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF062A3A) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: selected ? Colors.tealAccent : Colors.white70),
            const SizedBox(height: 6),
            SizedBox(
                width: 64,
                child: Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Colors.white38))),
          ],
        ),
      ),
    );
  }

  Widget _welcomeCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF08273A), Color(0xFF0B384E)]),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Good morning, Dr. Sharma — Here's your schedule.", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('You have 5 appointments today • 2 pending reports', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _timelineCard() {
    Color _statusColor(String s) {
      switch (s) {
        case 'completed':
          return Colors.greenAccent.shade400;
        case 'pending':
          return Colors.amber.shade400;
        case 'canceled':
          return Colors.redAccent.shade400;
        default:
          return Colors.grey;
      }
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF071826), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Today\'s Appointments', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          SizedBox(
            height: 96,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _timelineSlots.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final slot = _timelineSlots[index];
                return Container(
                  width: 220,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF05202B),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 48,
                        decoration: BoxDecoration(color: _statusColor(slot['status']), borderRadius: BorderRadius.circular(6)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(slot['time'], style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6),
                            Text(slot['patient'], style: const TextStyle(color: Colors.white70)),
                            const SizedBox(height: 4),
                            Text(slot['status'].toString().toUpperCase(), style: TextStyle(color: _statusColor(slot['status']))),
                          ],
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, color: Colors.white54)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _pendingCasesCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF071826), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white12)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.orange.shade800, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.pending_actions, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              Text('Pending Cases', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 6),
              Text('3 reports awaiting your review', style: TextStyle(color: Colors.white70)),
            ]),
          ),
          ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0EA5C9)), child: const Text('Review Now'))
        ],
      ),
    );
  }

  Widget _recentReportsCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF071826), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Recent Reports Reviewed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.white10),
          dataRowColor: MaterialStateProperty.all(Colors.transparent),
          columns: const [
            DataColumn(label: Text('Patient')),
            DataColumn(label: Text('Test')),
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Status')),
          ],
          rows: _recentReports
              .map((r) => DataRow(cells: [DataCell(Text(r['name']!)), DataCell(Text(r['test']!)), DataCell(Text(r['date']!)), DataCell(Text(r['status']!))]))
              .toList(),
        )
      ]),
    );
  }

  Widget _analyticsCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF0C2740), Color(0xFF082033)]),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Analytics', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          _analyticMetric('Weekly Patients', '42'),
          _analyticMetric('Avg Turnaround', '1.6d'),
          _analyticMetric('Satisfaction', '4.7 ★'),
        ])
      ]),
    );
  }

  Widget _analyticMetric(String title, String value) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(color: Colors.white60, fontSize: 12)),
      const SizedBox(height: 6),
      Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    ]);
  }

  Widget _kanbanBoard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF071826), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Cases Kanban', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        SizedBox(
          height: 300,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _kanban.keys.map((col) {
              final cards = _kanban[col]!;
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: const Color(0xFF05202B), borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(col, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView.builder(
                          itemCount: cards.length,
                          itemBuilder: (context, i) => Card(
                            color: const Color(0xFF0A2A33),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            child: ListTile(
                              dense: true,
                              title: Text(cards[i], style: const TextStyle(fontSize: 13)),
                              trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ]),
    );
  }

  Widget _chipAction(IconData icon, String label) {
    return ActionChip(
      onPressed: () {},
      avatar: Icon(icon, size: 16, color: Colors.white70),
      label: Text(label, style: const TextStyle(color: Colors.white70)),
      backgroundColor: Colors.white10,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    );
  }
}

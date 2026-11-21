import 'package:flutter/material.dart';

void main() {
  runApp(const GymManagementApp());
}

class GymManagementApp extends StatelessWidget {
  const GymManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quản Lý Tập Luyện',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D1B2A),
        primaryColor: const Color(0xFF007ACC),
        cardColor: const Color(0xFF162238),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF007ACC),
          secondary: Colors.lightBlueAccent,
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _workoutHistory = [
  {
  'date': 'Thứ Hai, 09/11/2026',
  'title': 'Buổi tập Thân trên (Upper Body)',
  'duration': '65 phút',
  'totalVolume': '2,450 kg',
  'exercises': [
  {
  'name': 'Incline Dumbbell Press',
  'setsCount': 3,
  'note': 'Tập trung siết cơ ngực trên',
  },
  {
  'name': 'Lat Pulldown',
  'setsCount': 4,
  'note': 'Kéo xuống ngang cằm',
  },
  ],
  },
  {
  'date': 'Thứ Sáu, 06/11/2026',
  'title': 'Buổi tập Chân & Bụng (Leg Day)',
  'duration': '75 phút',
  'totalVolume': '3,800 kg',
  'exercises': [
  {
  'name': 'Leg Press',
  'setsCount': 4,
  'note': 'Không khóa khớp gối',
  },
  {
  'name': 'Romanian Deadlift',
  'setsCount': 3,
  'note': 'Giữ lưng thẳng',
  },
  ],
  },
  ];

  void _addWorkoutToHistory(Map<String, dynamic> newSession) {
    setState(() {
      _workoutHistory.insert(0, newSession);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      WorkoutLogScreen(onSaveWorkout: _addWorkoutToHistory),
      const BodyMetricsScreen(),
      WorkoutHistoryScreen(
        historyList: _workoutHistory,
        onDeleteHistory: (index) {
          setState(() {
            _workoutHistory.removeAt(index);
          });
        },
      ),
      const ClassBookingScreen(),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildCommonHeader(),
            Expanded(child: screens[_currentIndex]),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF0A192F),
        selectedItemColor: Colors.lightBlueAccent,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note),
            label: 'Nhật ký',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_weight_outlined),
            label: 'Chỉ số',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Lịch sử',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available),
            label: 'Lớp học',
          ),
        ],
      ),
    );
  }

  Widget _buildCommonHeader() {
    const titles = [
      'Nhật Ký Tập Luyện',
      'Chỉ Số Cơ Thể',
      'Lịch Sử Tập Luyện',
      'Đặt Chỗ Lớp Học',
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      color: const Color(0xFF007ACC),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.fitness_center,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titles[_currentIndex],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Hội Viên: Trần Nguyễn Đức Anh (ID: HV88)',
                    style: TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
          const Icon(Icons.notifications_none, color: Colors.white),
        ],
      ),
    );
  }
}

// 1. MÀN HÌNH NHẬT KÝ TẬP LUYỆN
class WorkoutLogScreen extends StatefulWidget {
  final ValueChanged<Map<String, dynamic>> onSaveWorkout;

  const WorkoutLogScreen({super.key, required this.onSaveWorkout});

  @override
  State<WorkoutLogScreen> createState() => _WorkoutLogScreenState();
}

class _WorkoutLogScreenState extends State<WorkoutLogScreen> {
  final List<Map<String, dynamic>> _exercises = [
  {
  'name': 'Bench Press (Đẩy ngực ngang)',
  'note': 'Cơ ngực - giữ form chuẩn, hạ tạ chậm',
  'sets': [
  {'weight': '50', 'reps': '12'},
  {'weight': '60', 'reps': '10'},
  {'weight': '70', 'reps': '8'},
  ],
  },
  {
  'name': 'Barbell Squat (Gánh đùi)',
  'note': 'Cơ đùi - xuống sâu 90 độ, gồng core',
  'sets': [
  {'weight': '80', 'reps': '10'},
  {'weight': '90', 'reps': '8'},
  ],
  },
  ];

  void _showAddExerciseDialog() {
    final nameCtrl = TextEditingController();
    final noteCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF162238),
        title: const Text('Thêm bài tập mới'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Tên bài tập (VD: Deadlift)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: noteCtrl,
              decoration: const InputDecoration(
                labelText: 'Ghi chú kỹ thuật / nhóm cơ',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              final exerciseName = nameCtrl.text.trim();
              final exerciseNote = noteCtrl.text.trim();
              if (exerciseName.isNotEmpty) {
                setState(() {
                  _exercises.add({
                    'name': exerciseName,
                    'note': exerciseNote.isEmpty
                        ? 'Không có ghi chú'
                        : exerciseNote,
                    'sets': [
                      {'weight': '20', 'reps': '12'},
                    ],
                  });
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('Thêm'),
          ),
        ],
      ),
    ).whenComplete(() {
      nameCtrl.dispose();
      noteCtrl.dispose();
    });
  }

  void _saveCurrentWorkout() {
    if (_exercises.isEmpty) return;

    double totalVol = 0;
    final List<Map<String, dynamic>> summaryExercises = [];

    for (var ex in _exercises) {
    final List<Map<String, dynamic>> sets =
        List<Map<String, dynamic>>.from(ex['sets'] as List);
    for (var s in sets) {
    final double w = double.tryParse(s['weight'].toString()) ?? 0;
    final int r = int.tryParse(s['reps'].toString()) ?? 0;
    totalVol += w * r;
    }
    summaryExercises.add({
    'name': ex['name'],
    'setsCount': sets.length,
    'note': ex['note'],
    });
    }

    widget.onSaveWorkout({
    'date': 'Hôm nay, 21/11/2026',
    'title': 'Buổi tập tùy chỉnh (${_exercises.length} bài)',
    'duration': '60 phút',
    'totalVolume': '${totalVol.toStringAsFixed(0)} kg',
    'exercises': summaryExercises,
    });

    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
    content: Text('Đã lưu buổi tập vào Lịch sử!'),
    backgroundColor: Colors.green,
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF1B2A47),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BUỔI TẬP HÔM NAY',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Thứ Bảy, 21/11/2026',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.fiber_manual_record,
                        color: Colors.green,
                        size: 10,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Đang ghi',
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ..._exercises.asMap().entries.map(
                (entry) => _buildExerciseCard(entry.value, entry.key),
          ),
          OutlinedButton.icon(
            onPressed: _showAddExerciseDialog,
            icon: const Icon(Icons.add, color: Colors.lightBlueAccent),
            label: const Text(
              'Thêm bài tập mới vào nhật ký',
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.lightBlueAccent),
              minimumSize: const Size(double.infinity, 46),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: _saveCurrentWorkout,
            icon: const Icon(Icons.check_circle_outline, color: Colors.white),
            label: const Text(
              'Hoàn thành & Lưu buổi tập',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF007ACC),
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(Map<String, dynamic> exercise, int exIndex) {
    final List<Map<String, dynamic>> sets =
        List<Map<String, dynamic>>.from(exercise['sets'] as List);

    return Container(
    margin: const EdgeInsets.only(bottom: 14),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
    color: const Color(0xFF162238),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    exercise['name'].toString(),
    style: const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    ),
    ),
    const SizedBox(height: 4),
    Row(
    children: [
    const Icon(
    Icons.notes,
    size: 14,
    color: Colors.lightBlueAccent,
    ),
    const SizedBox(width: 4),
    Expanded(
    child: Text(
    exercise['note'].toString(),
    style: TextStyle(
    fontSize: 12,
    fontStyle: FontStyle.italic,
    color: Colors.grey[300],
    ),
    ),
    ),
    ],
    ),
    ],
    ),
    ),
    IconButton(
    icon: const Icon(
    Icons.close,
    color: Colors.redAccent,
    size: 20,
    ),
    onPressed: () => setState(() => _exercises.removeAt(exIndex)),
    ),
    ],
    ),
    const Divider(color: Colors.white12, height: 16),
    const Padding(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    'SET',
    style: TextStyle(
    fontSize: 11,
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    ),
    ),
    Text(
    'MỨC TẠ',
    style: TextStyle(
    fontSize: 11,
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    ),
    ),
    Text(
    'SỐ REPS',
    style: TextStyle(
    fontSize: 11,
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    ),
    ),
    Text(
    'XÓA',
    style: TextStyle(
    fontSize: 11,
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    ),
    ),
    ],
    ),
    ),
    ...sets.asMap().entries.map((setEntry) {
    final int sIndex = setEntry.key;
    final Map<String, dynamic> sItem = setEntry.value;
    return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
    color: const Color(0xFF101B2D),
    borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    'Set ${sIndex + 1}',
    style: const TextStyle(fontSize: 13, color: Colors.white70),
    ),
    _buildNumberBox(
    sItem['weight'].toString(),
    'kg',
    (val) => sItem['weight'] = val,
    ),
    _buildNumberBox(
    sItem['reps'].toString(),
    'reps',
    (val) => sItem['reps'] = val,
    ),
    IconButton(
    constraints: const BoxConstraints(),
    padding: EdgeInsets.zero,
    icon: const Icon(
    Icons.delete,
    color: Colors.redAccent,
    size: 18,
    ),
    onPressed: () {
    setState(() {
    sets.removeAt(sIndex);
    exercise['sets'] = sets;
    });
    },
    ),
    ],
    ),
    );
    }),
    Center(
    child: TextButton.icon(
    onPressed: () {
    setState(() {
    sets.add({'weight': '0', 'reps': '0'});
    exercise['sets'] = sets;
    });
    },
    icon: const Icon(
    Icons.add,
    size: 16,
    color: Colors.lightBlueAccent,
    ),
    label: const Text(
    'Thêm Set',
    style: TextStyle(color: Colors.lightBlueAccent, fontSize: 13),
    ),
    ),
    ),
    ],
    ),
    );
  }

  Widget _buildNumberBox(
      String initialVal,
      String unit,
      ValueChanged<String> onChanged,
      ) {
    return Row(
      children: [
        SizedBox(
          width: 48,
          height: 30,
          child: TextFormField(
            initialValue: initialVal,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(bottom: 12),
              filled: true,
              fillColor: const Color(0xFF1B2A47),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: onChanged,
          ),
        ),
        const SizedBox(width: 4),
        Text(unit, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

// 2. MÀN HÌNH THEO DÕI CHỈ SỐ CƠ THỂ
class BodyMetricsScreen extends StatefulWidget {
  const BodyMetricsScreen({super.key});

  @override
  State<BodyMetricsScreen> createState() => _BodyMetricsScreenState();
}

class _BodyMetricsScreenState extends State<BodyMetricsScreen> {
  final double _heightCm = 175.0;
  final List<Map<String, dynamic>> _metricsLogs = [
  {'date': '12/11/2026', 'weight': 72.5, 'bodyFat': 16.5, 'muscle': 33.8},
  {'date': '01/11/2026', 'weight': 73.2, 'bodyFat': 17.2, 'muscle': 33.5},
  {'date': '15/10/2026', 'weight': 74.0, 'bodyFat': 18.0, 'muscle': 33.1},
  ];

  void _showAddMetricsDialog() {
    final weightCtrl = TextEditingController();
    final fatCtrl = TextEditingController();
    final muscleCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF162238),
        title: const Text('Cập nhật chỉ số cơ thể'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: weightCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Cân nặng (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: fatCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Tỷ lệ mỡ (%)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: muscleCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Khối lượng cơ (kg)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              final double? w = double.tryParse(weightCtrl.text.trim());
              final double? f = double.tryParse(fatCtrl.text.trim());
              final double? m = double.tryParse(muscleCtrl.text.trim());
              if (w != null && f != null) {
                setState(() {
                  _metricsLogs.insert(0, {
                    'date': '21/11/2026 (Mới)',
                    'weight': w,
                    'bodyFat': f,
                    'muscle': m ?? 33.0,
                  });
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('Lưu chỉ số'),
          ),
        ],
      ),
    ).whenComplete(() {
      weightCtrl.dispose();
      fatCtrl.dispose();
      muscleCtrl.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    final latest = _metricsLogs.first;
    final double weightVal = (latest['weight'] as num).toDouble();
    final double bmi = weightVal / ((_heightCm / 100) * (_heightCm / 100));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildMetricCard(
                'Cân nặng',
                '${latest['weight']} kg',
                Icons.monitor_weight,
                Colors.lightBlueAccent,
              ),
              const SizedBox(width: 10),
              _buildMetricCard(
                'Tỷ lệ mỡ',
                '${latest['bodyFat']} %',
                Icons.pie_chart,
                Colors.orangeAccent,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildMetricCard(
                'Chỉ số BMI',
                bmi.toStringAsFixed(1),
                Icons.health_and_safety,
                Colors.greenAccent,
              ),
              const SizedBox(width: 10),
              _buildMetricCard(
                'Khối cơ',
                '${latest['muscle']} kg',
                Icons.fitness_center,
                Colors.purpleAccent,
              ),
            ],
          ),
          const SizedBox(height: 14),
          ElevatedButton.icon(
            onPressed: _showAddMetricsDialog,
            icon: const Icon(Icons.add_chart, color: Colors.white),
            label: const Text(
              'Ghi nhận chỉ số mới hôm nay',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF007ACC),
              minimumSize: const Size(double.infinity, 46),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'LỊCH SỬ ĐO CHỈ SỐ',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          ..._metricsLogs.map(
                (item) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF162238),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item['date'].toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    'Nặng: ${item['weight']}kg',
                    style: const TextStyle(color: Colors.lightBlueAccent),
                  ),
                  Text(
                    'Mỡ: ${item['bodyFat']}%',
                    style: const TextStyle(color: Colors.orangeAccent),
                  ),
                  Text(
                    'Cơ: ${item['muscle']}kg',
                    style: const TextStyle(color: Colors.greenAccent),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF162238),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Icon(icon, color: color, size: 18),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 3. MÀN HÌNH QUẢN LÝ LỊCH SỬ TẬP LUYỆN
class WorkoutHistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> historyList;
  final ValueChanged<int> onDeleteHistory;

  const WorkoutHistoryScreen({
    super.key,
    required this.historyList,
    required this.onDeleteHistory,
  });

  @override
  Widget build(BuildContext context) {
    if (historyList.isEmpty) {
      return const Center(
        child: Text(
          'Chưa có lịch sử tập luyện nào.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: historyList.length,
      itemBuilder: (context, index) {
        final session = historyList[index];
        final List<Map<String, dynamic>> exercises =
            List<Map<String, dynamic>>.from(session['exercises'] as List);

        return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
        color: const Color(0xFF162238),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.25)),
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text(
        session['date'].toString(),
        style: const TextStyle(
        fontSize: 12,
        color: Colors.lightBlueAccent,
        fontWeight: FontWeight.bold,
        ),
        ),
        IconButton(
        constraints: const BoxConstraints(),
        padding: EdgeInsets.zero,
        icon: const Icon(
        Icons.delete_outline,
        color: Colors.redAccent,
        size: 20,
        ),
        onPressed: () => onDeleteHistory(index),
        ),
        ],
        ),
        const SizedBox(height: 4),
        Text(
        session['title'].toString(),
        style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        ),
        ),
        const SizedBox(height: 8),
        Row(
        children: [
        _buildBadge(Icons.timer, session['duration'].toString()),
        const SizedBox(width: 10),
        _buildBadge(
        Icons.fitness_center,
        'Tổng tạ: ${session['totalVolume']}',
        ),
        ],
        ),
        const Divider(color: Colors.white12, height: 18),
        ...exercises.map(
        (ex) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Expanded(
        child: Text(
        '• ${ex['name']} (${ex['note']})',
        style: const TextStyle(
        fontSize: 13,
        color: Colors.white70,
        ),
        ),
        ),
        Text(
        '${ex['setsCount']} sets',
        style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
        ),
        ),
        ],
        ),
        ),
        ),
        ],
        ),
        );
      },
    );
  }

  Widget _buildBadge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF101B2D),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon, size: 13, color: Colors.grey),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

// 4. MÀN HÌNH ĐẶT CHỖ LỚP HỌC
class ClassBookingScreen extends StatefulWidget {
  const ClassBookingScreen({super.key});

  @override
  State<ClassBookingScreen> createState() => _ClassBookingScreenState();
}

class _ClassBookingScreenState extends State<ClassBookingScreen> {
  String _searchQuery = '';
  bool _onlyBooked = false;

  final List<Map<String, dynamic>> _classes = [
  {
  'id': 'CLS01',
  'name': 'Yoga Phục Hồi & Giãn Cơ',
  'trainer': 'HLV Lan Anh',
  'time': '17:30 - 18:30 | Hôm nay',
  'room': 'Phòng Studio A',
  'slots': '14/20',
  'isBooked': true,
  },
  {
  'id': 'CLS02',
  'name': 'HIIT Đốt Mỡ Toàn Thân',
  'trainer': 'HLV Hoàng Nam',
  'time': '18:45 - 19:45 | Hôm nay',
  'room': 'Khu vực Functional',
  'slots': '18/20',
  'isBooked': true,
  },
  {
  'id': 'CLS03',
  'name': 'Boxing & Kickfit Cơ Bản',
  'trainer': 'HLV Minh Tuấn',
  'time': '08:00 - 09:00 | Ngày mai',
  'room': 'Sàn Boxing',
  'slots': '9/15',
  'isBooked': false,
  },
  {
  'id': 'CLS04',
  'name': 'Cycling - Đạp Xe Nhịp Điệu',
  'trainer': 'HLV Thu Hà',
  'time': '17:00 - 18:00 | Ngày mai',
  'room': 'Phòng Cycling',
  'slots': '12/25',
  'isBooked': false,
  },
  ];

  void _confirmCancelBooking(Map<String, dynamic> classItem) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF162238),
        title: const Text('Xác nhận hủy đặt chỗ'),
        content: Text(
          'Bạn có chắc chắn muốn hủy chỗ lớp "${classItem['name']}" lúc ${classItem['time']} không?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Quay lại'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () {
              setState(() {
                classItem['isBooked'] = false;
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Đã hủy đặt chỗ lớp ${classItem['name']}'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            child: const Text(
              'Hủy chỗ',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredClasses = _classes.where((c) {
      final name = c['name'].toString();
      final trainer = c['trainer'].toString();
      final isBooked = c['isBooked'] == true;

      final matchesSearch =
          name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              trainer.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter = !_onlyBooked || isBooked;
      return matchesSearch && matchesFilter;
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
          child: Column(
            children: [
              TextField(
                onChanged: (val) => setState(() => _searchQuery = val),
                decoration: InputDecoration(
                  hintText: 'Tra cứu tên lớp học hoặc HLV...',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.lightBlueAccent,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF162238),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  FilterChip(
                    label: const Text('Tất cả lớp'),
                    selected: !_onlyBooked,
                    onSelected: (_) => setState(() => _onlyBooked = false),
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Lớp đã đặt chỗ'),
                    selected: _onlyBooked,
                    onSelected: (_) => setState(() => _onlyBooked = true),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: filteredClasses.isEmpty
              ? const Center(
            child: Text(
              'Không tìm thấy lớp học phù hợp.',
              style: TextStyle(color: Colors.grey),
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: filteredClasses.length,
            itemBuilder: (context, index) {
              final item = filteredClasses[index];
              final String className = item['name'].toString();
              final String trainer = item['trainer'].toString();
              final String room = item['room'].toString();
              final String time = item['time'].toString();
              final String slots = item['slots'].toString();
              final bool isBooked = item['isBooked'] == true;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF162238),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isBooked
                        ? Colors.green.withValues(alpha: 0.5)
                        : Colors.blue.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            className,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isBooked
                                ? Colors.green.withValues(alpha: 0.2)
                                : Colors.blue.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            isBooked
                                ? 'Đã đặt chỗ'
                                : 'Còn trống ($slots)',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isBooked
                                  ? Colors.greenAccent
                                  : Colors.lightBlueAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$trainer  •  $room',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: isBooked
                          ? OutlinedButton.icon(
                        onPressed: () =>
                            _confirmCancelBooking(item),
                        icon: const Icon(
                          Icons.cancel_outlined,
                          color: Colors.redAccent,
                          size: 18,
                        ),
                        label: const Text(
                          'Hủy đặt chỗ',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Colors.redAccent,
                          ),
                        ),
                      )
                          : ElevatedButton.icon(
                        onPressed: () {
                          setState(() => item['isBooked'] = true);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            SnackBar(
                              content: Text(
                                'Đặt chỗ thành công: $className',
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 18,
                        ),
                        label: const Text(
                          'Đặt chỗ ngay',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF007ACC),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
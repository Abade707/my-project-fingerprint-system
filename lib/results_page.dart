import 'package:flutter/material.dart';
import 'database_helper.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  ResultsPageState createState() => ResultsPageState();
}

class ResultsPageState extends State<ResultsPage> {
  List<Map<String, dynamic>> results = [];

  @override
  void initState() {
    super.initState();
    _loadResults(); // تحميل النتائج عند بداية الشاشة
  }

  void _loadResults() async {
    List<Map<String, dynamic>> resultList =
        await DatabaseHelper().getVoteResults();
    setState(() {
      results = resultList; // تحديث النتائج في واجهة المستخدم
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نتائج التصويت'),
        backgroundColor: Colors.blue,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.grey[200],
          child: SingleChildScrollView(
            // السماح بالتمرير عند تجاوز المحتوى للحدود
            scrollDirection: Axis.horizontal, // لتجنب تجاوز العرض للحدود
            child: Center(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.resolveWith(
                        (states) => Colors.blue.shade100),
                    columns: const [
                      DataColumn(
                        label: Text(
                          'اسم المرشح',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'اسم الحزب',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'عدد الأصوات',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                    rows: results
                        .map(
                          (result) => DataRow(
                            cells: [
                              DataCell(
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(result['name']),
                                ),
                              ),
                              DataCell(
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(result['party'] ?? 'غير محدد'),
                                ),
                              ),
                              DataCell(
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(result['vote_count'].toString()),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                    border: TableBorder.all(
                      color: Colors.blueAccent,
                      width: 1,
                    ),
                    dataRowColor: WidgetStateProperty.resolveWith(
                        (states) => Colors.grey.shade50),
                    headingTextStyle: const TextStyle(
                      color: Colors.black87,
                    ),
                    dataTextStyle: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

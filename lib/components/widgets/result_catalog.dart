import 'package:cgpa_calculator_/components/widgets/gpa_card.dart';
import 'package:cgpa_calculator_/models/semester_model.dart';
import 'package:flutter/Material.dart';

class ResultCatalog extends StatelessWidget {
  final List<Semester>? semesterCatalog;
  const ResultCatalog({
    super.key,
    this.semesterCatalog,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(semesterCatalog!.length, (index) {
        Semester currentSemester = semesterCatalog![index];
        return GpaCard(
          semester: currentSemester,
        );
      }),
    );
  }
}

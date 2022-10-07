import 'package:cgpa_calculator_/components/widgets/gpa_card.dart';
import 'package:flutter/Material.dart';

import '../../models/course_model.dart';

class ResultCatalog extends StatelessWidget {
  final List<Course>? resultCatalog;
  const ResultCatalog({
    super.key,
    this.resultCatalog,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(resultCatalog!.length, (index) {
        Course currentCourse = resultCatalog![index];
        return GpaCard(
          course: currentCourse,
        );
      }),
    );
  }
}

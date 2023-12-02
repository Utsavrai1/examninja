class ExamModel {
  String examId;
  String subject;
  String marks;
  String teacherId;
  String duration;
  String title;
  DateTime endDate;
  String teacherName;
  bool isLive;

  ExamModel({
    required this.examId,
    required this.subject,
    required this.marks,
    required this.teacherId,
    required this.duration,
    required this.title,
    required this.endDate,
    required this.teacherName,
    required this.isLive,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      examId: json['exam_id'].toString(),
      subject: json['subject'].toString(),
      marks: json['marks'].toString(),
      teacherId: json['teacher_id'].toString(),
      duration: json['duration'].toString(),
      title: json['title'].toString(),
      endDate: DateTime.parse(json['end_date']),
      teacherName: json['name'].toString(),
      isLive: json['is_live'],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  final String id;
  final String studentId;
  final String certificateType;
  final String title;
  final String description;
  final String status;
  final String? reason;
  final DateTime requestedAt;
  final DateTime? updatedAt;
  final String? reviewedBy;
  final DateTime? reviewedAt;
  final String? certificateId;

  RequestModel({
    required this.id,
    required this.studentId,
    required this.certificateType,
    required this.title,
    required this.description,
    required this.status,
    this.reason,
    required this.requestedAt,
    this.updatedAt,
    this.reviewedBy,
    this.reviewedAt,
    this.certificateId,
  });

  factory RequestModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return RequestModel(
      id: snapshot.id,
      studentId: data?['studentId'] ?? '',
      certificateType: data?['certificateType'] ?? '',
      title: data?['title'] ?? '',
      description: data?['description'] ?? '',
      status: data?['status'] ?? 'pending',
      reason: data?['reason'],
      requestedAt: (data?['requestedAt'] as Timestamp).toDate(),
      updatedAt: data?['updatedAt'] != null
          ? (data?['updatedAt'] as Timestamp).toDate()
          : null,
      reviewedBy: data?['reviewedBy'],
      reviewedAt: data?['reviewedAt'] != null
          ? (data?['reviewedAt'] as Timestamp).toDate()
          : null,
      certificateId: data?['certificateId'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id.isNotEmpty) 'id': id,
      'studentId': studentId,
      'certificateType': certificateType,
      'title': title,
      'description': description,
      'status': status,
      'reason': reason,
      'requestedAt': requestedAt,
      'updatedAt': updatedAt,
      'reviewedBy': reviewedBy,
      'reviewedAt': reviewedAt,
      'certificateId': certificateId,
    };
  }
}

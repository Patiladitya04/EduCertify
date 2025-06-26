import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/widgets.dart' as pw;

class CertificateModel {
  final String id;
  final String studentId;
  final String certificateType;
  final String title;
  final String description;
  final String? imageUrl;
  final String? qrCodeUrl;
  final DateTime issueDate;
  final DateTime? expiryDate;
  final String status;
  final String? issuedBy;
  final String? department;
  final String? batch;
  final DateTime createdAt;
  final DateTime? updatedAt;

  CertificateModel({
    required this.id,
    required this.studentId,
    required this.certificateType,
    required this.title,
    required this.description,
    this.imageUrl,
    this.qrCodeUrl,
    required this.issueDate,
    this.expiryDate,
    required this.status,
    this.issuedBy,
    this.department,
    this.batch,
    required this.createdAt,
    this.updatedAt,
  });

  factory CertificateModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return CertificateModel(
      id: snapshot.id,
      studentId: data?['studentId'] ?? '',
      certificateType: data?['certificateType'] ?? '',
      title: data?['title'] ?? '',
      description: data?['description'] ?? '',
      imageUrl: data?['imageUrl'],
      qrCodeUrl: data?['qrCodeUrl'],
      issueDate: (data?['issueDate'] as Timestamp).toDate(),
      expiryDate: data?['expiryDate'] != null
          ? (data?['expiryDate'] as Timestamp).toDate()
          : null,
      status: data?['status'] ?? 'pending',
      issuedBy: data?['issuedBy'],
      department: data?['department'],
      batch: data?['batch'],
      createdAt: (data?['createdAt'] as Timestamp).toDate(),
      updatedAt: data?['updatedAt'] != null
          ? (data?['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id.isNotEmpty) 'id': id,
      'studentId': studentId,
      'certificateType': certificateType,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'qrCodeUrl': qrCodeUrl,
      'issueDate': issueDate,
      'expiryDate': expiryDate,
      'status': status,
      'issuedBy': issuedBy,
      'department': department,
      'batch': batch,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Generate PDF content for the certificate
  pw.Widget generatePDFContent() {
    return pw.Container(
      padding: const pw.EdgeInsets.all(32),
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(description),
          pw.SizedBox(height: 20),
          pw.Text(
            'Issued to: Student ID $studentId',
            style: pw.TextStyle(fontSize: 16),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            'Issue Date: ${issueDate.toLocal().toString().split(' ')[0]}',
            style: pw.TextStyle(fontSize: 16),
          ),
          if (expiryDate != null)
            pw.Text(
              'Expiry Date: ${expiryDate!.toLocal().toString().split(' ')[0]}',
              style: pw.TextStyle(fontSize: 16),
            ),
          pw.SizedBox(height: 20),
          pw.Text(
            'Status: $status',
            style: pw.TextStyle(
              fontSize: 16,
              color: status == 'approved'
                  ? pw.PdfColors.green
                  : status == 'rejected'
                      ? pw.PdfColors.red
                      : pw.PdfColors.orange,
            ),
          ),
        ],
      ),
    );
  }
}

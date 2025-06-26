import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/certificate_model.dart';

class CertificateService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Generate certificate PDF
  Future<String?> generateCertificatePDF(CertificateModel certificate) async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (context) => certificate.generatePDFContent(),
        ),
      );

      // Save PDF to Firebase Storage
      final pdfRef = _storage.ref()
          .child('certificates')
          .child('${certificate.id}.pdf');

      // Convert PDF to bytes
      final bytes = await pdf.save();

      // Upload to Firebase Storage
      await pdfRef.putData(bytes);

      // Get download URL
      final url = await pdfRef.getDownloadURL();
      return url;
    } catch (e) {
      print('Error generating PDF: $e');
      return null;
    }
  }

  // Generate QR code
  Future<String?> generateQRCode(String certificateId, String data) async {
    try {
      // TODO: Implement QR code generation
      // This will require a QR code generation library
      // For now, we'll just return a placeholder URL
      return 'https://example.com/qrcode/$certificateId';
    } catch (e) {
      print('Error generating QR code: $e');
      return null;
    }
  }

  // Validate certificate
  Future<bool> validateCertificate(String certificateId) async {
    try {
      final doc = await _firestore.collection('certificates').doc(certificateId).get();
      if (!doc.exists) return false;

      final certificate = CertificateModel.fromFirestore(doc, null);
      return certificate.status == 'approved' &&
          (certificate.expiryDate == null ||
              certificate.expiryDate!.isAfter(DateTime.now()));
    } catch (e) {
      print('Error validating certificate: $e');
      return false;
    }
  }

  // Get certificate by ID
  Future<CertificateModel?> getCertificate(String certificateId) async {
    try {
      final doc = await _firestore.collection('certificates').doc(certificateId).get();
      if (!doc.exists) return null;

      return CertificateModel.fromFirestore(doc, null);
    } catch (e) {
      print('Error getting certificate: $e');
      return null;
    }
  }

  // Get certificates by student
  Stream<List<CertificateModel>> getCertificatesByStudent(String studentId) {
    return _firestore
        .collection('certificates')
        .where('studentId', isEqualTo: studentId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => CertificateModel.fromFirestore(doc, null)).toList());
  }

  // Get certificates by type
  Stream<List<CertificateModel>> getCertificatesByType(String certificateType) {
    return _firestore
        .collection('certificates')
        .where('certificateType', isEqualTo: certificateType)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => CertificateModel.fromFirestore(doc, null)).toList());
  }

  // Get certificates by status
  Stream<List<CertificateModel>> getCertificatesByStatus(String status) {
    return _firestore
        .collection('certificates')
        .where('status', isEqualTo: status)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => CertificateModel.fromFirestore(doc, null)).toList());
  }
}

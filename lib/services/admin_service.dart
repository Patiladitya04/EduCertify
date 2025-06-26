import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/certificate_model.dart';
import '../models/request_model.dart';

class AdminService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Get all certificate requests
  Stream<List<RequestModel>> getAllRequests() {
    return _firestore
        .collection('requests')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => RequestModel.fromFirestore(doc, null)).toList());
  }

  // Get all certificates
  Stream<List<CertificateModel>> getAllCertificates() {
    return _firestore
        .collection('certificates')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => CertificateModel.fromFirestore(doc, null)).toList());
  }

  // Approve certificate request
  Future<bool> approveRequest(String requestId, String adminId) async {
    try {
      final requestRef = _firestore.collection('requests').doc(requestId);
      final requestDoc = await requestRef.get();
      if (!requestDoc.exists) return false;

      final request = RequestModel.fromFirestore(requestDoc, null);
      
      // Create certificate
      final certificate = CertificateModel(
        id: '',
        studentId: request.studentId,
        certificateType: request.certificateType,
        title: request.title,
        description: request.description,
        imageUrl: null,
        qrCodeUrl: null,
        issueDate: DateTime.now(),
        expiryDate: null,
        status: 'approved',
        issuedBy: adminId,
        department: null,
        batch: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Save certificate
      final certificateRef = await _firestore.collection('certificates').add(certificate.toFirestore());

      // Update request status
      await requestRef.update({
        'status': 'approved',
        'reviewedBy': adminId,
        'reviewedAt': DateTime.now(),
        'updatedAt': DateTime.now(),
        'certificateId': certificateRef.id,
      });

      return true;
    } catch (e) {
      print('Error approving request: $e');
      return false;
    }
  }

  // Reject certificate request
  Future<bool> rejectRequest(String requestId, String reason, String adminId) async {
    try {
      final requestRef = _firestore.collection('requests').doc(requestId);
      await requestRef.update({
        'status': 'rejected',
        'reason': reason,
        'reviewedBy': adminId,
        'reviewedAt': DateTime.now(),
        'updatedAt': DateTime.now(),
      });
      return true;
    } catch (e) {
      print('Error rejecting request: $e');
      return false;
    }
  }

  // Generate QR code for certificate
  Future<String?> generateQRCode(String certificateId, String data) async {
    try {
      final qrCodeRef = _storage.ref()
          .child('qrcodes')
          .child('$certificateId.png');

      // TODO: Implement QR code generation and upload
      // This will require a QR code generation library
      // For now, we'll just return a placeholder URL
      return 'https://example.com/qrcode/$certificateId';
    } catch (e) {
      print('Error generating QR code: $e');
      return null;
    }
  }

  // Generate certificate PDF
  Future<String?> generateCertificatePDF(CertificateModel certificate) async {
    try {
      final pdfRef = _storage.ref()
          .child('certificates')
          .child('${certificate.id}.pdf');

      // TODO: Implement PDF generation
      // This will require a PDF generation library
      // For now, we'll just return a placeholder URL
      return 'https://example.com/certificate/${certificate.id}.pdf';
    } catch (e) {
      print('Error generating PDF: $e');
      return null;
    }
  }

  // Get statistics
  Future<Map<String, dynamic>> getStatistics() async {
    try {
      final requestsSnapshot = await _firestore.collection('requests').get();
      final certificatesSnapshot = await _firestore.collection('certificates').get();

      return {
        'totalRequests': requestsSnapshot.docs.length,
        'pendingRequests': requestsSnapshot.docs.where(
          (doc) => RequestModel.fromFirestore(doc, null).status == 'pending',
        ).length,
        'approvedCertificates': certificatesSnapshot.docs.where(
          (doc) => CertificateModel.fromFirestore(doc, null).status == 'approved',
        ).length,
      };
    } catch (e) {
      print('Error getting statistics: $e');
      return {
        'totalRequests': 0,
        'pendingRequests': 0,
        'approvedCertificates': 0,
      };
    }
  }
}

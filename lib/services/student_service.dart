import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/certificate_model.dart';
import '../models/request_model.dart';

class StudentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Get all certificates for a student
  Stream<List<CertificateModel>> getCertificates(String studentId) {
    return _firestore
        .collection('certificates')
        .where('studentId', isEqualTo: studentId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => CertificateModel.fromFirestore(doc, null)).toList());
  }

  // Get all certificate requests for a student
  Stream<List<RequestModel>> getCertificateRequests(String studentId) {
    return _firestore
        .collection('requests')
        .where('studentId', isEqualTo: studentId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => RequestModel.fromFirestore(doc, null)).toList());
  }

  // Create a new certificate request
  Future<RequestModel?> createRequest({
    required String studentId,
    required String certificateType,
    required String title,
    required String description,
  }) async {
    try {
      final request = RequestModel(
        id: '',
        studentId: studentId,
        certificateType: certificateType,
        title: title,
        description: description,
        status: 'pending',
        reason: null,
        requestedAt: DateTime.now(),
        updatedAt: DateTime.now(),
        reviewedBy: null,
        reviewedAt: null,
        certificateId: null,
      );

      final docRef = await _firestore.collection('requests').add(request.toFirestore());
      return request.copyWith(id: docRef.id);
    } catch (e) {
      print('Error creating request: $e');
      return null;
    }
  }

  // Upload certificate document
  Future<String?> uploadCertificateDocument(
    String studentId,
    String certificateType,
    String fileName,
    String filePath,
  ) async {
    try {
      final ref = _storage.ref()
          .child('certificates')
          .child(studentId)
          .child('$certificateType/$fileName');

      final uploadTask = await ref.putFile(File(filePath));
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading certificate: $e');
      return null;
    }
  }

  // Download certificate
  Future<String?> downloadCertificate(String certificateId) async {
    try {
      final doc = await _firestore.collection('certificates').doc(certificateId).get();
      if (!doc.exists) return null;

      final certificate = CertificateModel.fromFirestore(doc, null);
      if (certificate.imageUrl == null) return null;

      return certificate.imageUrl;
    } catch (e) {
      print('Error downloading certificate: $e');
      return null;
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
}

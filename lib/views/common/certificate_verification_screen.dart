import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:educertify_app/core/theme/app_theme.dart';
import 'package:educertify_app/widgets/custom_button.dart';

class CertificateVerificationScreen extends ConsumerStatefulWidget {
  const CertificateVerificationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CertificateVerificationScreen> createState() => 
      _CertificateVerificationScreenState();
}

class _CertificateVerificationScreenState extends ConsumerState<CertificateVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _certificateIdController = TextEditingController();
  final _qrCodeController = TextEditingController();
  bool _isLoading = false;
  bool _isVerified = false;
  String? _verificationError;

  @override
  void dispose() {
    _certificateIdController.dispose();
    _qrCodeController.dispose();
    super.dispose();
  }

  void _verifyCertificate() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _verificationError = null;
      _isVerified = false;
    });

    try {
      // TODO: Implement certificate verification logic
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

      if (mounted) {
        setState(() {
          _isVerified = true;
          _verificationError = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _verificationError = 'Error: ${e.toString()}';
          _isVerified = false;
        });
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Certificate'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // QR Code Scanner
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.qr_code_scanner_outlined,
                          color: Theme.of(context).colorScheme.primary,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Scan QR Code',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.qr_code_outlined,
                            color: Theme.of(context).colorScheme.primary,
                            size: 120,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Open camera to scan QR code
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('QR code scanning functionality coming soon!'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.camera_alt_outlined),
                        label: const Text('Scan QR Code'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Manual Verification
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Manual Verification',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _certificateIdController,
                            decoration: InputDecoration(
                              labelText: 'Certificate ID',
                              prefixIcon: const Icon(Icons.vpn_key_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter certificate ID';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _qrCodeController,
                            decoration: InputDecoration(
                              labelText: 'QR Code URL',
                              prefixIcon: const Icon(Icons.link_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter QR code URL';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          CustomButton(
                            onPressed: _isLoading ? null : _verifyCertificate,
                            child: _isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text('Verify Certificate'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_verificationError != null) ...[
              const SizedBox(height: 24),
              Card(
                color: Theme.of(context).colorScheme.error.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _verificationError!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else if (_isVerified) ...[
              const SizedBox(height: 24),
              Card(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Certificate Verified!',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'This certificate is authentic and has been issued by EduCertify.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              onPressed: () {
                                // TODO: Download certificate
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Download functionality coming soon!'),
                                  ),
                                );
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.download_outlined, size: 18),
                                  SizedBox(width: 8),
                                  Text('Download Certificate'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomButton(
                              onPressed: () {
                                // TODO: Share certificate
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Share functionality coming soon!'),
                                  ),
                                );
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.share_outlined, size: 18),
                                  SizedBox(width: 8),
                                  Text('Share Certificate'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

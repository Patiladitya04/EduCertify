import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:educertify_app/core/theme/app_theme.dart';
import 'package:educertify_app/models/certificate_model.dart';
import 'package:educertify_app/widgets/custom_button.dart';
import 'package:educertify_app/widgets/certificate_card.dart';

class CertificateDetailsScreen extends ConsumerStatefulWidget {
  final CertificateModel certificate;
  final bool isAdmin;

  const CertificateDetailsScreen({
    Key? key,
    required this.certificate,
    this.isAdmin = false,
  }) : super(key: key);

  @override
  ConsumerState<CertificateDetailsScreen> createState() => 
      _CertificateDetailsScreenState();
}

class _CertificateDetailsScreenState extends ConsumerState<CertificateDetailsScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.certificate.title),
        actions: [
          if (widget.isAdmin) ...[
            PopupMenuButton<String>(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'edit',
                  child: const Text('Edit Certificate'),
                ),
                PopupMenuItem(
                  value: 'revoke',
                  child: Text(
                    'Revoke Certificate',
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    // TODO: Navigate to edit certificate
                    break;
                  case 'revoke':
                    _showRevokeDialog();
                    break;
                }
              },
            ),
          ],
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Certificate preview
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.verified_outlined,
                            color: Theme.of(context).colorScheme.primary,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.certificate.title,
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.certificate.description,
                                style: Theme.of(context).textTheme.bodyMedium,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(context).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            widget.certificate.status.toUpperCase(),
                            style: TextStyle(
                              color: _getStatusColor(context),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      context,
                      Icons.calendar_today_outlined,
                      'Issued Date',
                      widget.certificate.issueDate.toString(),
                    ),
                    _buildInfoRow(
                      context,
                      Icons.timelapse_outlined,
                      'Expiry Date',
                      widget.certificate.expiryDate.toString(),
                    ),
                    _buildInfoRow(
                      context,
                      Icons.person_outline_rounded,
                      'Issued To',
                      widget.certificate.studentId,
                    ),
                    _buildInfoRow(
                      context,
                      Icons.school_outlined,
                      'Department',
                      widget.certificate.department,
                    ),
                    _buildInfoRow(
                      context,
                      Icons.group_outlined,
                      'Batch',
                      widget.certificate.batch,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onPressed: () {
                              // TODO: Download certificate
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.download_outlined, size: 18),
                                SizedBox(width: 8),
                                Text('Download'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomButton(
                            onPressed: () {
                              // TODO: Share certificate
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.share_outlined, size: 18),
                                SizedBox(width: 8),
                                Text('Share'),
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
            const SizedBox(height: 24),
            // Certificate verification
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
                          'Certificate Verification',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Scan this QR code to verify the authenticity of this certificate.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.link_outlined, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'https://educertify.com/verify/${widget.certificate.id}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (widget.isAdmin) ...[
              const SizedBox(height: 24),
              // Admin actions
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admin Actions',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 16),
                      _buildAdminAction(
                        context,
                        Icons.edit_outlined,
                        'Edit Details',
                        () {
                          // TODO: Navigate to edit certificate
                        },
                      ),
                      _buildAdminAction(
                        context,
                        Icons.history_outlined,
                        'View History',
                        () {
                          // TODO: View certificate history
                        },
                      ),
                      _buildAdminAction(
                        context,
                        Icons.replay_outlined,
                        'Reissue Certificate',
                        () {
                          // TODO: Reissue certificate
                        },
                      ),
                      _buildAdminAction(
                        context,
                        Icons.delete_outline_rounded,
                        'Delete Certificate',
                        () {
                          _showDeleteDialog();
                        },
                        isDanger: true,
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

  Color _getStatusColor(BuildContext context) {
    switch (widget.certificate.status.toLowerCase()) {
      case 'approved':
        return Theme.of(context).colorScheme.primary;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Theme.of(context).colorScheme.error;
      case 'revoked':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdminAction(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap, {
    bool isDanger = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(
          icon,
          size: 20,
          color: isDanger ? Colors.white : null,
        ),
        label: Text(
          label,
          style: TextStyle(
            color: isDanger ? Colors.white : null,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isDanger ? Theme.of(context).colorScheme.error : null,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  void _showRevokeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Revoke Certificate'),
        content: const Text(
          'Are you sure you want to revoke this certificate? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement revoke certificate
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Revoke'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Certificate'),
        content: const Text(
          'Are you sure you want to delete this certificate? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement delete certificate
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

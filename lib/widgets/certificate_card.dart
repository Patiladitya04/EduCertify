import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CertificateCard extends StatelessWidget {
  final String title;
  final String description;
  final String status;
  final DateTime issueDate;
  final DateTime? expiryDate;
  final String? imageUrl;
  final VoidCallback? onTap;
  final VoidCallback? onDownload;
  final VoidCallback? onShare;

  const CertificateCard({
    Key? key,
    required this.title,
    required this.description,
    required this.status,
    required this.issueDate,
    this.expiryDate,
    this.imageUrl,
    this.onTap,
    this.onDownload,
    this.onShare,
  }) : super(key: key);

  Color _getStatusColor(BuildContext context) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Theme.of(context).colorScheme.primary;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Theme.of(context).colorScheme.error;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (imageUrl != null)
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  else
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.verified_outlined,
                        color: Theme.of(context).colorScheme.primary,
                        size: 24,
                      ),
                    ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
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
                      status.toUpperCase(),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: _getStatusColor(context),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildInfoChip(
                    context,
                    icon: Icons.calendar_today_outlined,
                    text: 'Issued: ${dateFormat.format(issueDate)}',
                  ),
                  const SizedBox(width: 12),
                  if (expiryDate != null)
                    _buildInfoChip(
                      context,
                      icon: Icons.timelapse_outlined,
                      text: 'Expires: ${dateFormat.format(expiryDate!)}',
                    ),
                ],
              ),
              if (onDownload != null || onShare != null) ...{
                const SizedBox(height: 16),
                Row(
                  children: [
                    if (onDownload != null) ...{
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onDownload,
                          icon: const Icon(Icons.download_rounded, size: 20),
                          label: const Text('Download'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    },
                    if (onShare != null) ...{
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onShare,
                          icon: const Icon(Icons.share_outlined, size: 20),
                          label: const Text('Share'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    },
                  ],
                ),
              },
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(
    BuildContext context, {
    required IconData icon,
    required String text,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.7),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.9),
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

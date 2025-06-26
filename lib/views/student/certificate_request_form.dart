import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:educertify_app/core/theme/app_theme.dart';
import 'package:educertify_app/widgets/custom_text_field.dart';
import 'package:educertify_app/widgets/custom_button.dart';

class CertificateRequestForm extends ConsumerStatefulWidget {
  const CertificateRequestForm({Key? key}) : super(key: key);

  @override
  ConsumerState<CertificateRequestForm> createState() => 
      _CertificateRequestFormState();
}

class _CertificateRequestFormState extends ConsumerState<CertificateRequestForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedType = 'Course Completion';
  String _selectedDepartment = 'Computer Science';
  String _selectedBatch = '2021-2025';
  bool _isLoading = false;

  final _certificateTypes = [
    'Course Completion',
    'Workshop Participation',
    'Project Completion',
    'Achievement',
    'Other',
  ];

  final _departments = [
    'Computer Science',
    'Electronics',
    'Mechanical',
    'Civil',
    'Biotechnology',
    'Chemical',
  ];

  final _batches = [
    '2020-2024',
    '2021-2025',
    '2022-2026',
    '2023-2027',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitRequest() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // TODO: Implement certificate request logic
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Certificate request submitted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
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
        title: const Text('Request Certificate'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Certificate Type
              Text(
                'Certificate Type',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: DropdownButtonFormField<String>(
                    value: _selectedType,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    items: _certificateTypes.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedType = value);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select certificate type';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Title
              CustomTextField(
                label: 'Certificate Title',
                hint: 'e.g., Flutter Development Course',
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter certificate title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              // Description
              CustomTextField(
                label: 'Description',
                hint: 'Enter details about the certificate',
                controller: _descriptionController,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter certificate description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              // Department
              Text(
                'Department',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: DropdownButtonFormField<String>(
                    value: _selectedDepartment,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    items: _departments.map((dept) {
                      return DropdownMenuItem(
                        value: dept,
                        child: Text(dept),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedDepartment = value);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select department';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Batch
              Text(
                'Batch',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: DropdownButtonFormField<String>(
                    value: _selectedBatch,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    items: _batches.map((batch) {
                      return DropdownMenuItem(
                        value: batch,
                        child: Text(batch),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedBatch = value);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select batch';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Supporting Documents
              Text(
                'Supporting Documents',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'No documents selected',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.upload_file_outlined),
                            onPressed: () {
                              // TODO: Implement document upload
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Document upload functionality coming soon!'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Maximum 3 documents (PDF, JPG, PNG) up to 5MB each',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Submit button
              CustomButton(
                onPressed: _isLoading ? null : _submitRequest,
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Submit Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

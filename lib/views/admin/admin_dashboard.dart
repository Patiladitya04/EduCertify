import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:educertify_app/core/theme/app_theme.dart';
import 'package:educertify_app/widgets/certificate_card.dart';
import 'package:educertify_app/widgets/custom_text_field.dart';

class AdminDashboard extends ConsumerStatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  ConsumerState<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends ConsumerState<AdminDashboard> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EduCertify Admin'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
          IconButton(
            icon: const CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(
                'https://via.placeholder.com/150',
              ),
            ),
            onPressed: () {
              // TODO: Navigate to profile
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Admin User',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'admin@educertify.com',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              context,
              'Dashboard',
              Icons.dashboard_outlined,
              isSelected: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            _buildDrawerItem(
              context,
              'Certificate Requests',
              Icons.pending_actions_outlined,
              isSelected: _selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            _buildDrawerItem(
              context,
              'Manage Certificates',
              Icons.verified_outlined,
              isSelected: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            _buildDrawerItem(
              context,
              'Manage Users',
              Icons.people_outline_rounded,
              isSelected: _selectedIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
            const Divider(),
            _buildDrawerItem(
              context,
              'Settings',
              Icons.settings_outlined,
              isSelected: _selectedIndex == 4,
              onTap: () => _onItemTapped(4),
            ),
            const Divider(),
            _buildDrawerItem(
              context,
              'Sign Out',
              Icons.logout_rounded,
              isSelected: false,
              onTap: () {
                // TODO: Sign out
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
        children: const [
          _DashboardHome(),
          _RequestsList(),
          _CertificatesList(),
          _UsersList(),
          _SettingsPage(),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    String title,
    IconData icon, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      onTap: onTap,
    );
  }
}

class _DashboardHome extends StatelessWidget {
  const _DashboardHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats overview
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildStatCard(
                context,
                'Total Certificates',
                '1,245',
                Icons.verified_outlined,
                Colors.blue,
              ),
              _buildStatCard(
                context,
                'Pending Requests',
                '24',
                Icons.pending_actions_outlined,
                Colors.orange,
              ),
              _buildStatCard(
                context,
                'Active Students',
                '856',
                Icons.people_outline_rounded,
                Colors.green,
              ),
              _buildStatCard(
                context,
                'Departments',
                '12',
                Icons.school_outlined,
                Colors.purple,
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Recent requests
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Requests',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to all requests
                },
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Card(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final status = index % 3;
                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person_outline_rounded),
                  ),
                  title: Text('Student ${index + 1}'),
                  subtitle: const Text('Certificate of Completion - Flutter Course'),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: [
                        Colors.orange.withOpacity(0.1),
                        Colors.green.withOpacity(0.1),
                        Colors.red.withOpacity(0.1),
                      ][status],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      ['Pending', 'Approved', 'Rejected'][status],
                      style: TextStyle(
                        color: [Colors.orange, Colors.green, Colors.red][status],
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onTap: () {
                    // TODO: View request details
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          // Quick actions
          Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildActionCard(
                context,
                'Issue Certificate',
                Icons.add_circle_outline,
                () {
                  // TODO: Issue new certificate
                },
              ),
              _buildActionCard(
                context,
                'Verify Certificate',
                Icons.qr_code_scanner_outlined,
                () {
                  // TODO: Verify certificate
                },
              ),
              _buildActionCard(
                context,
                'Generate Report',
                Icons.bar_chart_outlined,
                () {
                  // TODO: Generate report
                },
              ),
              _buildActionCard(
                context,
                'Bulk Upload',
                Icons.upload_file_outlined,
                () {
                  // TODO: Bulk upload
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const Spacer(),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon, {
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 28,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RequestsList extends StatelessWidget {
  const _RequestsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: TabBar(
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
              indicatorColor: Theme.of(context).colorScheme.primary,
              tabs: const [
                Tab(text: 'Pending (24)'),
                Tab(text: 'Approved (156)'),
                Tab(text: 'Rejected (12)'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildRequestList(context, 'pending'),
                _buildRequestList(context, 'approved'),
                _buildRequestList(context, 'rejected'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestList(BuildContext context, String status) {
    final statusList = List.generate(
      10,
      (index) => {
        'id': 'REQ${1000 + index}',
        'studentName': 'Student ${index + 1}',
        'course': 'Course ${index % 3 + 1}',
        'date': '2023-06-${10 + index}',
        'status': status,
      },
    );

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: statusList.length,
      itemBuilder: (context, index) {
        final request = statusList[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            leading: CircleAvatar(
              child: Text(request['studentName']!.split(' ').last[0]),
            ),
            title: Text(request['studentName']!),
            subtitle: Text('${request['course']} • ${request['date']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (status == 'pending') ...[
                  IconButton(
                    icon: const Icon(Icons.check_circle_outline_rounded, color: Colors.green),
                    onPressed: () {
                      // TODO: Approve request
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.cancel_outlined, color: Colors.red),
                    onPressed: () {
                      // TODO: Reject request
                    },
                  ),
                ],
                IconButton(
                  icon: const Icon(Icons.visibility_outlined),
                  onPressed: () {
                    // TODO: View request details
                  },
                ),
              ],
            ),
            onTap: () {
              // TODO: View request details
            },
          ),
        );
      },
    );
  }
}

class _CertificatesList extends StatelessWidget {
  const _CertificatesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomTextField(
            label: 'Search certificates...',
            hint: 'Search by title, student, or department',
            prefixIcon: const Icon(Icons.search_rounded),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: 20,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: CertificateCard(
                  title: 'Certificate #${1000 + index}',
                  description: 'Student ${index + 1} - Course ${index % 3 + 1}',
                  status: index % 3 == 0
                      ? 'Active'
                      : index % 3 == 1
                          ? 'Expired'
                          : 'Revoked',
                  issueDate: DateTime(2023, 1, 1).add(Duration(days: index * 30)),
                  expiryDate: DateTime(2024, 1, 1).add(Duration(days: index * 30)),
                  onTap: () {
                    // TODO: View certificate details
                  },
                  onDownload: () {
                    // TODO: Download certificate
                  },
                  onShare: () {
                    // TODO: Share certificate
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _UsersList extends StatelessWidget {
  const _UsersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: 'Search users...',
                  hint: 'Search by name or email',
                  prefixIcon: const Icon(Icons.search_rounded),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Add new user
                },
                icon: const Icon(Icons.add),
                label: const Text('Add User'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: 20,
            itemBuilder: (context, index) {
              final roles = ['Student', 'Admin', 'Faculty'];
              final role = roles[index % roles.length];
              final statuses = ['Active', 'Inactive', 'Suspended'];
              final status = statuses[index % statuses.length];
              
              return Card(
                margin: const EdgeInsets.only(bottom: 12.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  leading: const CircleAvatar(
                    child: Icon(Icons.person_outline_rounded),
                  ),
                  title: Text('User ${index + 1}'),
                  subtitle: Text('user${index + 1}@example.com'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          status.toUpperCase(),
                          style: TextStyle(
                            color: _getStatusColor(status),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      PopupMenuButton<String>(
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text('Edit User'),
                          ),
                          const PopupMenuItem(
                            value: 'reset',
                            child: Text('Reset Password'),
                          ),
                          PopupMenuItem(
                            value: status == 'Suspended' ? 'activate' : 'suspend',
                            child: Text(
                              status == 'Suspended' ? 'Activate User' : 'Suspend User',
                              style: TextStyle(
                                color: status == 'Suspended' ? Colors.green : Colors.orange,
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Text(
                              'Delete User',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                        onSelected: (value) {
                          // TODO: Handle user actions
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$value clicked')),
                          );
                        },
                        icon: const Icon(Icons.more_vert_rounded),
                      ),
                    ],
                  ),
                  onTap: () {
                    // TODO: View user details
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'inactive':
        return Colors.orange;
      case 'suspended':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class _SettingsPage extends StatelessWidget {
  const _SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // General Settings
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'General Settings',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _buildSettingItem(
                    context,
                    'Institution Name',
                    'EduCertify University',
                    Icons.school_outlined,
                    onTap: () {
                      // TODO: Edit institution name
                    },
                  ),
                  _buildSettingItem(
                    context,
                    'Contact Email',
                    'support@educertify.com',
                    Icons.email_outlined,
                    onTap: () {
                      // TODO: Edit contact email
                    },
                  ),
                  _buildSettingItem(
                    context,
                    'Support Phone',
                    '+1 234 567 8900',
                    Icons.phone_outlined,
                    onTap: () {
                      // TODO: Edit support phone
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Certificate Settings
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Certificate Settings',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _buildSettingItem(
                    context,
                    'Default Expiry Duration',
                    '2 years',
                    Icons.date_range_outlined,
                    onTap: () {
                      // TODO: Edit expiry duration
                    },
                  ),
                  _buildSettingItem(
                    context,
                    'QR Code Format',
                    'PDF417',
                    Icons.qr_code_outlined,
                    onTap: () {
                      // TODO: Edit QR code format
                    },
                  ),
                  _buildSettingItem(
                    context,
                    'Certificate Template',
                    'Default Template',
                    Icons.format_paint_outlined,
                    onTap: () {
                      // TODO: Edit template
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Security Settings
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Security Settings',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _buildSettingItem(
                    context,
                    'Password Policy',
                    'Enabled',
                    Icons.lock_outline_rounded,
                    onTap: () {
                      // TODO: Edit password policy
                    },
                  ),
                  _buildSettingItem(
                    context,
                    '2FA Required',
                    'Yes',
                    Icons.security_outlined,
                    onTap: () {
                      // TODO: Edit 2FA settings
                    },
                  ),
                  _buildSettingItem(
                    context,
                    'Session Timeout',
                    '30 minutes',
                    Icons.access_time_outlined,
                    onTap: () {
                      // TODO: Edit session timeout
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // System Settings
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'System Settings',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _buildSettingItem(
                    context,
                    'Backup Frequency',
                    'Daily',
                    Icons.backup_outlined,
                    onTap: () {
                      // TODO: Edit backup settings
                    },
                  ),
                  _buildSettingItem(
                    context,
                    'Storage Provider',
                    'Google Cloud Storage',
                    Icons.cloud_outlined,
                    onTap: () {
                      // TODO: Edit storage provider
                    },
                  ),
                  _buildSettingItem(
                    context,
                    'API Rate Limit',
                    '1000 requests/hour',
                    Icons.speed_outlined,
                    onTap: () {
                      // TODO: Edit rate limit
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // About
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _buildSettingItem(
                    context,
                    'Version',
                    '1.0.0',
                    Icons.info_outline_rounded,
                    onTap: null,
                  ),
                  _buildSettingItem(
                    context,
                    'Terms of Service',
                    'View Terms',
                    Icons.description_outlined,
                    onTap: () {
                      // TODO: View terms
                    },
                  ),
                  _buildSettingItem(
                    context,
                    'Privacy Policy',
                    'View Policy',
                    Icons.privacy_tip_outlined,
                    onTap: () {
                      // TODO: View privacy policy
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context,
    String title,
    String value,
    IconData icon, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      subtitle: Text(value),
      trailing: onTap != null
          ? const Icon(Icons.chevron_right_rounded)
          : null,
      onTap: onTap,
    );
  }
}

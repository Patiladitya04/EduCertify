import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:educertify_app/core/theme/app_theme.dart';
import 'package:educertify_app/widgets/certificate_card.dart';

class StudentDashboard extends ConsumerStatefulWidget {
  const StudentDashboard({Key? key}) : super(key: key);

  @override
  ConsumerState<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends ConsumerState<StudentDashboard> {
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
        title: const Text('EduCertify Student'),
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
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
        children: const [
          _DashboardHome(),
          _CertificatesList(),
          _ProfilePage(),
        ],
      ),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
              onPressed: () {
                // TODO: Navigate to request new certificate
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Request certificate functionality coming soon!'),
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_outlined),
            activeIcon: Icon(Icons.verified_rounded),
            label: 'Certificates',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
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
          // Welcome card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back,',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'John Doe',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildStatCard(
                        context,
                        'Active Certificates',
                        '12',
                        Icons.verified_outlined,
                      ),
                      const SizedBox(width: 12),
                      _buildStatCard(
                        context,
                        'Pending Requests',
                        '3',
                        Icons.pending_actions_outlined,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Recent certificates section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Certificates',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to all certificates
                },
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Sample certificate cards
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return CertificateCard(
                title: 'Certificate of Completion',
                description: 'Flutter Development Course',
                status: 'Approved',
                issueDate: DateTime(2023, 6, 15),
                expiryDate: DateTime(2024, 6, 15),
                onTap: () {
                  // TODO: View certificate details
                },
                onDownload: () {
                  // TODO: Download certificate
                },
                onShare: () {
                  // TODO: Share certificate
                },
              );
            },
          ),
          const SizedBox(height: 20),
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
                'Request Certificate',
                Icons.add_circle_outline,
                () {
                  // TODO: Request new certificate
                },
              ),
              _buildActionCard(
                context,
                'Verify Certificate',
                Icons.qr_code_scanner_outlined,
                () {
                  // TODO: Scan QR code
                },
              ),
              _buildActionCard(
                context,
                'Share Profile',
                Icons.share_outlined,
                () {
                  // TODO: Share profile
                },
              ),
              _buildActionCard(
                context,
                'Help & Support',
                Icons.help_outline_rounded,
                () {
                  // TODO: Show help
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
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
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

class _CertificatesList extends StatelessWidget {
  const _CertificatesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          title: const Text('My Certificates'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search certificates...',
                  prefixIcon: const Icon(Icons.search_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceVariant,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: CertificateCard(
                    title: 'Certificate of Completion #${index + 1}',
                    description: 'Flutter Development Course',
                    status: index % 3 == 0
                        ? 'Approved'
                        : index % 3 == 1
                            ? 'Pending'
                            : 'Rejected',
                    issueDate: DateTime(2023, 6, 15).add(Duration(days: index * 30)),
                    expiryDate: DateTime(2024, 6, 15).add(Duration(days: index * 30)),
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
              childCount: 10,
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150',
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'John Doe',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'john.doe@example.com',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () {
                    // TODO: Navigate to edit profile
                  },
                  child: const Text('Edit Profile'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Account Settings'),
          _buildListTile(
            context,
            'Personal Information',
            Icons.person_outline_rounded,
            onTap: () {
              // TODO: Navigate to personal info
            },
          ),
          _buildListTile(
            context,
            'Change Password',
            Icons.lock_outline_rounded,
            onTap: () {
              // TODO: Navigate to change password
            },
          ),
          _buildListTile(
            context,
            'Notification Settings',
            Icons.notifications_outlined,
            onTap: () {
              // TODO: Navigate to notification settings
            },
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('Support'),
          _buildListTile(
            context,
            'Help Center',
            Icons.help_outline_rounded,
            onTap: () {
              // TODO: Show help center
            },
          ),
          _buildListTile(
            context,
            'Contact Support',
            Icons.email_outlined,
            onTap: () {
              // TODO: Contact support
            },
          ),
          _buildListTile(
            context,
            'Terms & Privacy',
            Icons.privacy_tip_outlined,
            onTap: () {
              // TODO: Show terms and privacy
            },
          ),
          const SizedBox(height: 24),
          Center(
            child: TextButton.icon(
              onPressed: () {
                // TODO: Sign out
                Navigator.pushReplacementNamed(context, '/');
              },
              icon: const Icon(Icons.logout_rounded),
              label: const Text('Sign Out'),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context,
    String title,
    IconData icon, {
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ListTile(
        leading: Icon(icon, size: 24),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right_rounded, size: 24),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}

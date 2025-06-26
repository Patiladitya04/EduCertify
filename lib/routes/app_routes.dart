import 'package:flutter/material.dart';
import '../views/common/landing_page.dart';
import '../views/auth/login_screen.dart';
import '../views/student/student_dashboard.dart';
import '../views/admin/admin_dashboard.dart';
import '../views/common/certificate_details_screen.dart';
import '../views/student/certificate_request_form.dart';
import '../views/common/certificate_verification_screen.dart';

class AppRoutes {
  // Common routes
  static const String landing = '/';
  static const String certificateDetails = '/certificate/details';
  static const String certificateVerification = '/certificate/verify';
  
  // Auth routes
  static const String studentLogin = '/student/login';
  static const String adminLogin = '/admin/login';
  
  // Student routes
  static const String studentDashboard = '/student/dashboard';
  static const String studentCertificates = '/student/certificates';
  static const String studentProfile = '/student/profile';
  static const String certificateRequest = '/student/certificate/request';
  
  // Admin routes
  static const String adminDashboard = '/admin/dashboard';
  static const String adminCertificates = '/admin/certificates';
  static const String adminUsers = '/admin/users';
  static const String adminSettings = '/admin/settings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Common routes
      case landing:
        return MaterialPageRoute(builder: (_) => const LandingPage());
      case certificateDetails:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => CertificateDetailsScreen(
            certificate: args['certificate'] as CertificateModel,
            isAdmin: args['isAdmin'] as bool,
          ),
        );
      case certificateVerification:
        return MaterialPageRoute(
          builder: (_) => const CertificateVerificationScreen(),
        );
        
      // Auth routes
      case studentLogin:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(isAdmin: false),
        );
      case adminLogin:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(isAdmin: true),
        );
        
      // Student routes
      case studentDashboard:
        return MaterialPageRoute(builder: (_) => const StudentDashboard());
      case certificateRequest:
        return MaterialPageRoute(
          builder: (_) => const CertificateRequestForm(),
        );
        
      // Admin routes
      case adminDashboard:
        return MaterialPageRoute(builder: (_) => const AdminDashboard());
        
      default:
        return _errorRoute('Page not found');
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text(message)),
      ),
    );
  }
}

/// API endpoints and URL constants
class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://api.example.com';
 

  // Authentication Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String logoutEndpoint = '/auth/logout';
  static const String refreshTokenEndpoint = '/auth/refresh';

  // User Endpoints
  static const String userProfileEndpoint = '/user/profile';
  static const String updateProfileEndpoint = '/user/update';

  // Assessment Endpoints
  static const String assessmentsEndpoint = '/assessments';
  static const String healthRiskAssessmentEndpoint = '/assessments/health-risk';
  static const String fitnessAssessmentEndpoint = '/assessments/fitness';

  // Appointment Endpoints
  static const String appointmentsEndpoint = '/appointments';
  static const String bookAppointmentEndpoint = '/appointments/book';
  static const String cancelAppointmentEndpoint = '/appointments/cancel';

  // Challenge Endpoints
  static const String challengesEndpoint = '/challenges';
  static const String todaysChallengeEndpoint = '/challenges/today';

  // Workout Endpoints
  static const String workoutRoutinesEndpoint = '/workouts';
  static const String workoutDetailsEndpoint = '/workouts/details';



  // Request Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Timeout Durations
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}

import 'package:intl/intl.dart';

class AppConstants {
  // API Endpoints
  static const String apiBaseUrl = 'https://api.example.com';
  static const String productsEndpoint = '/products';
  static const String ordersEndpoint = '/orders';
  static const String userEndpoint = '/user';

  // App Information
  static const String appName = 'Bakehouse';
  static const String appVersion = '1.0.0';

  // Padding and Margins
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 32.0;

  // Durations
  static const Duration animationDuration = Duration(milliseconds: 800);
  static const Duration splashScreenDuration = Duration(seconds: 4);

  // Maximum values
  static const int maxProductQuantity = 99;

  // Default values
  static const double defaultFontSize = 14.0;

  // Error Messages
  static const String networkError =
      'Unable to connect. Please try again later.';
  static const String unknownError =
      'An unknown error occurred. Please try again.';

  // Regex Patterns
  static const String emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
  static const String phonePattern = r'^(?:[+0]9)?[0-9]{10}$';

  // Asset paths
  static const String logoPath = 'assets/images/logo-light.svg';
  static const String userPlaceholderPath = 'assets/icons/user.png';
  static const String imagePlaceholderPath = 'assets/icons/image.png';

  // Other constants
  static const String currencySymbol = 'Rp';

  // Define Date Formats
  static final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  static final DateFormat timeFormat = DateFormat('HH:mm:ss');
  static final DateFormat dateTimeFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
  
  // You can add more specific formats as needed
  static final DateFormat bornDateFormat = DateFormat('dd MMM yyyy');
}

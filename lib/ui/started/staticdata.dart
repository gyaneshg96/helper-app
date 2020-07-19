import 'dart:core';

class StartedData {
  static List<String> cities = [
    'Enter your city',
    'Bengaluru',
    'Hyderabad',
    'Delhi NCR',
    'Mumbai'
  ];

  static Map<String, List<String>> areas = {
    'Bengaluru': ['Enter your area', 'JP Nagar', 'Koramangala', 'BTM'],
    'Mumbai': ['Enter your area', 'Chembur', 'Lokhandwala', 'Powai'],
    'Enter your city': ['Enter your area']
  };

  static List<String> services = [
    'Cooking',
    'Basic Cleaning',
    'Old age Help',
    'Gardening'
  ];
}

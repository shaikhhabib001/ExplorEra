import 'dart:convert';

import 'package:http/http.dart' as http;

class EmmailServiecs {
  static Future sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    const serviceId = 'service_qrnb5fh';
    const templateId = 'template_0kk6gog';
    const userId = 'LX-m-g-vsJfrNzZqF';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    final Map<String, String> headers = {
      'origin': 'http://localhost',
      'Content-Type': 'application/json',
    };
    final body = json.encode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params': {
        'user_name': name,
        'user_email': email,
        'user_subject': subject,
        'user_message': message,
        // 'user_name': 'Muhammad Tariq',
        // 'user_email': 'tariqmj007@gmail.com',
        // 'user_subject': 'Testing email subject',
        // 'user_message':
        //     'Y',
      }
    });

    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);
  }
}

import 'package:emailjs/emailjs.dart';

Future<void> sendEmail() async {
  try {
    await EmailJS.send(
      '<YOUR_SERVICE_ID>',
      '<YOUR_TEMPLATE_ID>',
      {'name': 'yacine', 'link': 'https://pub.dev/packages/emailjs'},
      const Options(
        publicKey: '<YOUR_PUBLIC_KEY>',
        privateKey: '<YOUR_PRIVATE_KEY>',
      ),
    );
    print('SUCCESS!');
  } catch (error) {
    print(error.toString());
  }
}

import 'package:flutter/material.dart';
import '../../core/widgets/input_field.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/utils/validators.dart';
import '../../core/constants/color_scheme.dart';

class RequestQuoteScreen extends StatefulWidget {
  final String carName;

  const RequestQuoteScreen({super.key, required this.carName});

  @override
  State<RequestQuoteScreen> createState() => _RequestQuoteScreenState();
}

class _RequestQuoteScreenState extends State<RequestQuoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();

  void submitQuote() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: AppColors.surface,
          title: const Text(
            'Quote Request Sent',
            style: TextStyle(color: Colors.amber),
          ),
          content: Text(
            'Your quote request for ${widget.carName} has been sent.',
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              child: const Text('OK', style: TextStyle(color: Colors.amber)),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
      _email.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Request Quote'),
        backgroundColor: AppColors.background,
        foregroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Enter your email to request a quote for\n"${widget.carName}"',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 24),
              InputField(
                controller: _email,
                label: 'Email Address',
                keyboardType: TextInputType.emailAddress,
                validator: Validators.email,
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Submit',
                onPressed: submitQuote,
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _sent = false;

  void _sendReset() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _sent = true);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: _sent ? _buildSuccessView() : _buildFormView(),
        ),
      ),
    );
  }

  Widget _buildFormView() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Icon(Icons.lock_reset, size: 60, color: AppColors.primary),
          SizedBox(height: 16),
          Text('Reset Password', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(
            'Enter your email address and we will send you a reset link.',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          SizedBox(height: 32),
          CustomTextField(
            controller: _emailController,
            label: 'Email',
            hint: 'Enter your registered email',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: Helpers.validateEmail,
          ),
          SizedBox(height: 24),
          CustomButton(text: 'Send Reset Link', onPressed: _sendReset),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.mark_email_read, size: 80, color: AppColors.primary),
        SizedBox(height: 24),
        Text('Check Your Email', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Text(
          'We have sent a password reset link to\n${_emailController.text}',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        SizedBox(height: 32),
        CustomButton(
          text: 'Back to Login',
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}

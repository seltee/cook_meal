import 'package:cook_meal/core/layout/column_padding.dart';
import 'package:cook_meal/core/layout/form/form_double_button.dart';
import 'package:cook_meal/core/layout/form/form_input.dart';
import 'package:cook_meal/core/layout/form/form_padding.dart';
import 'package:cook_meal/features/auth/feature/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final VoidCallback openRegistration;

  const LoginScreen({super.key, required this.openRegistration});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 320,
        child: FormPadding(
          child: _LoginForm(openRegistration: openRegistration),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  final VoidCallback openRegistration;
  const _LoginForm({super.key, required this.openRegistration});

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void attemptLogin(AuthProvider provider) {
    if (_formKey.currentState!.validate()) {
      provider.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() => setState(() => {}));
    _passwordController.addListener(() => setState(() => {}));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Authentication",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          ColumnPadding(),
          ColumnPadding(),
          FormInput(textController: _emailController, label: "E-mail"),
          ColumnPadding(),
          FormInput(textController: _passwordController, label: "Password"),
          ColumnPadding(),
          ColumnPadding(),
          FormDoubleButton(
            onPressLeft: () {
              widget.openRegistration();
            },
            titleLeft: "Registration",
            onPressRight: () => attemptLogin(authProvider),
            titleRight: "Login",
          ),
        ],
      ),
    );
  }
}

import 'package:cook_meal/core/layout/column_padding.dart';
import 'package:cook_meal/core/layout/form/form_double_button.dart';
import 'package:cook_meal/core/layout/form/form_input.dart';
import 'package:cook_meal/core/layout/form/form_padding.dart';
import 'package:cook_meal/features/auth/feature/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegScreen extends StatelessWidget {
  final VoidCallback openAutentication;

  const RegScreen({super.key, required this.openAutentication});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 320,
        child: FormPadding(
          child: _RegisterForm(openAutentication: openAutentication),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  final VoidCallback openAutentication;
  const _RegisterForm({required this.openAutentication});

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void attemtRegistration(AuthProvider provider) {
    if (_formKey.currentState!.validate()) {
      provider.register(
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
              "Registration",
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
              widget.openAutentication();
            },
            titleLeft: "Login",
            onPressRight: () => attemtRegistration(authProvider),
            titleRight: "Register",
          ),
        ],
      ),
    );
  }
}

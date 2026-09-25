import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../l10n/app_localizations.dart';
import '../../models/enums.dart';
import '../../utils/app_feedback.dart';
import '../../utils/validators.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import 'auth_header.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context);

    // Phase 2: AuthRepository saves the user, blocks duplicate emails and
    // locks the chosen role permanently.
    AppFeedback.success(context, l10n.registrationDemoNote);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.register)),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    AuthHeader(
                      title: l10n.createAccount,
                      subtitle: l10n.registerSubtitle,
                    ),
                    AppTextField(
                      label: l10n.fullName,
                      controller: _name,
                      prefixIcon: Icons.person_outline,
                      textInputAction: TextInputAction.next,
                      validator: (v) => Validators.required(l10n, v),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      label: l10n.email,
                      controller: _email,
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (v) => Validators.email(l10n, v),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      label: l10n.phone,
                      controller: _phone,
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      validator: (v) => Validators.phone(l10n, v),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      label: l10n.password,
                      controller: _password,
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      textInputAction: TextInputAction.next,
                      validator: (v) => Validators.password(l10n, v),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      label: l10n.confirmPassword,
                      controller: _confirm,
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      textInputAction: TextInputAction.done,
                      validator: (v) => Validators.confirmPassword(
                        l10n,
                        v,
                        _password.text,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _RoleSelector(l10n: l10n),
                    const SizedBox(height: AppSpacing.lg),
                    AppButton(label: l10n.createAccount, onPressed: _submit),
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(l10n.haveAccount, style: theme.textTheme.bodyMedium),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(l10n.login),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Role is required and has no default, so the user must choose.
/// The note explains that it is permanent (enforced in Phase 2 storage).
class _RoleSelector extends StatelessWidget {
  const _RoleSelector({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FormField<UserRole>(
      validator: (v) => v == null ? l10n.roleRequired : null,
      builder: (state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.iAmA, style: theme.textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<UserRole>(
              emptySelectionAllowed: true,
              segments: [
                ButtonSegment(
                  value: UserRole.farmer,
                  icon: const Icon(Icons.agriculture),
                  label: Text(l10n.farmer),
                ),
                ButtonSegment(
                  value: UserRole.buyer,
                  icon: const Icon(Icons.shopping_basket_outlined),
                  label: Text(l10n.buyer),
                ),
              ],
              selected: state.value == null ? <UserRole>{} : {state.value!},
              onSelectionChanged: (s) =>
                  state.didChange(s.isEmpty ? null : s.first),
            ),
          ),
          if (state.hasError)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xs),
              child: Text(
                state.errorText!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.xs),
          Text(l10n.roleLockedNote, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
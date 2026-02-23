import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitahack_2026/core/theme/sizes.dart';
import 'package:kitahack_2026/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:kitahack_2026/features/auth/presentation/viewmodel/comple_profile_viewmodel.dart';

class CompleteProfileScreen extends ConsumerStatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  ConsumerState<CompleteProfileScreen> createState() => _RoleSelectScreenState();
}

class _RoleSelectScreenState extends ConsumerState<CompleteProfileScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final name = _nameController.text;

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your name first. ")),
      );
      return;
    }

    ref.read(completeProfileViewModelProvider.notifier).selectRole(name);
  }

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    ref.listen(completeProfileViewModelProvider, (previous, next) {
      if(!next.isLoading && next.hasError){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }

      else if (!next.isLoading && previous?.isLoading == true && !next.hasError) {
        // Just tell the AuthGate to refresh. It will automatically route you to MainWrapperUser.
        ref.invalidate(userModelProvider); 
      }
    });

    final isLoading = ref.watch(completeProfileViewModelProvider).isLoading;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Complete Your Profile",
                textAlign: TextAlign.center,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              kGap8,
              Text(
                "Let's get to know you better to keep our community safe and personalized.",
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge,
              ),
              kGap16,
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "User Name",
                  hintText: "John Smith",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(kDefaultRadius),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(
          kDefaultPadding,
          0,
          kDefaultPadding,
          50,
        ),
        child: SizedBox(
          height: 50,
          child: FilledButton(
            onPressed: _onSubmit,
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Text("Get Started"),
          ),
        ),
      ),
    );
  }
}

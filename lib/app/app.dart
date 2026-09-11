import 'package:flutter/material.dart';

import 'app_theme.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/role_selection_screen.dart';
import '../features/splash/splash_screen.dart';

class ResourceXApp extends StatefulWidget {
  const ResourceXApp({super.key});

  @override
  State<ResourceXApp> createState() => _ResourceXAppState();
}

class _ResourceXAppState extends State<ResourceXApp> {
  bool _showSplash = true;

  void _finishSplash() {
    if (!mounted) {
      return;
    }

    setState(() {
      _showSplash = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ResourceX',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: _showSplash
          ? SplashScreen(
              onFinished: _finishSplash,
            )
          : const LandingScreen(),
    );
  }
}

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void _openPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 520,
              ),
              child: Column(
                children: [
                  Container(
                    width: 82,
                    height: 82,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      Icons.autorenew_rounded,
                      size: 46,
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: 28),

                  Text(
                    'ResourceX',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.6,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Turn surplus resources into meaningful impact.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 36),

                  _FeatureCard(
                    icon: Icons.inventory_2_outlined,
                    title: 'Share what you have',
                    description:
                        'List useful surplus resources and make them discoverable.',
                    onTap: () {
                      _openPage(
                        context,
                        const FeatureDetailsScreen(
                          icon: Icons.inventory_2_outlined,
                          title: 'Share what you have',
                          description:
                              'ResourceX helps you turn unused or surplus resources into useful opportunities for people and organizations that need them.',
                          points: [
                            'Create detailed resource listings',
                            'Add availability and condition',
                            'Provide useful resource information',
                            'Reach suitable recipients',
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  _FeatureCard(
                    icon: Icons.psychology_outlined,
                    title: 'Find what is needed',
                    description:
                        'Discover needs and receive intelligent resource matches.',
                    onTap: () {
                      _openPage(
                        context,
                        const FeatureDetailsScreen(
                          icon: Icons.psychology_outlined,
                          title: 'Find what is needed',
                          description:
                              'ResourceX helps users discover available resources that can satisfy their requirements.',
                          points: [
                            'Create requirement requests',
                            'Discover suitable resources',
                            'Compare available options',
                            'Receive intelligent recommendations',
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  _FeatureCard(
                    icon: Icons.insights_outlined,
                    title: 'Measure your impact',
                    description:
                        'Track exchanges, reuse and the difference you create.',
                    onTap: () {
                      _openPage(
                        context,
                        const FeatureDetailsScreen(
                          icon: Icons.insights_outlined,
                          title: 'Measure your impact',
                          description:
                              'ResourceX lets users understand the value created through resource sharing and reuse.',
                          points: [
                            'Track successful exchanges',
                            'Monitor resource reuse',
                            'View activity history',
                            'Understand your contribution',
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 36),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _openPage(
                          context,
                          const RoleSelectionScreen(),
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_forward_rounded,
                      ),
                      label: const Text('Get Started'),
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextButton(
                    onPressed: () {
                      _openPage(
                        context,
                        const LoginScreen(),
                      );
                    },
                    child: const Text(
                      'I already have an account',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Icon(
                Icons.chevron_right_rounded,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureDetailsScreen extends StatelessWidget {
  const FeatureDetailsScreen({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.points,
  });

  final IconData icon;
  final String title;
  final String description;
  final List<String> points;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ResourceX'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Icon(
                icon,
                size: 38,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 14),

            Text(
              description,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.6,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 30),

            Text(
              'What you can do',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 16),

            ...points.map(
              (point) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle_rounded,
                        color: AppColors.success,
                        size: 22,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          point,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
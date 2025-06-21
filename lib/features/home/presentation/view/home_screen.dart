import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:technical_assessment/core/config/di.dart';
import 'package:technical_assessment/features/auth/login/data/model/user_model.dart';
import 'package:technical_assessment/features/home/presentation/view_model/dashboard_cubit.dart';
import 'package:technical_assessment/features/home/presentation/view_model/dashboard_state.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardCubit(getIt<Box<UserModel>>()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text("Employee Dashboard"),
          centerTitle: true,
        ),
        body: BlocConsumer<DashboardCubit, DashboardState>(
    listener: (context, state) {
    if (state.message != null && state.message!.isNotEmpty) {
    final isError = state.message!.toLowerCase().contains('error') ||
    state.message!.toLowerCase().contains('denied') ||
    state.message!.toLowerCase().contains('no valid');
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text(state.message!),
    backgroundColor: isError ? Colors.red : Colors.green,
    duration: const Duration(seconds: 3),
    ),
    );
    }}, listenWhen: (previous, current) => previous.message != current.message,
          builder: (context, state) {
            if (state.isLoading && state.user == null) {
              return const Center(child: CircularProgressIndicator());
            }

            final dashboardCubit = context.read<DashboardCubit>();
            final formattedTime = DateFormat('EEEE, MMM d • hh:mm a').format(state.currentTime.toLocal());

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Employee Info",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(Icons.person, color: Colors.blueAccent),
                                const SizedBox(width: 8),
                                Text("Name: ${state.user?.username ?? 'N/A'}",
                                    style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.badge, color: Colors.blueAccent),
                                const SizedBox(width: 8),
                                Text("ID: ${state.user?.id ?? 'N/A'}",
                                    style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.access_time, color: Colors.indigo),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    "Time: $formattedTime",
                                    style: const TextStyle(fontSize: 14),
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    if (state.message != null) ...[
                      Text(
                        state.message!,
                        style: TextStyle(
                          color: state.message!.toLowerCase().contains('error') ||
                              state.message!.toLowerCase().contains('denied')
                              ? Colors.red
                              : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.isCheckIn ? Colors.green : Colors.grey,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (!state.isCheckIn) {
                          dashboardCubit.checkIn();
                        }
                      },
                      icon: Icon(
                        state.isCheckIn ? Icons.check_circle : Icons.check_circle_outline,
                        color: Colors.white,
                      ),
                      label: const Text("Check-In", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        final pickedFile = await dashboardCubit.pickImage();
                        if (pickedFile != null) {
                          await dashboardCubit.handleIdExtraction(pickedFile.path);
                        }
                      },
                      icon: const Icon(Icons.upload_file, color: Colors.white),
                      label: const Text("Upload ID", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                    const SizedBox(height: 16),
                    if (state.ocrName != null && state.ocrName!.isNotEmpty) ...[
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("ID Info",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(Icons.person, color: Colors.blueAccent),
                                  const SizedBox(width: 8),
                                  Text("Name: ${state.ocrName}", style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.badge, color: Colors.blueAccent),
                                  const SizedBox(width: 8),
                                  Text("ID: ${state.ocrId ?? 'N/A'}",
                                      style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:colorist/providers/gemini.dart';
import 'package:colorist/services/gemini_chat_service.dart';
import 'package:colorist_ui/colorist_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AIChatScreen extends ConsumerWidget {
  const AIChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(geminiModelProvider);

    return model.when(
      data: (data) => MainScreen(
        sendMessage: (text) {
          ref.read(geminiChatServiceProvider).sendMessage(text);
        },
      ),
      loading: () => LoadingScreen(message: 'Initializing Gemini Model'),
      error: (err, st) => ErrorScreen(error: err),
    );
  }
}

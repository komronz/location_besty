import 'dart:convert';
import 'package:http/http.dart' as http;

// ⚠️  Paste your OpenAI API key from https://platform.openai.com/api-keys
const _apiKey = '';

const _systemPrompt = '''You are a location discovery assistant for the "Location Besty" app. '
'Help users find and learn about interesting places around the world.

When you want to suggest a specific, saveable location, add this JSON block at '
'the very END of your message (nothing after it):

```location
{"name":"Place Name","description":"Short description under 80 chars","latitude":41.2995,"longitude":69.2401}
```

Rules:
- Only include the block for real places with accurate GPS coordinates.
- Keep descriptions under 80 characters.
- Only answer questions about locations, places, and travel.
- Be warm, concise, and helpful.''';

class OpenAiService {
  static const _url = 'https://api.openai.com/v1/chat/completions';
  static const _model = 'gpt-4o-mini';

  Future<String> send(List<Map<String, dynamic>> history) async {
    final body = jsonEncode({
      'model': _model,
      'messages': [
        {'role': 'system', 'content': _systemPrompt},
        ...history,
      ],
      'temperature': 0.7,
      'max_tokens': 600,
    });

    final res = await http.post(
      Uri.parse(_url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: body,
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      return (data['choices'] as List).first['message']['content'] as String;
    }
    throw Exception('OpenAI ${res.statusCode}: ${res.body}');
  }
}

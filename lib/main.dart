import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Random Dictation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FlutterTts _flutterTts = FlutterTts();
  String _currentWord = '';
  final List<String> _usedWords = []; // List to track used words

  @override
  void initState() {
    super.initState();
    _getNextWord(); // Initialize with the first word
  }

  void _getNextWord() {
    final random = Random();
    if (_usedWords.length == words.length) {
      // Reset if all words have been used
      _usedWords.clear();
    }

    String nextWord;
    do {
      nextWord = words[random.nextInt(words.length)];
    } while (_usedWords.contains(nextWord));

    setState(() {
      _currentWord = nextWord;
      _usedWords.add(nextWord); // Add the word to used words
    });
    _speak(_currentWord);
  }

  Future<void> _speak(String word) async {
    await _flutterTts.setLanguage("zh-CN"); // Set language to Chinese
    await _flutterTts
        .setPitch(1.2); // Set pitch to a higher value for better clarity
    await _flutterTts.setSpeechRate(
        0.5); // Set a slower speech rate for better understanding
    await _flutterTts.speak(word); // Speak the word
  }

  @override
  Widget build(BuildContext context) {
    late List<String> unreadWords =
        words.where((word) => !_usedWords.contains(word)).toList();
    return Scaffold(
      appBar: AppBar(title: Text('Random Dictation')),
      body: Row(
        children: [
          // Left side: List of used words
          Expanded(
            flex: 1, // Adjust the flex to control the width of the list
            child: Container(
              color: Colors.grey[200],
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _usedWords.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            _usedWords.reversed.toList()[index],
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      },
                    ),
                  ),
                  Text('已听写数量：${_usedWords.length}')
                ],
              ),
            ),
          ),
          // Right side: Current word and button
          Expanded(
            flex:
                2, // Adjust the flex to control the width of the current word display
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_currentWord, style: TextStyle(fontSize: 24)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _getNextWord,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.record_voice_over,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ), // Right side: Current word and button
          // Right side: List of unread words
          Expanded(
            flex:
                1, // Adjust the flex to control the width of the unread words list
            child: Container(
              color: Colors.grey[200],
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: unreadWords.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            unreadWords[index],
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      },
                    ),
                  ),
                  Text('未听写数量：${unreadWords.length}')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<String> words = [
  "中断",
  "楚江",
  "至此",
  "孤单",
  "帆船",
  "饮水",
  "起初",
  "镜子",
  "未知",
  "打磨",
  "遥望",
  "银河",
  "盘子",
  "优美",
  "淡青",
  "浅绿",
  "交错",
  "岩石",
  "挺好",
  "鱼刺",
  "数不清",
  "厚实",
  "宝贵",
  "事业",
  "位于",
  "部分",
  "风景",
  "物产",
  "丰富",
  "相互",
  "各种各样",
  "成群结队",
  "游动",
  "堆积",
  "肥料",
  "祖国",
  "海滨",
  "灰色",
  "飘扬",
  "渔民",
  "遍地",
  "躺下",
  "满载",
  "靠岸",
  "亚热带",
  "初夏",
  "除了",
  "踩水",
  "整洁",
  "街道",
  "来来往往",
  "远处",
  "汽笛",
  "船队",
  "银光闪闪",
  "散发",
  "脑袋",
  "严严实实",
  "挡住",
  "视线",
  "花坛",
  "显得",
  "药材",
  "松软",
  "刮风",
  "宝库"
];

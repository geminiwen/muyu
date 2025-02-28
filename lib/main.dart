import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '木鱼',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const WoodenFishPage(),
    );
  }
}

class WoodenFishPage extends StatefulWidget {
  const WoodenFishPage({super.key});

  @override
  State<WoodenFishPage> createState() => _WoodenFishPageState();
}

class _WoodenFishPageState extends State<WoodenFishPage> with SingleTickerProviderStateMixin {
  final List<_MeritIndicator> _meritIndicators = [];
  // final AudioPlayer _audioPlayer = AudioPlayer();
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // _loadSound();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.1),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.1, end: 1.0),
        weight: 1,
      ),
    ]).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));
  }

  void _onTapWoodenFish() {
    // _audioPlayer.resume();
    _scaleController.forward(from: 0);
    setState(() {
      UniqueKey key = UniqueKey();
      _meritIndicators.add(_MeritIndicator(
        key: key,
        onComplete: () {
          setState(() {
            _meritIndicators.removeWhere((element) => element.key == key);
          });
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 100,
              child: Stack(
                children: _meritIndicators,
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: _onTapWoodenFish,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Image.asset(
                    'assets/images/muyu.png',
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    // _audioPlayer.dispose();
    super.dispose();
  }
}

class _MeritIndicator extends StatefulWidget {
  final VoidCallback onComplete;

  const _MeritIndicator({
    required Key key,
    required this.onComplete,
  }) : super(key: key);

  @override
  State<_MeritIndicator> createState() => _MeritIndicatorState();
}

class _MeritIndicatorState extends State<_MeritIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  final _textOptions = [
  "\$AMD BULLISH++", "\$NVDA BULLISH++", "\$TSLA BULLISH++", "\$QQQ BULLISH++"
  ];

  late String _text;

  @override
  void initState() {
    super.initState();
    //random text of _textOptions for _text
    _text = _textOptions[DateTime.now().millisecondsSinceEpoch % _textOptions.length];

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -1),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward().then((_) => widget.onComplete());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Text(
            _text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
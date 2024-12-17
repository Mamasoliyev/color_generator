import 'package:flutter/material.dart';

void main() {
  runApp(ColorGeneratorApp());
}

class ColorGeneratorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ranglar Generatori',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: ColorPickerScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ColorPickerScreen extends StatefulWidget {
  @override
  _ColorPickerScreenState createState() => _ColorPickerScreenState();
}

class _ColorPickerScreenState extends State<ColorPickerScreen> {
  double _alpha = 255;
  double _red = 33;
  double _green = 33;
  double _blue = 33;

  Color get currentColor =>
      Color.fromARGB(_alpha.toInt(), _red.toInt(), _green.toInt(), _blue.toInt());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ranglar Generatori'),
        centerTitle: true,
        backgroundColor: currentColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            buildColorPreview(),
            SizedBox(height: 20),
            buildSlider('Alpha', _alpha, (value) => setState(() => _alpha = value)),
            buildSlider('Red', _red, (value) => setState(() => _red = value)),
            buildSlider('Green', _green, (value) => setState(() => _green = value)),
            buildSlider('Blue', _blue, (value) => setState(() => _blue = value)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: currentColor,
        onPressed: () {
          final snackBar = SnackBar(
            content: Text(
              'Tanlangan rang: ARGB(${_alpha.toInt()}, ${_red.toInt()}, ${_green.toInt()}, ${_blue.toInt()})',
            ),
            backgroundColor: currentColor,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        label: Text('Rangni Ko\'rsat'),
        icon: Icon(Icons.color_lens),
      ),
    );
  }

  Widget buildColorPreview() {
    return Container(
      height: 200,
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [currentColor.withOpacity(0.5), currentColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: currentColor.withOpacity(0.7),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Center(
        child: Text(
          'ARGB(${_alpha.toInt()}, ${_red.toInt()}, ${_green.toInt()}, ${_blue.toInt()})',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.7),
                offset: Offset(1, 1),
                blurRadius: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSlider(String label, double value, ValueChanged<double> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ${value.toInt()}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: currentColor,
              thumbColor: currentColor,
              overlayColor: currentColor.withOpacity(0.2),
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 24),
            ),
            child: Slider(
              value: value,
              min: 0,
              max: 255,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

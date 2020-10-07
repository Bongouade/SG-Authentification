import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const N = 10;
  static const PASSWORD_LENGHT = 6;

  List<int> _numbers = Iterable<int>.generate(N).toList()..shuffle();
  String _password = "";
  int _passwordLenght = 0;

  bool _overlayTouch = false;
  int _indexLongPress = -1;

  bool get isValid => _passwordLenght == PASSWORD_LENGHT;
  bool get showBtnDelete => _passwordLenght > 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildResultPassword(),
            _buildKeyboard(isValid),
            _buildbtnValid(isValid),
          ],
        ),
      ),
    );
  }

  Widget _buildResultPassword() {
    return Column(
      children: [
        Text(
          "Saisissez votre code secret",
          style: TextStyle(fontSize: 20.0),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(PASSWORD_LENGHT, (index) {
                  return Container(
                    height: 15.0,
                    width: 15.0,
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (index < _passwordLenght)
                          ? Colors.grey
                          : Colors.grey[350],
                    ),
                  );
                }),
              ),
              _buildIconDelete(showBtnDelete),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildIconDelete(bool show) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0),
      child: GestureDetector(
        onTap: () => _reinitPassword(),
        child: show ? Icon(Icons.close) : Icon(null),
      ),
    );
  }

  Widget _buildKeyboard(bool isValidPassword) {
    List<Widget> _touchKeyboard = List.generate(N, (index) {
      return InkWell(
        onTap: !isValidPassword ? () => _addNumber(_numbers[index]) : null,
        onHighlightChanged: (bool value) => setState((){
          _overlayTouch = value;
          _indexLongPress = index;
        }),
        child: Container(
          decoration: BoxDecoration(
            color: (_overlayTouch && _indexLongPress == index)? Colors.grey[350]: Colors.grey[200],
            borderRadius: BorderRadius.circular(7.0),
            border: Border.all(color: Colors.grey[400]),
          ),
          child: (Center(
            child: Text(
              _numbers[index].toString(),
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          )),
        ),
      );
    });

    return Container(
      height: 130.0,
      width: MediaQuery.of(context).size.width - 100.0,
      child: GridView.count(
        crossAxisCount: 5,
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        padding: EdgeInsets.all(10.0),
        children: _touchKeyboard,
      ),
    );
  }

  Widget _buildbtnValid(bool isValidBtn) {
    return GestureDetector(
      onTap: isValidBtn ? () => print("click btn") : null,
      child: Opacity(
        opacity: isValidBtn ? 1.0 : 0.5,
        child: Container(
          height: 60.0,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(64),
          ),
          child: Center(
            child: Text(
              "valider",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _addNumber(int number) {
    setState(() {
      _password += "$number"; // += number.tostring()
      _passwordLenght++;
    });
  }

  _reinitPassword() {
    setState(() {
      _password = "";
      _passwordLenght = 0;
    });
  }
}

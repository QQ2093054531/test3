import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/focus_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _selectionController = TextEditingController();
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  // _selectionController.text = "hello world";
  // _selectionController.selection = TextSelection(
  //     baseOffset: 2, extentOffset: _selectionController.text.length);

  @override
  Widget build(BuildContext context) {
    _selectionController.text = "hello world";
    _selectionController.selection = TextSelection(
        baseOffset: 2, extentOffset: _selectionController.text.length);

    FocusNode focusNode1 = FocusNode();
    FocusNode focusNode2 = FocusNode();
    FocusScopeNode? focusScopeNode;

    GlobalKey _formKey = GlobalKey<FormState>();

    return Scaffold(
        key: _formKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            TextFormField(
              autofocus: true,
              focusNode: focusNode1,
              controller: _unameController,
              decoration: InputDecoration(
                  labelText: "?????????",
                  hintText: "email",
                  prefixIcon: Icon(Icons.person)),
              validator: (v) {
                return v!.trim().isNotEmpty ? null : "?????????????????????";
              },
            ),
            TextFormField(
              autofocus: true,
              focusNode: focusNode2,
              decoration: InputDecoration(
                  labelText: "??????",
                  hintText: "??????????????????",
                  prefixIcon: Icon(Icons.lock)),
              obscureText: true,
              validator: (v) {
                return v!.trim().length > 5 ? null : "??????????????????6???";
              },
            ),
            TextField(
                autofocus: true,
                onChanged: (v) {
                  print("onChange: $v");
                }),
            TextField(
              controller: _selectionController,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "??????????????????",
                prefixIcon: Icon(Icons.person),
                // ????????????????????????????????????
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                //?????????????????????????????????
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "??????????????????",
                    prefixIcon: Icon(Icons.email),
                    border: InputBorder.none //???????????????
                    )),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("??????"),
                      ),
                      onPressed: () {
                        // ??????_formKey.currentState ??????FormState??????
                        // ??????validate()????????????????????????????????????????????????
                        // ???????????????????????????
                        if ((_formKey.currentState as FormState).validate()) {
                          //????????????????????????
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Builder(
              builder: (ctx) {
                return Column(
                  children: <Widget>[
                    ElevatedButton(
                      child: Text("????????????"),
                      onPressed: () {
                        //?????????????????????TextField???????????????TextField
                        // ?????????????????? FocusScope.of(context).requestFocus(focusNode2);
                        // ?????????????????????
                        if (null == focusScopeNode) {
                          focusScopeNode = FocusScope.of(context);
                        }
                        focusScopeNode?.requestFocus(focusNode2);
                      },
                    ),
                    ElevatedButton(
                      child: Text("????????????"),
                      onPressed: () {
                        // ??????????????????????????????????????????????????????
                        focusNode1.unfocus();
                        focusNode2.unfocus();
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ));
  }
}

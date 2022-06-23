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
                  labelText: "用户名",
                  hintText: "email",
                  prefixIcon: Icon(Icons.person)),
              validator: (v) {
                return v!.trim().isNotEmpty ? null : "用户名不能为空";
              },
            ),
            TextFormField(
              autofocus: true,
              focusNode: focusNode2,
              decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  prefixIcon: Icon(Icons.lock)),
              obscureText: true,
              validator: (v) {
                return v!.trim().length > 5 ? null : "密码不能少于6位";
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
                labelText: "请输入用户名",
                prefixIcon: Icon(Icons.person),
                // 未获得焦点下划线设为灰色
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                //获得焦点下划线设为蓝色
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "电子邮件地址",
                    prefixIcon: Icon(Icons.email),
                    border: InputBorder.none //隐藏下划线
                    )),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("登录"),
                      ),
                      onPressed: () {
                        // 通过_formKey.currentState 获取FormState后，
                        // 调用validate()方法校验用户名密码是否合法，校验
                        // 通过后再提交数据。
                        if ((_formKey.currentState as FormState).validate()) {
                          //验证通过提交数据
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
                      child: Text("移动焦点"),
                      onPressed: () {
                        //将焦点从第一个TextField移到第二个TextField
                        // 这是一种写法 FocusScope.of(context).requestFocus(focusNode2);
                        // 这是第二种写法
                        if (null == focusScopeNode) {
                          focusScopeNode = FocusScope.of(context);
                        }
                        focusScopeNode?.requestFocus(focusNode2);
                      },
                    ),
                    ElevatedButton(
                      child: Text("隐藏键盘"),
                      onPressed: () {
                        // 当所有编辑框都失去焦点时键盘就会收起
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

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:renawistory/services/push_notification.dart';
import 'package:renawistory/widgets/alert.dart';
import 'package:renawistory/widgets/roundedInput.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = 'login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late String? token;
  _getToken()async {
    token = await PushNotification.getTokenID();
  }

  late String socialStatus;
  List<String> ListSocialStatus = [
    '',
    'عازب/ة',
    'متزوج/ة',
    'مطلق/ة',
    'أرمل/ة',
  ];
  late List<DropdownMenuItem<String>> _dropDownMenuItems;
  List<DropdownMenuItem<String>> getDropDownMenuItems(List<String> choices) {
    List<DropdownMenuItem<String>> items = [];
    for (String item in choices) {
      items.add(new DropdownMenuItem(value: item, child: new Text(item)));
    }
    return items;
  }

  bool isLogin = true;
  String gender = '';
  int group = 0;
  DateTime? selectDate;
  late Animation<double> containerSize;
  late AnimationController animationController;
  Duration animationDuration = Duration(milliseconds: 270);
  TextEditingController emailLogin = TextEditingController();
  TextEditingController emailRegister = TextEditingController();
  TextEditingController passLogin = TextEditingController();
  TextEditingController passRegister = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController phone = TextEditingController();
  GlobalKey<FormState> LoginformState = new GlobalKey<FormState>();
  GlobalKey<FormState> RegisterformState = new GlobalKey<FormState>();

  late var userCredential2;
  late var userCredential;
  signin(BuildContext context) async {
    var formdata = LoginformState.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        showLoading(context);
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailLogin.text, password: passLogin.text);
        return userCredential;
      } on FirebaseException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context, title: "خطأ", body: Text("الإيميل غير صحيح "))
            ..show();
        } else if (e.code == 'wrong-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "خطأ",
              body: Text("كلمة المرور غير صحيحة"))
            ..show();
        }
      }
    } else {
      print('error');
    }
  }

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems(ListSocialStatus);
    socialStatus = _dropDownMenuItems[0].value!;
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    animationController =
        AnimationController(vsync: this, duration: animationDuration);
    _getToken();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double viewInset = MediaQuery.of(context).viewInsets.bottom;
    double defultLoginSize = size.height - (size.height * .2);
    double defultRegisterSize = size.height - (size.height * .1);
    containerSize =
        Tween<double>(begin: size.height * .1, end: defultRegisterSize).animate(
            CurvedAnimation(parent: animationController, curve: Curves.linear));
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 100,
            right: -50,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).primaryColor),
            ),
          ),
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).primaryColor),
            ),
          ),
          AnimatedOpacity(
            duration: animationDuration,
            opacity: isLogin ? 0.0 : 1.0,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                alignment: Alignment.bottomCenter,
                width: size.width,
                height: size.height * .1,
                child: IconButton(
                    onPressed: isLogin
                        ? null
                        : () {
                            animationController.reverse();
                            setState(() {
                              isLogin = !isLogin;
                            });
                          },
                    icon: Icon(Icons.close)),
              ),
            ),
          ),
          AnimatedOpacity(
            duration: animationDuration * 4,
            opacity: isLogin ? 1.0 : 0.0,
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Container(
                  width: size.width,
                  height: defultLoginSize,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * .05,
                      ),
                      Container(
                          height: size.height * .3,
                          child: Image.asset(
                            'assets/images/Mobile login-rafiki.png',
                            fit: BoxFit.cover,
                          )),
                      SizedBox(
                        height: size.height * .05,
                      ),
                      Form(
                          key: LoginformState,
                          child: Column(
                            children: [
                              InputContainer(
                                child: TextFormField(
                                  validator: (val) {
                                    if (!val!.contains('@')) {
                                      return "يجب أن يحتوي الإيميل على علامة @";
                                    }
                                    if (val.length < 7) {
                                      return "لا يمكن أن يكون الإيميل بهذا الطول ";
                                    }
                                    return null;
                                  },
                                  controller: emailLogin,
                                  cursorColor: Theme.of(context).primaryColor,
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                    hintText: 'البريد الإلكتروني',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              InputContainer(
                                  child: RoundedPassword(
                                pass: passLogin,
                              )),
                            ],
                          )),
                      SizedBox(
                        height: size.height * .02,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: size.width * .28)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).primaryColor),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).primaryColorLight),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ))),
                        onPressed: () {
                          onSignIn();
                        },
                        child: Text('تسجيل الدخول'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              if (isLogin && viewInset == 0) {
                return buildRegisterContainer();
              } else if (!isLogin) {
                return buildRegisterContainer();
              }
              return Container();
            },
          ),
          AnimatedOpacity(
            duration: animationDuration * 5,
            opacity: isLogin ? 0.0 : 1.0,
            child: Visibility(
              visible: !isLogin,
              child: Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Container(
                    width: size.width,
                    //  height: defultLoginSize,
                    child: Form(
                      key: RegisterformState,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height * .05,
                          ),
                          InputContainer(
                              child: TextField(
                            controller: emailRegister,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              hintText: 'البريد الإلكتروني',
                              border: InputBorder.none,
                            ),
                          )),
                          InputContainer(
                              child: TextField(
                            controller: userName,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              hintText: 'اسم المستخدم',
                              border: InputBorder.none,
                            ),
                          )),
                          InputContainer(
                              child: TextField(
                            controller: phone,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                              hintText: 'رقم الهاتف',
                              border: InputBorder.none,
                            ),
                          )),
                          InputContainer(
                              child: RoundedPassword(
                            pass: passRegister,
                          )),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            height: 70,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(''
                                      /*    selectDate == null
                                      ? 'تاريخ الميلاد!'
                                      : 'تاريخ ميلادك : ${DateFormat.yMd().format(selectDate!)}'
                                */
                                      ),
                                ),
                                FlatButton(
                                  color: Theme.of(context).primaryColor,
                                  onPressed: datePicker,
                                  child: Text(
                                    'اختر تاريخ الميلاد ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  textColor: Theme.of(context).primaryColor,
                                )
                              ],
                            ),
                          ),
                          ListTile(
                            title: Text("ذكر"),
                            leading: Radio(
                              value: 1,
                              groupValue: group,
                              onChanged: (value) {
                                setState(() {
                                  gender = 'ذكر';
                                  group = 1;
                                });
                              },
                              activeColor: Theme.of(context).primaryColor,
                            ),
                          ),
                          ListTile(
                            title: const Text('أنثى'),
                            leading: Radio(
                              value: 2,
                              groupValue: group,
                              onChanged: (value) {
                                setState(() {
                                  gender = 'أنثى';
                                  group = 2;
                                });
                              },
                              activeColor: Theme.of(context).primaryColor,
                            ),
                          ),
                          createRow('الحالة الإجتماعية : ', _dropDownMenuItems,
                              socialStatus),
                          ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: size.width * .28)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Theme.of(context).primaryColor),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Theme.of(context).primaryColorLight),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ))),
                            onPressed: () async {
                              var response = await signUp(context);
                              User? user =
                                  await FirebaseAuth.instance.currentUser;
                              if (response != null) {
                                await FirebaseFirestore.instance
                                    .collection('centers')
                                    .doc('renawi')
                                    .collection('users')
                                    .doc(user!.uid)
                                    .set({
                                  'email': emailRegister.text,
                                  'name': userName.text,
                                  'phone': phone.text,
                                  'dateOFBirth': selectDate,
                                  'socialStatus': socialStatus,
                                  'gender': gender,
                                  'token': token
                                }).then((_) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage()),
                                  );
                                });
                              } else {
                                AwesomeDialog(
                                    context: context,
                                    title: "خطأ",
                                    body: Text("فشل  إنشاء الحساب "))
                                  ..show();
                              }
                            },
                            child: Text('إنشاء حساب'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  signUp(BuildContext context) async {
    var formdata = RegisterformState.currentState;
    print(formdata!.validate());
    // print(socialStatus.isNotEmpty);
    print(gender.isNotEmpty);
    //  print(selectDate!=null);
    if (formdata.validate() &&
        socialStatus.isNotEmpty &&
        gender.isNotEmpty &&
        selectDate != null) {
      formdata.save();
      try {
        showLoading(context);
        userCredential2 = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailRegister.text, password: passRegister.text);
        return userCredential2;
      } on FirebaseException catch (e) {
        if (e.code == 'weak-password') {
          //  Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "خطأ",
              body: Text("كلمة المرور المقدمة ضعيفة للغاية."))
            ..show();
          return null;
        } else if (e.code == 'email-already-in-use') {
          //  Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "خطأ",
              body: Text("الحساب موجود بالفعل لهذا البريد الإلكتروني."))
            ..show();
          return null;
        }
      } catch (e) {
        // Navigator.of(context).pop();
        AwesomeDialog(context: context, title: "خطأ", body: Text(e.toString()))
          ..show();
        return null;
      }
    } else {
      // Navigator.of(context).pop();
      AwesomeDialog(
          context: context,
          title: "خطأ",
          body: Text("تأكد من إدخال جميع البيانات بشكل صحيح ! "))
        ..show();
      return null;
    }
  }

  Widget createRow(
    String Status,
    List<DropdownMenuItem<String>> choices,
    String selected,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(Status),
          Spacer(),
          DropdownButton(
            value: selected,
            items: choices,
            onChanged: (String? selectedStatus) {
              setState(() {
                socialStatus = selectedStatus!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildRegisterContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: Container(
          width: double.infinity,
          height: containerSize.value,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100),
                topRight: Radius.circular(100),
              ),
              color: Theme.of(context).primaryColorLight),
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: !isLogin
                ? null
                : () {
                    animationController.forward();
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
            child: isLogin
                ? Text(
                    'لا تمتلك حساب ؟ إنشاء حساب',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 18),
                  )
                : null,
          ),
        ),
      ),
    );
  }

  onSignIn() async {
    var response = await signin(context);
    if (response != null) {
      Navigator.of(context).pushReplacementNamed('home_page');
    } else {
      //  Navigator.of(context).pop();
      return AwesomeDialog(
          context: context, title: "خطأ", body: Text("فشل تسجيل الدخول "))
        ..show();
    }
  }

  void datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime(2008),
      firstDate: DateTime(1960),
      lastDate: DateTime(2008),
    ).then((pikedDate) {
      if (pikedDate == null) {
        return;
      }
      setState(() {
        selectDate = pikedDate;
      });
    });
  }
}

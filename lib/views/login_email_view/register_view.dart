import 'package:flutter/material.dart';
import 'package:number_connection_test/constants/routes.dart';
import 'package:number_connection_test/globals/gobals.dart';
import 'package:number_connection_test/services/auth/auth_exceptions.dart';
import 'package:number_connection_test/services/auth/auth_service.dart';
import 'package:number_connection_test/services/crud/services/crud_service_mysql.dart';
import 'package:number_connection_test/services/crud/sqlite/crud_exceptions.dart';
import 'package:number_connection_test/utilities/dialogs/error_dialog.dart';
import 'package:number_connection_test/utilities/generics/convert_date_format.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _name;
  DateTime? _selectedDate;
  late final TextEditingController _birthDateController;
  late final TextEditingController _genderController;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _name = TextEditingController();
    _birthDateController =
        TextEditingController(); // Initialize the birth date controller
    _genderController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _name.dispose();
    _birthDateController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('zh', 'TW'),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        // Format and set the date in _birthDateController
        _birthDateController.text =
            "${picked.year}/${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _selectGender(BuildContext context) async {
    final String? selectedGender = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('選擇您性別'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, '生理男');
              },
              child: const Text('生理男'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, '生理女');
              },
              child: const Text('生理女'),
            ),
          ],
        );
      },
    );
    if (selectedGender != null) {
      setState(() {
        _genderController.text = selectedGender;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const uiHight = 20.0;
    return Scaffold(
      // appBar: AppBar(title: const Text('註冊')),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'HE App',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(
                  height: 50,
                ),
                TextField(
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: const InputDecoration(
                    hintText: '請輸入您的e-mail',
                    icon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(
                  height: uiHight,
                ),
                TextField(
                  controller: _password,
                  obscureText: !_isPasswordVisible,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: InputDecoration(
                    hintText: '請輸入長度需大於8位數的密碼',
                    icon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(
                          () {
                            _isPasswordVisible = !_isPasswordVisible;
                          },
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: uiHight,
                ),
                TextField(
                  controller: _name,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: const InputDecoration(
                    hintText: '請輸入您的大名',
                    icon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(
                  height: uiHight,
                ),
                TextFormField(
                  controller: _birthDateController,
                  readOnly: true,
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: const InputDecoration(
                    hintText: '選擇您的生日',
                    icon: Icon(Icons.calendar_today),
                  ),
                  onTap: () => _selectDate(context),
                ),
                const SizedBox(
                  height: uiHight,
                ),
                TextFormField(
                  controller: _genderController,
                  // This makes the field not editable directly
                  readOnly: true,
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: const InputDecoration(
                    hintText: '選擇您性別',
                    icon: Icon(Icons.transgender),
                  ),
                  onTap: () => _selectGender(
                      context), // Call the gender selection dialog
                ),
                const SizedBox(
                  height: uiHight,
                ),
                //controller connect to TextButton
                TextButton(
                  onPressed: () async {
                    final localcontext = this.context;
                    final email = _email.text;
                    final password = _password.text;
                    final name = _name.text;
                    final birthday =
                        convertDateFormat(_birthDateController.text);
                    final gender = _genderController.text;
                    const identity =
                        '一般使用者'; // hard-coding, doctor identity given by server side
                    try {
                      await AuthService.firebase().createUser(
                        email: email,
                        password: password,
                      );
                      await Services().createDatabaseUser(
                        email: email,
                        name: name,
                        identity: identity,
                        birthday: birthday,
                        gender: gender,
                      );
                      await AuthService.firebase().sendEmailVerification();
                      Navigator.of(localcontext).pushNamedAndRemoveUntil(
                        verifyEmailRoute,
                        (route) => false,
                      );
                    } on WeakPasswordAuthException {
                      await showErrorDialog(
                          localcontext, '密碼問題', '密碼強度太弱，請換一組超過8位數的密碼');
                    } on EmailAlreadyInUseAuthException {
                      await showErrorDialog(
                          localcontext, 'Email問題', '此E-mail已被註冊');
                    } on InvalidEmailAuthException {
                      await showErrorDialog(
                          localcontext, 'Email問題', '此E-mail格式有誤');
                    } on GenericAuthException {
                      await showErrorDialog(localcontext, '出錯了', '註冊失敗');
                    } on DBCouldNotCreateUser {
                      await showErrorDialog(
                          localcontext, '資料庫問題', '新建使用者失敗，請聯絡客服');
                    } on DBUserAlreadyExists {
                      await showErrorDialog(
                          localcontext, '資料庫問題', '使用者已存在，請登入或聯絡客服');
                    } on DatabaseIsNotOpen {
                      await showErrorDialog(
                          localcontext, '資料庫問題', '資料庫伺服器問題，請聯絡客服');
                    }
                  },
                  child: const Text(
                    '註冊',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: globColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/login/', (route) => false);
                  },
                  child: const Text(
                    '已經註冊，點擊這裡登入！',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: globColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

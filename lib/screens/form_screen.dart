import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xicom_test/model/image_model.dart';
import 'package:xicom_test/providers/form_screen_provider.dart';
import 'package:xicom_test/widgets/custom_textField.dart';
import 'package:xicom_test/widgets/gradient_button.dart';

class FormScreen extends StatefulWidget {
  static const classname = "/FormScreen";

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  ImageData data;


  @override
  void initState() {
    final provider=Provider.of<FormScreenProvider>(context,listen: false);
    provider.key=GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    final provider=Provider.of<FormScreenProvider>(context);
    provider.data=data;
    return Scaffold(
      key: provider.key,
      appBar: AppBar(title: Text("Detail Screen"),),
      body: Consumer<FormScreenProvider>(builder: (context, value, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(data.xtImage)),
                SizedBox(
                  height: 20,
                ),
                MultiLineTextInput(
                  controller: value.firstname,
                  m_helperText: "Enter alphabets only",
                  m_hintText: "",
                  m_labelText: "Enter First Name",
                ),
                SizedBox(
                  height: 20,
                ),
                MultiLineTextInput(
                  controller: value.lastname,
                  m_helperText: "Enter alphabets only",
                  m_hintText: "",
                  m_labelText: "Enter Last Name",
                ),
                SizedBox(
                  height: 20,
                ),
                MultiLineTextInput(
                  controller: value.email,
                  m_helperText: "Enter alphabets only",
                  m_hintText: "",
                  m_labelText: "Enter Email",
                ),
                SizedBox(
                  height: 20,
                ),
                MultiLineTextInput(
                  controller: value.phoneNumber,
                  m_helperText: "Enter Numerical only",
                  m_hintText: "",
                  m_labelText: "Enter Phone Number",
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: 20,
                ),
                GradientButton(
                  onpress: () {
                    value.submit();

                  },
                  text: "Submit",
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

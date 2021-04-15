import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xicom_test/providers/home_provider.dart';
import 'package:xicom_test/screens/form_screen.dart';
import 'package:xicom_test/widgets/list_image_widget.dart';

class HomeScreen extends StatefulWidget {
  static const classname="/HomeScreen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen"),),
      body: Consumer<HomeProvider>(builder: (context, value, child) {
        return Container(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            controller: value.refreshController,
            onRefresh: value.referesh,
            onLoading: value.onLoading,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, FormScreen.classname,arguments: value.listImage[index]);
                    },
                    child: ListImageWidget(
                      imageUrl: value.listImage[index].xtImage,
                      id: value.listImage[index].id,
                    )); // item added here
              },
              itemCount: value.listImage.length,
            ),
          ),
        );
      }),
    );
  }

  @override
  void initState() {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    provider.init();
  }
}

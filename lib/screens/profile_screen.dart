import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_example/controller/home_controller.dart';
import 'package:test_example/models/profile_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
        builder: (context, HomeController controler, child) {
      return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: FutureBuilder<ProfileModel>(
                future: controler
                    .getProfileData(), // a previously-obtained Future<String> or null
                builder:
                    (BuildContext context, AsyncSnapshot<ProfileModel> data) {
                  if (data.hasData) {
                    return ListView.builder(
                        itemCount: data.data!.results!.length,
                        itemBuilder: (context, index) {
                          return _listData(data.data!.results![index]);
                        });
                  } else if (data.hasError) {
                    Icon(Icons.error);
                  }
                  return Center(child: CircularProgressIndicator());
                  //   ],
                  // )
                })),
      );
    });
  }

  Widget _listData(Result data) {
    return Card(
      child: Container(
        child: Row(
          children: [
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Image.network(
                  data.picture?.thumbnail ?? '',
                  // width: 50,
                  // height: 50,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: CircularProgressIndicator());
                  },
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                )),
            SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Column(
                children: [
                  textdata('Name', data.name?.first ?? ''),
                  textdata('Location', data.location?.city ?? ''),
                  textdata('Email', data.email ?? ''),
                  textdata('Dob', data.dob!.date.toString()),
                  textdata('No Of Days Passed Since Register',
                      data.registered!.date.toString())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget textdata(String title, String data) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(4),
      child: Text(
        '$title : $data',
        textAlign: TextAlign.left,
      ),
    );
  }
}

// import 'package:beefworld/contollers/topics_controller.dart';
// ignore_for_file: prefer_equal_for_default_values

import 'package:docoradiapp/components/personalDocumentDetails.dart';
import 'package:flutter/material.dart';
import 'package:avatars/avatars.dart';
import 'package:get/get.dart';
import '../model/ViewLater.dart';
import '../model/Document.dart';
import '../apis/httpService.dart';
// import '../components/video/videoCard.dart';
// import 'SearchPage.dart';
import '../model/UploadedDocuments.dart';
import '../components/documentDetails.dart';
import '../components/UploadPersonalFile.dart';
import '../components/SearchPage.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';
import '../utils/DateUtil.dart';
import 'package:dio/dio.dart';
// import '../components//UploadPersonalFile.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  Icon customIcon = Icon(Icons.search);
  bool loading = false;
  late String userEmail = 'sdsd';
  Widget customSearchBar = Row(
    children: [
      Image.asset(
        "assets/images/logo.jpeg",
        fit: BoxFit.contain,
        height: 50,
        width: 50,
      ),
    ],
  );
  final List<String> tabs = ['Recent', 'View Later', 'Uploads'];
  late TabController tabController;
  HttpService httpService = HttpService();
  ViewLaterModel vieelead = ViewLaterModel();
  // final topicsController = Get.find<TopicsController>();

  List<UploadedDocuments> personalDoc = [];

  // Icon customIcon = const Icon(Icons.search);

  // Home({Key? key}) : super(key: key);
  // bool get wantKeepAlive => false;
  void getDataforViewLater() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userEmail = prefs.getString('userId') as String;
      final HttpService httpService = HttpService();
      final List<Documents> data = await httpService.getDocuments();
      personalDoc = await httpService.getPersonalDocuments();
      setState(() {
        vieelead.addRecent(data);
        for (var prop in data) {
          if (prop.isLater == true) {
            vieelead.add(prop);
          }
        }
        loading = false;
      });

      // print(vieelead.recentsdoc);
    } catch (ex) {
      print(ex);
    }
  }

  void check_if_already_login() async {
    var logindata = await SharedPreferences.getInstance();
    var isLoggedIn = logindata.getBool('isLoggedIn');
    if (isLoggedIn != true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  void logOut() async {
    var logindata = await SharedPreferences.getInstance();
    logindata.setBool('isLoggedIn', false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  void initState() {
    super.initState();
    check_if_already_login();
    getDataforViewLater();
    // rootBundle
    //     .loadString('assets/credentials.json')
    //     .then((json) => {api = CloudApi(json)});
  }

  void viewlater(Documents doc) {
    vieelead.add(doc);

    // print(doc.objectID);
    setState(() {
      vieelead.docs;
    });

    httpService.setAsViewLater(doc.objectID);
  }

  void RemoveFromviewlater(Documents doc) {
    vieelead.romoveFromList(doc);
    setState(() {
      vieelead.docs;
    });
    httpService.removeAsViewLater(doc.objectID);
  }

  void markAsView(Documents doc) {
    print('view later');
    print(doc);
    vieelead.add(doc);
    httpService.markAsViewed(doc.objectID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 58, 57, 57),
        appBar: _getAppBar(context),
        body: mainBody(context),
        drawer: sideDrawer(),
        floatingActionButton: new FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 245, 243, 243),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: Color.fromARGB(255, 180, 18, 18),
              )
            ],
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UploadsUtil()));
          },
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniEndFloat);
  }

  @override
  bool get wantKeepAlive => true;

  Widget mainBody(context) {
    return DefaultTabController(
        length: 3, // length of tabs
        initialIndex: 0,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 24, 23, 23),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromARGB(255, 27, 27, 27),
            bottom: TabBar(
              labelColor: const Color.fromARGB(255, 245, 12, 78),
              unselectedLabelColor: const Color.fromARGB(255, 240, 235, 235),
              tabs: [
                Tab(text: 'Recent'),
                Tab(text: 'View Later'),
                Tab(text: 'Uploads'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                child: vieelead.recentsdoc.isEmpty
                    ? Container(
                        margin: EdgeInsets.only(left: 80, right: 40, top: 100),
                        child: Text("No document found ",
                            style: TextStyle(
                                color: Color.fromARGB(255, 221, 217, 217))),
                      )
                    : recentDocs(context, vieelead.recentsdoc),
              ),
              Container(
                child: vieelead.docs.isEmpty
                    ? Container(
                        margin: EdgeInsets.only(left: 80, right: 40, top: 100),
                        child: Text("No document to be viewed later ",
                            style: TextStyle(
                                color: Color.fromARGB(255, 221, 217, 217))),
                      )  :viewLaterList(context, vieelead.docs),
              ),
              Container(
                child:personalDoc.isEmpty
                    ? Container(
                        margin: EdgeInsets.only(left: 30, right: 40, top: 100),
                        child: Text("No personal document available upload Now ",
                            style: TextStyle(
                                color: Color.fromARGB(255, 221, 217, 217))),
                      )  : personalUploads(context, personalDoc),
              )
            ],
          ),
        ));
  }

  Widget sideDrawer() {
    return Drawer(
        backgroundColor: Color.fromARGB(255, 39, 38, 38),
        child: ListView(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                radius: 18.0,
                child: ClipRRect(
                  child: Icon(Icons.person),
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              SizedBox(
                width: 130,
              ),
              ElevatedButton.icon(
                // <-- ElevatedButton
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 224, 218, 218),
                ),
                onPressed: () {
                  logOut();
                },
                icon: Icon(
                  Icons.logout,
                  size: 24.0,
                  color: Color.fromARGB(255, 19, 18, 18),
                ),
                label: Text('Logout',
                    style: TextStyle(color: Color.fromARGB(255, 26, 25, 25))),
              ),
            ],
          ),
          ListTile(
            title: Text(
              userEmail,
              style: TextStyle(color: Color.fromARGB(255, 221, 217, 217)),
            ),
          ),
          ListTile(
            title: const Text(
              'Bills',
              style: TextStyle(color: Color.fromARGB(255, 221, 217, 217)),
            ),
            leading: const Icon(
              Icons.folder,
              color: Colors.white,
            ),
            onTap: () {
              print("Clicked");
            },
          ),
          ListTile(
            title: const Text('Receipt',
                style: TextStyle(color: Color.fromARGB(255, 247, 245, 245))),
            leading: const Icon(
              Icons.folder,
              color: Colors.white,
            ),
            onTap: () {
              print("Clicked");
            },
          ),
        ]));
  }

  AppBar _getAppBar(context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 46, 45, 45),
      title: customSearchBar,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => SearchPage()));
          },
          icon: customIcon,
        )
      ],
    );
  }

  ListView recentDocs(BuildContext context, List<Documents> documents) {
    final theme = Theme.of(context);
    return ListView.builder(
      itemCount: documents.length,
      itemBuilder: (context, index) {
        final daysAgo = DateTimeUtils.getDaysAgo(documents[index].createdTime);

        if (documents[index].isViewed == false) {
          return Card(
              margin: EdgeInsets.all(1),
              elevation: 4,
              child: ListTile(
                tileColor: Color.fromARGB(179, 5, 5, 5),
                leading: Icon(
                  Icons.circle_outlined,
                  color: Color.fromARGB(255, 226, 224, 224),
                ),
                title: Text(
                  documents[index].companyName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 245, 242, 242),
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Open Sans',
                      fontSize: 20),
                ),
                subtitle: Text('Lorem ipsum dolor #${index + 1}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DocumentUtil(documents[index])));
                  // Navigator.push(context, )

                  // _launchURL(documents[index].documentURL);
                  markAsView(documents[index]);
                },
                trailing: SizedBox(
                    width: 96,
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Text(
                              "6:30",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text('New', style: TextStyle(color: Colors.white)),
                          ],
                        )),
                        SizedBox(width: 15),
                        IconButton(
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          ),
                          tooltip: 'View Later',
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: new Icon(Icons.watch_later),
                                        title: new Text('View Later'),
                                        onTap: () {
                                          viewlater(documents[index]);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.download),
                                        title: new Text('Download'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.delete),
                                        title: new Text('Delete'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.share),
                                        title: new Text('Share'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ],
                    )),
              ));
        } else {
          return Card(
              margin: EdgeInsets.all(1),
              elevation: 4,
              child: ListTile(
                tileColor: Color.fromARGB(179, 0, 0, 0),
                leading: Icon(
                  Icons.circle_outlined,
                  color: Color.fromARGB(255, 177, 176, 176),
                ),
                title: Text(
                  documents[index].companyName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 177, 176, 176),
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Open Sans',
                      fontSize: 20),
                ),
                subtitle: Text('Lorem ipsum dolor #${index + 1}',
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: Color.fromARGB(255, 177, 176, 176))),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DocumentUtil(documents[index])));
                  // _launchURL(documents[index].documentURL);
                  // markAsView(documents[index]);
                },
                trailing: SizedBox(
                    width: 96,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                '6:30',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 177, 176, 176),
                                ),
                              ),
                              Text(
                                'New',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 177, 176, 176),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 15),
                        IconButton(
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Color.fromARGB(255, 177, 176, 176),
                          ),
                          tooltip: 'View Later',
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: new Icon(Icons.watch_later),
                                        title: new Text('View Later'),
                                        onTap: () {
                                          viewlater(documents[index]);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.download),
                                        title: new Text('Download'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.delete),
                                        title: new Text('Delete'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.share),
                                        title: new Text('Share'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ],
                    )),
              ));
        }
      },
    );
  }

  ListView viewLaterList(BuildContext context, List<Documents> documents) {
    final theme = Theme.of(context);

    return ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          return Card(
              elevation: 4,
              child: ListTile(
                tileColor: Color.fromARGB(179, 0, 0, 0),
                leading: Icon(
                  Icons.circle_outlined,
                  color: Color.fromARGB(255, 177, 176, 176),
                ),
                title: Text(documents[index].companyName,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: Color.fromARGB(255, 177, 176, 176))),
                subtitle: Text('Lorem ipsum dolor #${index + 1}',
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: Color.fromARGB(255, 177, 176, 176))),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DocumentUtil(documents[index])));
                  // _launchURL(documents[index].documentURL);
                  // markAsView(documents[index]);
                },
                trailing: SizedBox(
                    width: 96,
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Text(
                              '6:30',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 177, 176, 176)),
                            ),
                            Text('New',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 177, 176, 176))),
                          ],
                        )),
                        SizedBox(width: 15),
                        IconButton(
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Color.fromARGB(255, 177, 176, 176),
                          ),
                          tooltip: 'View Later',
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: new Icon(Icons.remove),
                                        title: new Text('Remove from List'),
                                        onTap: () {
                                          RemoveFromviewlater(documents[index]);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.download),
                                        title: new Text('Download'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.delete),
                                        title: new Text('Delete'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.share),
                                        title: new Text('Share'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ],
                    )),
              ));
        });
  }

  ListView personalUploads(
      BuildContext context, List<UploadedDocuments> documents) {
    final theme = Theme.of(context);

    return ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          return Card(
              elevation: 4,
              child: ListTile(
                tileColor: Colors.white70,
                leading: Icon(Icons.file_copy_outlined),
                title: Text(
                  documents[index].description,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.headline6,
                ),
                subtitle: Text(
                  'Lorem ipsum dolor #${index + 1}',
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.caption,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PersonalDocumentUtil(documents[index])));
                },
                trailing: SizedBox(
                    width: 96,
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Text('6:30'),
                            Text('New'),
                          ],
                        )),
                        SizedBox(width: 15),
                        IconButton(
                          icon: const Icon(Icons.more_horiz),
                          tooltip: 'View Later',
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: new Icon(Icons.delete),
                                        title: new Text('Remove from List'),
                                        onTap: () {
                                          // RemoveFromviewlater(documents[index]);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.download),
                                        title: new Text('Download'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: new Icon(Icons.share),
                                        title: new Text('Share'),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ],
                    )),
              ));
        });
  }
}

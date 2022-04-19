import 'package:docoradiapp/main.dart';
import 'package:flutter/material.dart';
import 'package:avatars/avatars.dart';
import '../apis/httpService.dart';
import '../model/Document.dart';
import '../screens/Home.dart';
import '../components/documentDetails.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  // ignore: unnecessary_new

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          // The search area here
          backgroundColor: Color.fromARGB(255, 46, 45, 45),
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                onSubmitted: (value) async {
                  print(value);
                  HttpService httpService = HttpService();
                  final List<Documents> data =
                      await httpService.searchDocuments(value);
                  if (data.length > 0) {
                    await showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return Scaffold(
                            appBar: AppBar(
                              title: const Text('Search Results'),
                              backgroundColor: Color(0xFF800020),
                            ),
                            body: viewLaterList(context, data));
                      },
                    );
                  } else {
                    await showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return Scaffold(
                            appBar: AppBar(
                              title: const Text('Search Results'),
                              backgroundColor: Color(0xFF800020),
                            ),
                            body: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(20),
                                      child: Text(
                                          "Sorry no results for your search"),
                                    )
                                  ],
                                )
                              ],
                            ));
                      },
                    );
                  }
                },
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async {
                        // HttpService httpService = HttpService();
                        //    final List<Documents> data =
                        //             await httpService.searchDocuments(value);
                      },
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        /* Clear the search field */
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
              ),
            ),
          )),
    );
  }

  ListView viewLaterList(BuildContext context, List<Documents> documents) {
    final theme = Theme.of(context);
    final Home me = new Home();
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
}

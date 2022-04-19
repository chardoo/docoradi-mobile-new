import 'package:flutter/material.dart';
import '../model/Document.dart';
import '../model/UploadedDocuments.dart';
import '../components/documentDetails.dart';
import '../model/ViewLater.dart';
import '../apis/gcpApi.dart';
import '../apis/httpService.dart';
import '../screens/Home.dart';

//DocumentUtil dialog = DocumentUtil();
HttpService httpService = HttpService();
ViewLaterModel vieelead = ViewLaterModel();
ListView recentDocs(BuildContext context, List<Documents> documents) {
  final theme = Theme.of(context);
  return ListView.builder(
    itemCount: documents.length,
    itemBuilder: (context, index) {
      if (documents[index].isViewed == false) {
        return Card(
            elevation: 4,
            child: ListTile(
              tileColor: Colors.white70,
              leading: Icon(Icons.file_copy_outlined),
              title: Text(
                documents[index].companyName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Open Sans',
                    fontSize: 20),
              ),
              subtitle: Text(
                'Lorem ipsum dolor #${index + 1}',
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.caption,
              ),
              onTap: () {
                // Navigator.push(context, )
                // dialog.ShowDocumentDetials(context, documents[index]);
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
            elevation: 40,
            child: ListTile(
              tileColor: Colors.white70,
              leading: Icon(Icons.file_copy_outlined),
              title: Text(
                documents[index].companyName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Open Sans',
                    fontSize: 20),
              ),
              subtitle: Text(
                'Lorem ipsum dolor #${index + 1}',
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.caption,
              ),
              onTap: () {
                //    dialog.ShowDocumentDetials(context, documents[index]);
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
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'New',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
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
              tileColor: Colors.white70,
              leading: Icon(Icons.file_copy_outlined),
              title: Text(
                documents[index].companyName,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.headline6,
              ),
              subtitle: Text(
                'Lorem ipsum dolor #${index + 1}',
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.caption,
              ),
              onTap: () {
                //  dialog.ShowDocumentDetials(context, documents[index]);
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
                documents[index].documentType,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.headline6,
              ),
              subtitle: Text(
                'Lorem ipsum dolor #${index + 1}',
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.caption,
              ),
              onTap: () {
                // dialog.showGameDialog(context, documents[index]);
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

void viewlater(Documents doc) {
  vieelead.add(doc);
  // setState(() {
  //   vieelead.docs;
  // });
  httpService.setAsViewLater(doc.objectID);
}

void RemoveFromviewlater(Documents doc) {
  vieelead.romoveFromList(doc);
  // setState(() {
  //   vieelead.docs;
  // });
  httpService.removeAsViewLater(doc.objectID);
}

void markAsView(Documents doc) {
  print('view later');
  print(doc);
  vieelead.add(doc);
  httpService.markAsViewed(doc.objectID);
}

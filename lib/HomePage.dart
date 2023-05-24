import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tars/viewmodel/article_list_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ArticleListViewModel>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Center(
          child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListView.builder(
              itemCount: vm.viewModel.articles.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white12,
                  child: Column(
                    children: [
                      Image.network(vm.viewModel.articles[index].urlToImage ??
                          "https://upload.wikimedia.org/wikipedia/commons/0/0b/Google_News_icon.png"),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 12, left: 8, right: 8, bottom: 2),
                        child: ListTile(
                          //leading: Icon(Icons.expand_more, color: Colors.white,),
                          title: Text(vm.viewModel.articles[index].title ?? "",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0)),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                                vm.viewModel.articles[index].description ?? "",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white70)),
                          ),
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () async {
                                await launchUrl(Uri.parse(
                                    vm.viewModel.articles[index].url ?? ""));
                              },
                              child: Text("Haberi Gör")),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ),
      )),
    );
  }
}

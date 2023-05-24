import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tars/viewmodel/article_list_view_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/category.dart';

class Headlines extends StatefulWidget {
  const Headlines({Key? key}) : super(key: key);

  @override
  State<Headlines> createState() => _HeadlinesState();
}

class _HeadlinesState extends State<Headlines> {
  List<Category> categories = [
    Category("general", "Genel"),
    Category("business", "İş"),
    Category("sports", "Spor"),
    Category("health", "Sağlık"),
    Category("science", "Bilim"),
    Category("technology", "Teknoloji"),
  ];

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ArticleListViewModel>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 70,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: getCategoriesTab(vm),
              ),
            ),
            getWidgetByStatus(vm)
          ],
        )
    );
  }

  List<GestureDetector> getCategoriesTab(ArticleListViewModel vm) {
    List<GestureDetector> list = [];
    for (int i = 0; i < categories.length; i++) {
      list.add(GestureDetector(
        onTap: () => vm.getNews(categories[i].key),
        child: Card(
          color: Colors.white12,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(categories[i].title, textAlign: TextAlign.center, style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0)),
          ),
        ),
      ));
  }
    return
    list;
  }

  Widget getWidgetByStatus(ArticleListViewModel vm) {
    switch (vm.status.index) {
      case 2:
        return Expanded(child: ListView.builder(
            itemCount: vm.viewModel.articles.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white12,
                child: Column(
                  children: [
                    Image.network(
                        vm.viewModel.articles[index].urlToImage ??
                        "https://upload.wikimedia.org/wikipedia/commons/0/0b/Google_News_icon.png"),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12, left: 8, right: 8,),
                      child: ListTile(
                        //leading: Icon(Icons.expand_more, color: Colors.white,),
                        title: Text(vm.viewModel.articles[index].title ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0)),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 1),
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
            }));
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }

}

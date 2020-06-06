
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/model/artical_model.dart';

class News{

  List<Article> news = [];

  Future<void> getNews() async{
    String url = "http://newsapi.org/v2/top-headlines?country=us&apiKey=3a81be3739db49d79472539aeab97ebd";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok")
      {
        jsonData["articles"].forEach((element){
          if(element["urlToImage"] != null && element["description"] != null)
            {
              Article article = Article(
                title: element['title'],
                description: element['description'],
                author: element['auther'],
                url: element['url'],
                urlToImage: element['urlToImage'],
                content: element['content']
              );
              news.add(article);
            }
        });
      }

  }
}

class CategotyNews{

  List<Article> news = [];

  Future<void> getNews(String category) async{
    String url = "http://newsapi.org/v2/top-headlines?category=$category&country=us&apiKey=3a81be3739db49d79472539aeab97ebd";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok")
    {
      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element["description"] != null)
        {
          Article article = Article(
              title: element['title'],
              description: element['description'],
              author: element['auther'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content']
          );
          news.add(article);
        }
      });
    }

  }
}
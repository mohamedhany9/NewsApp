import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/model/artical_model.dart';
import 'package:newsapp/model/category_model.dart';
import 'package:newsapp/views/article_view.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {


  List<Article> article = new List<Article>();

  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  getNews() async{
    CategotyNews newsmodel = CategotyNews();
    await newsmodel.getNews(widget.category);
    article = newsmodel.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Flutter"),
            Text("News" , style: TextStyle(color: Colors.blue),),
          ],
        ),
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) :SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 16, right: 16, left: 16),
          child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: article.length,
              itemBuilder: (context,index){
                return BlogTile(
                  imgeUrl: article[index].urlToImage,
                  title: article[index].title,
                  desc: article[index].description,
                  url: article[index].url,
                );
              }),
        ),
      )
    );
  }
}

class BlogTile extends StatelessWidget {

  String imgeUrl , title , desc  , url;

  BlogTile({@required this.imgeUrl ,@required this.title ,@required this.desc ,@required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(

            builder: (context) => ArticleView(blogUrl: url,)
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(imageUrl: imgeUrl)),
            SizedBox(height: 4,),
            Text(title,style: TextStyle(
                fontSize: 17,
                color: Colors.black87,
                fontWeight: FontWeight.w500
            ),),
            SizedBox(height: 6,),
            Text(desc,style: TextStyle(
                fontSize: 11,
                color: Colors.black54
            ),),
            Divider(
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
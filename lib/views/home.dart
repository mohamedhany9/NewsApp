
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/helper/data.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/model/artical_model.dart';
import 'package:newsapp/model/category_model.dart';
import 'package:newsapp/views/article_view.dart';
import 'package:newsapp/views/category_news.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories = new List<CategoryModel>();
  List<Article> article = new List<Article>();

  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async{
    News newsmodel = News();
    await newsmodel.getNews();
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
      ) : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              Container(
                height: 70,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                    itemBuilder: (context,index){
                    return CategoryTile(
                      categoryName: categories[index].categoryName,
                      imageUrl: categories[index].imgeUrl,
                    );
                    }),
              ),

              Container(
                padding: EdgeInsets.only(top: 16),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {

  final String imageUrl , categoryName;

  CategoryTile({this.imageUrl , this.categoryName});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=> CategoryNews(
              category: categoryName.toLowerCase(),
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl , width: 120, height: 70, fit: BoxFit.cover,)),
            Container(
              alignment: Alignment.center,
            width: 120, height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26
              ),
              child: Text(categoryName , style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500
              ),),
            )
          ],
        ),
      ),
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





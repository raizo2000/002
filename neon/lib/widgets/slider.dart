import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeSlider extends StatefulWidget {
final String categoria;
HomeSlider(this.categoria);

  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  
  
  

  List<String> imgList=[];

  final List<String> imgList1 = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRf30A0e5A7vfKZCd1dfIyGbzt2b-CBOHioIg&usqp=CAU',
    'https://wallpapercave.com/wp/wp5599720.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQP7OLC-utKoCt9_V3mcV-S02NNu_Px-sFj1w&usqp=CAUs',
   /* 'https://cdn.statically.io/img/cdn.hipwallpaper.com/i/86/11/lxp0v7.jpg',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  */];
   final List<String> imgList2 = [
    'https://blogs.salleurl.edu/sites/default/files/styles/800x800/public/content/nodes/Noticia/image/19150/32035/shutterstock_592585685.jpg_1913337537.jpg',
    'https://media-cdn.tripadvisor.com/media/photo-s/08/61/bb/83/mercado-inaquito.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQP7OLC-utKoCt9_V3mcV-S02NNu_Px-sFj1w&usqp=CAUs',
   /* 'https://cdn.statically.io/img/cdn.hipwallpaper.com/i/86/11/lxp0v7.jpg',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  */];
  _imagenes(){
    if(widget.categoria == "SuperMercado"){
      imgList = imgList2;
    }else {
      imgList = imgList1;
    }
  }
  @override
  void initState() {
    
    super.initState();
    _imagenes();
  }
  



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: <Widget>[
          Center(
            child: CarouselSlider(
              autoPlay: true,
              pauseAutoPlayOnTouch: Duration(seconds: 10),
              height: 350.0,
              viewportFraction: 1.0,
              items: imgList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: i,
                          placeholder: (context, url) => Center(
                              child: CircularProgressIndicator()
                          ),
                          errorWidget: (context, url, error) => new Icon(Icons.error),
                        )
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

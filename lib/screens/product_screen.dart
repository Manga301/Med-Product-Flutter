import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:med_products_app/screens/fav_product_screen.dart';

class ProductScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ProductScreen> {
  Map mapResponse;
  List listOfProducts;

  Future fetchData() async {
    http.Response response;
    var url = 'https://dev.busymed.com/api/products_top_20';
    response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      setState(() {
        mapResponse = convert.jsonDecode(response.body);
        listOfProducts = mapResponse['products'];
        //print(mapResponse);
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool favProduct;

    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.shopping_cart_outlined),
                title: Text('Products'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductScreen(),
                    ),
                  );
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.favorite_border),
                title: Text('Favorites'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavProduct(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('My Med Store'),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(10.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: listOfProducts == null ? 0 : listOfProducts.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GridTile(
                  header: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          listOfProducts[index]['brand']['name'],
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        IconButton(
                          color: Theme.of(context).accentColor,
                          icon: favProduct == true
                              ? Icon(
                                  Icons.favorite,
                                  color: Theme.of(context).primaryColor,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: Theme.of(context).accentColor,
                                ),
                          onPressed: () {
                            setState(() {
                              favProduct = !favProduct;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  child: Container(
                    width: 60,
                    child: Image.network(
                      listOfProducts[index]['image_url'],
                      width: 50,
                    ),
                  ),
                  footer: GridTileBar(
                    backgroundColor: Theme.of(context).primaryColor,
                    title: Column(
                      children: [
                        Text(
                          listOfProducts[index]['name'],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          listOfProducts[index]['product_type'],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

Map<dynamic, dynamic> json = {
  "id": 2,
  "title": "Mens Casual Premium Slim Fit T-Shirts ",
  "price": 22.3,
  "size": "M",
  "description":
      "Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.",
  "category": "men's clothing",
  "image":
      "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
  "rating": {"rate": 4.1, "count": 259}
};

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFCE6E6EE),
      appBar: AppBar(
        title: Text("Products"),
        actions: <Widget>[
          InkWell(
            onTap: () {
              showMenu();
            },
            child: Icon(Icons.filter_alt_outlined, color: Colors.white),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("upload");
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 29,
        ),
        tooltip: 'Capture Picture',
        elevation: 5,
        splashColor: Colors.grey,
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    margin: EdgeInsets.only(top: 15, bottom: 15),
                    child: Row(
                      children: [
                        ExtendedImage.network(
                          json["image"],
                          width: 100,
                          height: 100,
                          cache: true,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(json["title"],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  MaterialButton(
                                    onPressed: () {},
                                    minWidth: 0,
                                    padding: EdgeInsets.all(10),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    shape: CircleBorder(),
                                    child: Icon(
                                      Icons.favorite_rounded,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        padding: EdgeInsets.only(
                                            left: 6,
                                            right: 6,
                                            top: 4,
                                            bottom: 4),
                                        child: Row(
                                          children: [
                                            Text("5.5",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Icon(Icons.star_rate_rounded,
                                                color: Colors.white, size: 10),
                                          ],
                                        ),
                                      ),
                                      Text("  (1600)",
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(5)),
                                    padding: EdgeInsets.only(
                                        left: 6, right: 6, top: 4, bottom: 4),
                                    child: Row(
                                      children: [
                                        Icon(Icons.done,
                                            color: Colors.white, size: 12),
                                        Text("    M",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                        "\$ " + json["price"].toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                  Row(
                                    children: [
                                      MaterialButton(
                                          onPressed: () {},
                                          shape: CircleBorder(),
                                          minWidth: 0,
                                          padding: EdgeInsets.all(5),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          child: Icon(
                                              Icons
                                                  .indeterminate_check_box_rounded,
                                              size: 30,
                                              color: Colors.blue)),
                                      Container(
                                        constraints:
                                            BoxConstraints(minWidth: 10),
                                        child: Text("3",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      MaterialButton(
                                          onPressed: () {},
                                          shape: CircleBorder(),
                                          minWidth: 0,
                                          padding: EdgeInsets.all(5),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          child: Icon(Icons.add_box_rounded,
                                              size: 30, color: Colors.blue)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  showMenu() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
              heightFactor: 0.9,
              child: new Container(
                child: new Row(
                  children: <Widget>[
                    Expanded(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            decoration: new BoxDecoration(color: Colors.red),
                            child: new Text("item 1"),
                          ),
                          new Container(
                            decoration: new BoxDecoration(color: Colors.amber),
                            child: new Text("item 3"),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            decoration: new BoxDecoration(color: Colors.green),
                            child: new Text("item 2"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}

import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key key, this.searchFildLabel, this.searchDelegate}) : super(key: key);

  final String searchFildLabel;
  final SearchDelegate searchDelegate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0.0),
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 1,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(24),
          //color: Color.fromRGBO(230, 230, 230, 1)
          color: Colors.white
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: searchFildLabel
                ),
                onTap: () {
                  showSearch(
                    context: context, 
                    delegate: searchDelegate
                  );
                },
              )
            ),
            Icon(
              Icons.search,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
import 'package:cafe_manager_app/common/constants/image_constants.dart';
import 'package:expandable_group/expandable_group_widget.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<List<String>> _generateData() {
    int numberOfGroups = 5;
    List<List<String>> results = List<List<String>>();
    for (int i = 0; i < numberOfGroups; i++) {
      List<String> items = List<String>();
      for (int j = 0; j < numberOfGroups * 5 + i; j++) {
        items.add("Item $j in group $i");
      }
      results.add(items);
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: _generateData().map((group) {
              int index = _generateData().indexOf(group);
              return ExpandableGroup(
                isExpanded: index == 0,
                header: _header('Group $index'),
                items: _buildItems(context, group),
                headerEdgeInsets: EdgeInsets.only(left: 16.0, right: 16.0),
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget _header(String name) => Text(name,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ));

  List<ListTile> _buildItems(BuildContext context, List<String> items) => items
      .map((e) => ListTile(
            title: Text(e),
          ))
      .toList();
}

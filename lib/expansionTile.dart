import 'package:flutter/material.dart';
import 'earthquake.dart';

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return new ListTile(title: new Text(root.title));
    return new ExpansionTile(
      key: new PageStorageKey<Entry>(root),
      title: new Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
List<Entry> getExpansionData(List<Earthquake> allHour, List<Earthquake> allDay,
    List<Earthquake> allWeek) {
  List<Entry> hour = new List();
  List<Entry> day = new List();
  List<Entry> week = new List();

  int i;
  for (i = 0; i < allHour.length; i++) {
    if (i == 50) {
      break;
    }
    hour.add(new Entry(allHour[i].place.toString()));
  }
  int afterHour = i;
  for (; i < allDay.length; i++) {
    if (i == 50 + afterHour) {
      day.add(new Entry("Only showing the last 50 earthquakes"));
      break;
    }
    day.add(new Entry(allDay[i].place.toString()));
  }
  int afterDay = i;
  for (; i < allWeek.length; i++) {
    if (i == 50 + afterDay + afterHour) {
      week.add(new Entry("Only showing the last 50 earthquakes"));
      debugPrint("Index: ${i.toString()}");
      break;
    }
    week.add(new Entry(allWeek[i].place.toString()));
  }

  return <Entry>[
    new Entry('Past Hour', hour),
    new Entry('Past Day', day),
    new Entry('Past Week', week),
  ];
}

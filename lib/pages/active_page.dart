// ignore_for_file: unused_field

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:math_crud/db/database.dart';
import 'package:math_crud/models/code.dart';
import 'package:math_crud/route/route_generator.dart';

import '../widgets/card_not_active.dart';

class ActivePage extends StatefulWidget {
  const ActivePage({Key key}) : super(key: key);

  @override
  _ActivePageState createState() => _ActivePageState();
}

class _ActivePageState extends State<ActivePage> with TickerProviderStateMixin {
  TabController _tabController;
  List<Code> resuNotActiveList = [];
  List<Code> resuActiveList = [];
  Size size;
  bool _isLoading = false;
  DataBase db = DataBase();
  final _SearchDemoSearchDelegate _delegate = _SearchDemoSearchDelegate();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = 0;
    _loadingNotActive();
    _loadingActive();
  }

  _loadingNotActive() async {
    setState(() {
      _isLoading = true;
      resuNotActiveList = [];
    });
    await Future.delayed(const Duration(milliseconds: 500));
    db.initiliase();
    db.readNotActive(false).then((List<Code> value) {
      setState(() {
        _isLoading = false;
        resuNotActiveList = value;
        _delegate._data = resuNotActiveList;
      });
    });
  }

  _loadingActive() async {
    setState(() {
      _isLoading = true;
      resuActiveList = [];
    });
    await Future.delayed(const Duration(milliseconds: 500));
    db.initiliase();
    db.readNotActive(true).then((List<Code> value) {
      setState(() {
        _isLoading = false;
        resuActiveList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                if (_tabController.index == 0) {
                  _delegate._data = resuNotActiveList;
                } else {
                  _delegate._data = resuActiveList;
                }

                final String selected = await showSearch<String>(
                  context: context,
                  delegate: _delegate,
                );
                print(selected);
              },
              icon: Icon(Icons.search)),
        ],
        backgroundColor: Colors.white10,
        title: const Text(
          'Active page',
          style: TextStyle(
            fontFamily: "ComicNeue",
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: Text(
                'not Active'.toUpperCase(),
                style: TextStyle(
                  fontFamily: "ComicNeue",
                ),
              ),
            ),
            Tab(
              icon: Text(
                'Active'.toUpperCase(),
                style: TextStyle(
                  fontFamily: "ComicNeue",
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: <Widget>[
              RefreshIndicator(
                onRefresh: () async {
                  _loadingNotActive();
                },
                child: ListView.builder(
                  itemCount: resuNotActiveList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardNotActive(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RouteGenerator.editCode,
                          arguments: resuNotActiveList[index],
                        ).then((value) {
                          if (value) {
                            _loadingActive();
                            _loadingNotActive();
                          }
                        });
                      },
                      resuList: resuNotActiveList,
                      size: size,
                      index: index,
                    );
                  },
                ),
              ),
              RefreshIndicator(
                onRefresh: () async {
                  _loadingActive();
                },
                child: ListView.builder(
                  itemCount: resuActiveList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return resuActiveList.isEmpty
                        ? Container()
                        : CardNotActive(
                            resuList: resuActiveList,
                            size: size,
                            index: index,
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                RouteGenerator.editCode,
                                arguments: resuActiveList[index],
                              ).then((value) {
                                if (value) {
                                  _loadingActive();
                                  _loadingNotActive();
                                }
                              });
                            },
                          );
                  },
                ),
              ),
            ],
          ),
          Offstage(
            offstage: !_isLoading,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: Container(
                color: Colors.white.withOpacity(0.1),
                child: const Center(
                    child: SpinKitSquareCircle(
                  color: Colors.white,
                  size: 100.0,
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _SearchDemoSearchDelegate extends SearchDelegate<String> {
  List<Code> _data;

  final List<Code> _history = [
    Code(date: '', active: false, code: '11111', id: '', ip: '', name: ''),
    Code(date: '', active: false, code: '22222', id: '', ip: '', name: ''),
    Code(date: '', active: false, code: '33333', id: '', ip: '', name: ''),
    Code(date: '', active: false, code: '44444', id: '', ip: '', name: '')
  ];

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<Code> suggestions = query.isEmpty
        ? _history
        : _data.where((Code i) => i.code.startsWith(query));

    return _SuggestionList(
      query: query,
      suggestions: suggestions.map<String>((Code i) => i.code).toList(),
      onSelected: (String suggestion) {
        query = suggestion;
        showResults(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final String searched = query;
    var list = _data.where((Code i) => i.code.contains(query));
    if (searched == null || list.isEmpty) {
      return Center(
        child: Text(
          '"$query"\n no such identification code is available.',
          style: const TextStyle(fontSize: 20, color: Colors.red),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView(
      children: <Widget>[
        _ResultCard(
          title: 'This code',
          integer: searched,
          searchDelegate: this,
        ),
      ],
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      if (query.isEmpty)
        IconButton(
          tooltip: 'Voice Search',
          icon: const Icon(Icons.mic),
          onPressed: () {
            query = 'TODO: implement voice input';
          },
        )
      else
        IconButton(
          tooltip: 'Clear',
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({this.integer, this.title, this.searchDelegate});

  final String integer;
  final String title;
  final SearchDelegate<String> searchDelegate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        searchDelegate.close(context, integer);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(title),
              Text(
                '$integer',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(null),
          title: RichText(
            text: TextSpan(
              text: suggestion.substring(0, query.length),
              style: TextStyle(color: Colors.green, fontSize: 20),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion.substring(query.length),
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}

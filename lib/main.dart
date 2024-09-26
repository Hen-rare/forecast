import 'package:flutter/material.dart';
import 'client/city_search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'WeatherForemost'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String cityKey = '';
  String cityName = '';
  String stateName = '';
  String countryName = '';

  List<Map<String, String>> cities = [];

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: locations',
      style: optionStyle,
    ),
    Text(
      'Index 2: Account',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void searchCity(String query) async {
    CitySearch citySearch = CitySearch();
    List<Map<String, String>> searchData = await citySearch.search(query);
    setState(() {
      cities = searchData;
    });
  }

  void _addCity() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 400,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    onChanged: searchCity,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text('Add City')),
                  ),
                ),
                Visibility(
                  visible: cities.isNotEmpty,
                  child: ListView.builder(
                      primary: true,
                      itemCount: cities.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          minTileHeight: 30,
                          title: Text(
                              '${cities[index]['country']}, ${cities[index]['state']}, ${cities[index]['city']}'),
                        );
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Description'),
                      hintText: 'Add a description',
                    ),
                    minLines: 6,
                    maxLines: 10,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 60, bottom: 20),
                  child: MaterialButton(
                    onPressed: () {},
                    color: Colors.grey,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 140),
                      child: Text('Save City'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/images/clima.png'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150),
              child: Image.asset(
                'assets/images/search.png',
              ),
            ),
            const Text(
              'No Data Found',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
              'Please add city to track it\'s weather',
            ),
            const Spacer(),
            const Divider(
              color: Colors.black,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCity,
        tooltip: 'Add',
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

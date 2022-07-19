import 'package:flutter/material.dart';
import 'film/film.dart';

class MyAppHome extends StatelessWidget {
  const MyAppHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      //body: Text('Hello word'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              Searchection(),
              CarsSection(),
              /* ElevatedButton(
                onPressed: () async {
                  await deconnection();
                },
                style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                child: const Icon(Icons.logout),
              ) */

/*                CustomScrollView(
                 slivers: [
                   SliverList(
                     delegate: SliverChildBuilderDelegate(
                       (BuildContext context, int index) {
                         return Card(
                           margin: const EdgeInsets.all(15),
                           child: Container(
                             color: Colors.blue[100 * (index % 9 + 1)],
                             height: 80,
                             alignment: Alignment.center,
                             child: Text(
                               "Item $index",
                               style: const TextStyle(fontSize: 30),
                             ),
                           ),
                         );
                       },
                       childCount: 1000, // 1000 list items
                     ),
                   ),
                 ],
               )
 */
            ],
          ),
        ));
  }
}

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);
  const MyAppBar({Key? key}) : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: const Text('Central Auto'),
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) {
              return const MyAppBarCar();
            },
            fullscreenDialog: true,
          ));
        },
      ),
      actions: [
        IconButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const SearchPage())),
            icon: const Icon(Icons.search))
      ],
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // The search area here
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    /* Clear the search field */
                  },
                ),
                hintText: 'Recherche...',
                border: InputBorder.none),
          ),
        ),
      )),
    );
  }
}

class Searchection extends StatefulWidget {
  const Searchection({Key? key}) : super(key: key);

  @override
  State<Searchection> createState() => _SearchectionState();
}

class _SearchectionState extends State<Searchection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.grey[200],
      padding: const EdgeInsets.fromLTRB(10, 25, 10, 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 35),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        ),
                      ]),
                  child: const TextField(
                    decoration: InputDecoration(
                        hintText: 'Recherche',
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4,
                        offset: Offset(0, 4)),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                  child: const Icon(Icons.search),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CarsSection extends StatefulWidget {
  const CarsSection({Key? key}) : super(key: key);

  @override
  State<CarsSection> createState() => _CarsSectionState();
}

class _CarsSectionState extends State<CarsSection> {
  final List carslist = [
    {
      "Marque": "Mercedes",
      "Modele": "Class-E",
      "picture": "assets/images/e1.jpg",
    },
    {
      "Marque": "Mercedes",
      "Modele": "Class-G",
      "picture": "assets/images/g1.jpg",
    },
    {
      "Marque": "Mercedes",
      "Modele": "Class-GLE",
      "picture": "assets/images/gle1.jpg",
    },
    {
      "Marque": "Mercedes",
      "Modele": "Class-S",
      //"picture": "assets/images/s1.jpg",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        children: carslist.map((car) {
          return CarCard(car);
          // return Container(
          //   child: Image.asset(car['picture']),
          // );
        }).toList(),
      ),
    );
  }
}

class CarCard extends StatefulWidget {
  final Map carData;
  const CarCard(this.carData);

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  get carData => Map;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      //width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: const BorderRadius.all(
            Radius.circular(18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 4,
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ]),
      child: Column(
        children: [
          Container(
            height: 250,
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
/* decoration: BoxDecoration(
               image: DecorationImage(
                 image: AssetImage(
                   carData['picture'],
                 ),
               ),
             ), */

/* class CarInformation extends StatefulWidget {
  const CarInformation({Key? key}) : super(key: key);

  @override
  State<CarInformation> createState() => _CarInformationState();
}

class _CarInformationState extends State<CarInformation> {
  final Stream<QuerySnapshot> _carStream =
      FirebaseFirestore.instance.collection('Voiture').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _carStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['model']),
              subtitle: Text(data['marque']),
            );
          }).toList(),
        );
      },
    );
  }
} */
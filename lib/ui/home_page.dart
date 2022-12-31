import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nonton_yuk/provider/http_helper.dart';
import 'package:nonton_yuk/ui/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = 'value';
  late HttpHelper helper;
  int moviesCount = 0;
  late List movies;

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  Future initialize() async {
    movies = [];
    movies = await helper.getUpcoming('');
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  Future search(text) async {
    movies = await helper.findMovies('');
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  Icon visibleIcon = const Icon(
    Icons.search,
    color: Colors.yellow,
  );
  Widget searcBar = Row(
    children: [
      Text(
        'Nonton',
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold, fontSize: 26, color: Colors.yellow),
      ),
      Text(
        'Cuy',
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: const Color.fromARGB(193, 0, 0, 0)),
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 44, 43, 43),
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              width: 30,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/logo/nontonyuk_logo.png')),
              ),
            ),
          ),
          title: searcBar,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (visibleIcon.icon == Icons.search) {
                      visibleIcon = const Icon(
                        Icons.cancel,
                        color: Colors.white,
                      );
                      searcBar = TextField(
                        textInputAction: TextInputAction.search,
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 16),
                        onSubmitted: (String text) {
                          search(text);
                        },
                      );
                    } else {
                      setState(() {
                        visibleIcon = visibleIcon;
                        searcBar = searcBar;
                      });
                    }
                  });
                },
                icon: visibleIcon)
          ],
          elevation: 0.0,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  "All Movies",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ),
              Tab(
                child: Text(
                  "Upcoming",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          Padding(
              padding: const EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: moviesCount,
                itemBuilder: (context, index) {
                  final date = movies[index].releaseDate as DateTime;

                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(movie: movies[index])));
                    },
                    title: Text(
                      movies[index].title,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      'Release Date: ${date.day}-${date.month}-${date.year}',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              )),
          //page upcoming film
          Padding(
              padding: const EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: moviesCount,
                itemBuilder: (context, index) {
                  final date = movies[index].releaseDate as DateTime;

                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(movie: movies[index])));
                    },
                    title: Text(
                      movies[index].title,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      'Release Date: ${date.day}-${date.month}-${date.year}',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              )),
        ]),
      ),
    );
  }
}

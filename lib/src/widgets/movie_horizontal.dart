import 'package:flutter/material.dart';
import 'package:movies/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function nextPage;

  MovieHorizontal({@required this.peliculas, @required this.nextPage});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.24,
      child: PageView.builder(
        itemCount: peliculas.length,
        itemBuilder: (context, i) => _crearTarjeta(context, peliculas[i]),
        pageSnapping: false,
        controller: _pageController,
      ),
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas
        .map(
          (pelicula) => Container(
            margin: EdgeInsets.only(right: 10.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    image: NetworkImage(
                      pelicula.getPosterImg(),
                    ),
                    fit: BoxFit.cover,
                    height: 160.0,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  pelicula.title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  Widget _crearTarjeta(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueId = '${pelicula.id}-movie';

    final tarjeta = Container(
      margin: EdgeInsets.only(right: 10.0),
      child: Column(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(
                  pelicula.getPosterImg(),
                ),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/cat_facts_service.dart';
import '../services/connectivity_service.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(
          fontFamily: 'Roboto', letterSpacing: 0.5, fontSize: 18),
      fixedSize: const Size(280, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
    return BlocProvider(
      create: (context) => HomeBloc(
        RepositoryProvider.of<CatFactsService>(context),
        RepositoryProvider.of<ConnectivityService>(context),
      )..add(LoadApiEvent()),
      child: Scaffold(
        backgroundColor: const Color(0xFFFBF5E4),
        // appBar: AppBar(
        //   title: const Text('Cat facts and photo'),
        // ),
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is HomeLoadedState) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: 280.0,
                          height: 280.0,
                          alignment: Alignment.center,
                          child:
                              Image.memory(state.rawImage, fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 25),
                        Container(
                          width: 280.0,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            state.catFactsCreatedAt,
                            style: const TextStyle(
                              color: Color(0xFF464646),
                              fontFamily: 'Roboto',
                              letterSpacing: 0.4,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        SizedBox(
                          width: 280.0,
                          height: 100,
                          child: SingleChildScrollView(
                            child: Text(
                              state.catFactsText,
                              style: const TextStyle(
                                color: Color(0xFF464646),
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto',
                                letterSpacing: 0.4,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: style,
                          onPressed: () => BlocProvider.of<HomeBloc>(context)
                              .add(LoadApiEvent()),
                          child: const Text('Another fact'),
                        ),
                        const SizedBox(height: 5),
                        // ElevatedButton(
                        //   style: style,
                        //   onPressed: () => BlocProvider.of<HomeBloc>(context)
                        //       .add(LoadApiEvent()),
                        //   child: const Text('Fact history'),
                        // ),
                      ],
                    ),
                  ),
                );
              }
              if (state is HomeNoInternetState) {
                return const Text('no internet :(');
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

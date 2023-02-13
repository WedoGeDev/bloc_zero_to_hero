import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/constants/enums.dart';
import 'package:flutter_bloc_concepts/logic/cubits/counter_cubit.dart';
import 'package:flutter_bloc_concepts/logic/cubits/counter_state.dart';
import 'package:flutter_bloc_concepts/logic/cubits/internet_cubit.dart';
import 'package:flutter_bloc_concepts/logic/cubits/internet_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title, required this.color});

  final String title;
  final Color color;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected) {
          if (state.connectionType == ConnectionType.wifi) {
            BlocProvider.of<CounterCubit>(context).increment();
          } else if (state.connectionType == ConnectionType.mobile) {
            BlocProvider.of<CounterCubit>(context).decrement();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocListener<CounterCubit, CounterState>(
          listener: (context, state) {
            if (state.wasIncremented) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Incremented'),
                  duration: Duration(milliseconds: 300),
                ),
              );
            } else if (!state.wasIncremented) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Decremented'),
                  duration: Duration(milliseconds: 300),
                ),
              );
            }
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BlocBuilder<InternetCubit, InternetState>(
                  builder: (context, state) {
                    if (state is InternetConnected) {
                      if (state.connectionType == ConnectionType.wifi) {
                        return Text(
                          'Wifi',
                          style:
                              Theme.of(context).textTheme.headline3?.copyWith(
                                    color: Colors.green,
                                  ),
                        );
                      } else if (state.connectionType ==
                          ConnectionType.mobile) {
                        return Text(
                          'Mobile',
                          style:
                              Theme.of(context).textTheme.headline3?.copyWith(
                                    color: Colors.green,
                                  ),
                        );
                      }
                    } else if (state is InternetDisconnected) {
                      return Text(
                        'Disconnected',
                        style: Theme.of(context).textTheme.headline3?.copyWith(
                              color: Colors.grey,
                            ),
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                const Text(
                  'You have pushed the button this many times:',
                ),
                BlocBuilder<CounterCubit, CounterState>(
                  builder: (context, state) {
                    if (state.counterValue < 0) {
                      return Text(
                        'BRRR ${state.counterValue}',
                        style: Theme.of(context).textTheme.headline4,
                      );
                    } else if (state.counterValue % 2 == 0) {
                      return Text(
                        'YAAY ${state.counterValue}',
                        style: Theme.of(context).textTheme.headline4,
                      );
                    } else if (state.counterValue == 5) {
                      return Text(
                        'HMM NUMBER 5',
                        style: Theme.of(context).textTheme.headline4,
                      );
                    }

                    return Text(
                      '${state.counterValue}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     FloatingActionButton(
                //       heroTag: Text('${widget.title} #1'),
                //       backgroundColor: widget.color,
                //       onPressed: () {
                //         BlocProvider.of<CounterCubit>(context).decrement();
                //       },
                //       tooltip: 'Decrement',
                //       child: const Icon(Icons.remove),
                //     ),
                //     FloatingActionButton(
                //       heroTag: Text('${widget.title} #2'),
                //       backgroundColor: widget.color,
                //       onPressed: () {
                //         BlocProvider.of<CounterCubit>(context).increment();
                //       },
                //       tooltip: 'Increment',
                //       child: const Icon(Icons.add),
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 24,
                ),
                MaterialButton(
                  color: Colors.redAccent,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/second');
                  },
                  child: const Text(
                    'Go to second Screen',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                MaterialButton(
                  color: Colors.greenAccent,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/third');
                  },
                  child: const Text(
                    'Go to third Screen',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

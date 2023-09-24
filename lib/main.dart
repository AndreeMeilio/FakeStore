import 'package:fake_store/models/requests/authentication/authentication_request_model.dart';
import 'package:fake_store/models/requests/products/products_request_model.dart';
import 'package:fake_store/repositories/authentication/authentication_repository.dart';
import 'package:fake_store/repositories/carts/carts_repository.dart';
import 'package:fake_store/repositories/products/products_repository.dart';
import 'package:fake_store/services/api_helper.dart';
import 'package:fake_store/viewmodels/authentication/authentication_viewmodel.dart';
import 'package:fake_store/viewmodels/carts/carts_viewmodel.dart';
import 'package:fake_store/viewmodels/products/products_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/requests/carts/carts_request_model.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final apiHelper = ApiHelper();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationCubit(
            repo: AuthenticationRepositoryImpl(apiHelper: apiHelper)
          ),
        ),
        BlocProvider(
          create: (context) => ProductsCubit(
            repo: ProductsRepositoryImpl(apiHelper: apiHelper)
          ),
        ),
        BlocProvider(
          create: (context) => CartsCubit(
            repo: CartsReporsitoryImpl(apiHelper: apiHelper)
          )
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
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
  int _counter = 0;

  late ProductsCubit _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<ProductsCubit>(context, listen: false);
  }

  void _incrementCounter() async{
    await _bloc.createProduct(
      data: ProductsRequestModel(
        description: "dafafafa",
        image: "https://lkajd.com",
        price: 1000.0,
        title: "test",
        category: "weonoandf"
      )
    );
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocConsumer<ProductsCubit, ProductsState>(
              builder: (context, state) => Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              listener: (context, state) {
                print(state);
                if (state is ProductsFailedState){
                  print("ERROR ${state.error}");
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

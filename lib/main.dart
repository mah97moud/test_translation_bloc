import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_translation_bloc/shared/di.dart';

import 'bloc/translation_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  String langFile = await getLocaleFile(lanCode: appCode);
  runApp(MyApp(
    langFile: langFile,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.langFile}) : super(key: key);
  final String langFile;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TranslationBloc()
        ..add(LoadLangJsonEvent(langFile))
        ..add(ChangeDirectionEv(locale: appCode ?? 'en')),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslationBloc, TranslationState>(
      builder: (context, state) {
        final locale = state.locale;
        final direction = state.textDirection;
        return Directionality(
          textDirection: direction,
          child: Scaffold(
            appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text('${locale?.flutterDemoHomePage}'),
            ),
            body: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${locale?.lang} ${locale?.world}!',
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                BlocProvider.of<TranslationBloc>(context)
                    .add(const ChangeLanguageEv());
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          ),
        );
      },
    );
  }
}

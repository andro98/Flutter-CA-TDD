import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/widgets.dart';
import 'package:number_trivia/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: SingleChildScrollView(child: buildBody(context)),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      builder: (_) => sl<NumberTriviaBloc>(),
      child: Container(
        margin: EdgeInsets.only(top: 30.0, left: 30.0,right: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
              if (state is Empty) {
                return MessageDisplay(
                  message: 'Start Searching!',
                );
              } else if (state is Loading) {
                return LoadingWidget();
              } else if (state is Loaded) {
                return TriviaDisplay(
                  numberTrivia: state.trivia,
                );
              } else if (state is Error) {
                return MessageDisplay(
                  message: state.message,
                );
              }
            }),
            SizedBox(
              height: 30,
            ),
            TriviaControls(),
          ],
        ),
      ),
    );
  }
}

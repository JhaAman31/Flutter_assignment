import 'package:flutter/material.dart';
import 'package:flutter_assignment/feature/bookmark/book_mark_screen.dart';
import 'package:flutter_assignment/feature/news/presentation/bloc/news_bloc.dart';
import 'package:flutter_assignment/feature/news/presentation/bloc/news_event.dart';
import 'package:flutter_assignment/feature/news/presentation/screens/news_screen.dart';
import 'package:flutter_assignment/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_pallete.dart';
import 'feature/news/presentation/bloc/news_state.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  const HomeScreen({super.key, required this.toggleTheme});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late NewsBloc _newsBloc;

  @override
  void initState() {
    super.initState();
    _newsBloc = bloc<NewsBloc>()..add(FetchArticles(country: 'us'));
  }

  @override
  void dispose() {
    _newsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _newsBloc,
      child: Scaffold(
        body: _buildScreen(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() {
            _selectedIndex = index;
          }),
          backgroundColor: AppPallete.gradient3,
          selectedItemColor: AppPallete.whiteColor,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "News"),
            BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Saved"),
          ],
        ),
      ),
    );
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return const NewsScreen();
      case 1:
        return BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsSuccess) {
              return BookmarkScreen(allArticles: state.article);
            } else if (state is NewsLoading || state is NewsIdle) {
              return const Center(child: CircularProgressIndicator(color:AppPallete.gradient2,));
            } else if (state is NewsError) {
              return Center(child: Text(state.error));
            } else {
              return const Center(child: Text("No data"));
            }
          },
        );
      default:
        return const Center(child: Text("Page not found"));
    }
  }
}

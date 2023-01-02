import 'package:flutter/material.dart';
import 'package:memory_game/confetting_animation.dart';
import 'package:memory_game/instructions.dart';
import 'package:provider/provider.dart';
import 'game_manager.dart';
import 'word.dart';
import 'word_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final widthPadding = deviceSize.width * 0.1;
    List<Word> gridWords = context.read<GameManager>().getGridWords;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Match Starting Letter'),
        backgroundColor: Colors.purple.shade100,
        foregroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.info, size: 30,),
            onPressed: () => showDialog(
                context: context, builder: (context) => const Instructions()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Stack(children: [
            Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 40)),
                GridView.builder(
                  shrinkWrap: true,
                  padding:
                      EdgeInsets.only(left: widthPadding, right: widthPadding),
                  itemCount: gridWords.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: deviceSize.height * 0.2),
                  itemBuilder: (context, index) => WordTile(
                    index: index,
                    word: gridWords[index],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                SizedBox(
                  width: deviceSize.width * 0.5,
                  height: 50,
                  child: Selector<GameManager, bool>(
                    selector: (_, gamemanager) => gamemanager.isGameOver,
                    builder: (_, isGameOver, __) => isGameOver ? ElevatedButton(
                      onPressed: () {
                              setState(() {
                                GameManager gm = context.read<GameManager>();
                                gm.resetWordGrid();
                              });
                            },
                      child: const Text('Restart Game'),
                    ) : Container(),
                  ),
                ),
              ],
            ),
            Selector<GameManager, bool>(
              selector: (_, gamemanager) => gamemanager.isGameOver,
              builder: (_, isGameOver, __) => Container(
                alignment: Alignment.center,
                child: ConfettiAnimation(animate: isGameOver ? true : false),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

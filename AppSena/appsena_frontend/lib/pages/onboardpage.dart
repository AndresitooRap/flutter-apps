import 'package:appsena_frontend/models/onboard.dart';
import 'package:appsena_frontend/pages/mainpage.dart';
import 'package:appsena_frontend/widgets/fade_in_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          PageView.builder(
            onPageChanged: (value) {
              setState(() {
                currentPage = value;
              });
            },
            itemCount: onboards.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  FadeInAnimation(
                    durationInMs: 200,
                    animationPosition: AnimationPosition(
                      topAfter: 20,
                      topBefore: -50,
                      leftAfter: 20,
                      leftBefore: -50,
                    ),
                    child: Image.asset(
                      "assets/img/${onboards[index].image}",
                      width: 350,
                      height: 350,
                      fit: BoxFit.contain,
                    ),
                  ),
                  FadeInAnimation(
                    durationInMs: 200,
                    animationPosition: AnimationPosition(
                      topAfter: 450,
                      topBefore: 500,
                      leftAfter: 25,
                      leftBefore: 25,
                    ),
                    child: Text(
                      onboards[index].text1,
                      style: const TextStyle(
                        fontSize: 45,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  FadeInAnimation(
                    durationInMs: 250,
                    animationPosition: AnimationPosition(
                      topAfter: 610,
                      topBefore: 600,
                      leftAfter: 25,
                      leftBefore: 25,
                    ),
                    child: Text(
                      onboards[index].text2,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          FadeInAnimation(
            durationInMs: 250,
            animationPosition: AnimationPosition(
              topAfter: 700,
              topBefore: 800,
              leftAfter: 25,
              leftBefore: 100,
            ),
            child: Row(
              children: [
                ...List.generate(
                  onboards.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: 5,
                    width: 50,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? Colors.black
                          : Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          FadeInAnimation(
            durationInMs: 250,
            animationPosition: AnimationPosition(
              bottomAfter: 30,
              bottomBefore: -50,
            ),
            child: MaterialButton(
              color: Colors.green[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              height: 72,
              minWidth: MediaQuery.of(context).size.width - 50,
              child: const Center(
                child: Text(
                  "¡Iniciemos!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const MainPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

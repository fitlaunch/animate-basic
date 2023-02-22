import 'package:animate1/hero_details.dart';
import 'package:animate1/zoom_implicite_animate.dart';
import 'package:flutter/material.dart';

@immutable
class Person {
  final String name;
  final int age;
  final String emoji;

  const Person({required this.name, required this.age, required this.emoji});
}

const people = [
  Person(name: 'Suzy', age: 32, emoji: '👩'),
  Person(name: 'Cindy', age: 33, emoji: '🧑🏽‍🎤'),
  Person(
      name: 'Candi and Bambi',
      age: 34,
      emoji: '👩‍❤️‍💋‍👩'), //':[object Set]:'), //ð©‍❤),
];

class HeroPage extends StatelessWidget {
  const HeroPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('People'),
        ),
        body: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ZoomImpliciteAnimate()));
              },
              child: const Text('NEXT ANIMATION'),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                  itemCount: people.length,
                  itemBuilder: (context, index) {
                    final person = people[index];
                    return ListTile(
                      onTap: () {
                        //difference/benefit navigator.of(context).push() vs below??
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HeroDetails(person: person),
                            ));
                      },
                      leading: Hero(
                        tag: person.name,
                        child: Text(
                          person.emoji,
                          style: const TextStyle(fontSize: 60),
                        ),
                      ),
                      title: Text(person.name),
                      subtitle: (person.name.length > 10)
                          ? Text('Both are ${person.age} years old')
                          : Text('${person.age} years old'),
                      trailing: const Icon(Icons.arrow_forward_ios_sharp),
                    );
                  }),
            ),
          ],
        ));
  }
}

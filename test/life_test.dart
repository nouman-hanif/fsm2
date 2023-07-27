import 'package:fsm2/fsm2.dart';
import 'package:test/test.dart';
import 'package:dcli/dcli.dart';

late StateMachine machine;
void main() {
  test('export', () async {
    _createMachine();
    machine.analyse();
    machine.export('test/smcat/life_test.smcat');

    const graph = '''

Twinkle {
	Twinkle => Gestation : Conception;
},
Gestation {
	Gestation => Baby : Born;
},
Baby {
	Baby => Teenager : Puberty;
},
Teenager {
	Teenager => Adult : GetDrunk;
},
Adult {
	Adult => Dead : Death;
},
Dead;
initial => Twinkle : Twinkle;''';

    final lines = read('test/smcat/life_test.smcat')
        .toList()
        .reduce((value, line) => value += '\n$line');

    expect(lines, equals(graph));
  });
}

void _createMachine() {
  machine = StateMachine.create((g) => g
    ..initialState<Twinkle>()
    ..state<Twinkle>((b) => b..on<Conception, Gestation>())
    ..state<Gestation>((b) => b..on<Born, Baby>())
    ..state<Baby>((b) => b..on<Puberty, Teenager>())
    ..state<Teenager>((b) => b..on<GetDrunk, Adult>())
    ..state<Adult>((b) => b..on<Death, Dead>())
    ..state<Dead>((b) {}));
}

class Twinkle implements State {}

class Gestation implements State {}

class Baby implements State {}

class Teenager implements State {}

class Adult implements State {}

class Taxes implements State {}

class Dead implements State {}

class Adulthood implements State {}

class Conception implements Event {}

class Born implements Event {}

class Puberty implements Event {}

class GetDrunk implements Event {}

class Death implements Event {}

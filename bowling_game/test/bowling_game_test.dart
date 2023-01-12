import 'package:bowling_game/bowling_game.dart';
import 'package:test/test.dart';

void main() {
  late BowlingGame sut;
  setUp(() {
    sut = BowlingGame();
  });

  test('test score after first roll is equal to num pins knocked', () {
    //Act
    sut.roll(3);
    //Assert
    expect(sut.score(), 3);
  });

  test('test score after first frame, when not all pins are knocked', () {
    //Act
    sut
      ..roll(3)
      ..roll(2);
    //Assert
    expect(sut.score(), 5);
  });

  test(
      'test spare - when all pins are knocked in 2 rolls,'
      'player get bonus equal to num of pins scored in next roll', () {
    //Act
    sut
      ..roll(2)
      ..roll(2)
      //Roll Spare
      ..roll(7)
      ..roll(3)
      //Roll with spare bonus
      ..roll(4)
      ..roll(1);
    //Assert
    expect(sut.score(), 2 + 2 + 7 + 3 + (2 * 4) + 1);
  });

  test(
      'test strike - when all pins are knock down in first throw in frame. '
      'It ends the frame, and the sum of the next 2 rolls is the bonus', () {
    //Act
    sut
      //Frame 1 (Strike)
      ..roll(10)
      //Frame 2 - 2 bonus points rolls
      ..roll(2)
      ..roll(7)
      //Frame 3
      ..roll(3);
    //Assert
    expect(sut.score(), 10 + 2 * (2 + 7) + 3);
  });

  test('Test Game stops adding points after 10 roll', () {
    //Arrange
    for (int i = 1; i <= 10; i++) {
      sut
        ..roll(2)
        ..roll(3);
    }
    expect(sut.isGameEnded(), true);
    expect(sut.score(), 50);
    //Act
    sut
      ..roll(5)
      ..roll(6);
    //Assert
    expect(sut.score(), 50);
  });

  test('When player hit Strike in last frame, he should get 2 additional rolls',
      () {
    //Arrange
    for (int i = 1; i <= 9; i++) {
      sut
        ..roll(2)
        ..roll(3);
    }
    expect(sut.score(), 45);
    //Act
    //Strike in final frame
    sut.roll(10);
    expect(sut.isGameEnded(), false);
    sut
      ..roll(1)
      ..roll(6);

    //Assert
    expect(sut.isGameEnded(), true);
    expect(sut.score(), 45 + 10 + 2 * 1 + 2 * 6);
  });

  test('When player hit Spare in last frame, he should get 1 additional roll',
      () {
    //Arrange
    for (int i = 1; i <= 9; i++) {
      sut
        ..roll(2)
        ..roll(3);
    }
    expect(sut.score(), 45);
    //Act
    //Spare in final frame
    sut
      ..roll(5)
      ..roll(5);
    expect(sut.isGameEnded(), false);
    sut.roll(6);

    //Assert
    expect(sut.isGameEnded(), true);
    expect(sut.score(), 45 + 10 + 6 * 2);
  });
}

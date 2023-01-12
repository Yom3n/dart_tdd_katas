import 'package:bowling_game/bowling_game.dart';
import 'package:test/test.dart';

void main() {
  test('test score after first roll is equal to num pins knocked', () {
    //Arrange
    final game = BowlingGame();
    //Act
    game.roll(3);
    //Assert
    expect(game.score(), 3);
  });

  test('test score after first frame, when not all pins are knocked', () {
    //Arrange
    final game = BowlingGame();
    //Act
    game
      ..roll(3)
      ..roll(2);
    //Assert
    expect(game.score(), 5);
  });

  test(
      'test spare - when all pins are knocked in 2 rolls,'
      'player get bonus equal to num of pins scored in next roll', () {
    //Arrange
    final game = BowlingGame();
    //Act
    game
      ..roll(2)
      ..roll(2)
      ..roll(7)
      ..roll(3)
      //Roll with spare bonus
      ..roll(4)
      ..roll(1);
    //Assert
    expect(game.score(), 2 + 2 + 7 + 3 + (2 * 4) + 1);
  });

  test(
      'test strike - when all pins are knock down in first throw in frame. '
      'It ends the frame, and the sum of the next 2 rolls is the bonus', () {
    //Arrange
    final game = BowlingGame();
    //Act
    game
      //Frame 1 (Strike)
      ..roll(10)
      //Frame 2 - 2 bonus points rolls
      ..roll(2)
      ..roll(7)
      //Frame 3
      ..roll(3);
    //Assert
    expect(game.score(), 10 + 2 * (2 + 7) + 3);
  });

  test('Test Game end after 10 frames', () {
    //Arrange
    final game = BowlingGame();
    //Act
    for (int i = 1; i <= 10; i++) {
      game
        ..roll(2)
        ..roll(3);
    }
    expect(game.isGameEnded(), true);
    expect(game.score(), 50);
    //Next rolls should not be count
    game
      ..roll(5)
      ..roll(6);
    //Assert
    expect(game.score(), 50);
  });
}

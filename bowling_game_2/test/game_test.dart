import 'dart:math';

import 'package:bowling_game_2/game.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('Test game starts with 10 frames, and on Frame 1', () {
    final sut = Game();
    expect(sut.frames.length, 10);
    expect(sut.frames.last, isA<FinalFrame>());
    expect(sut.currentFrame(), sut.frames.first);
  });

  test('Test score after first roll', () {
    final sut = Game();
    sut.roll(5);
    expect(sut.score(), 5);
  });

  test('Test score after 2 rolls should be sum of pins', () {
    final sut = Game();
    sut.roll(2);
    sut.roll(4);
    expect(sut.score(), 6);
  });

  test('Test game proceeds to 2 Frame after 2 rolls', () {
    final sut = Game();
    sut.roll(2);
    sut.roll(4);
    expect(sut.currentFrame(), sut.frames[1]);
  });

  test('Test proceeding to 2 frame, when first roll is strike', () {
    final sut = Game();
    sut.roll(10);
    expect(sut.currentFrame(), sut.frames[1]);
  });

  test('Test proceeding to 2 frame, when first roll is strike', () {
    final sut = Game();
    sut.roll(10);
    expect(sut.currentFrame(), sut.frames[1]);
  });

  test('Test adding spare bonus', () {
    final sut = Game();
    //1 Frame:
    sut.roll(5);
    sut.roll(5);
    //spare. Should add first roll from next frame to this score
    //2 frame:
    sut.roll(2);
    //2 points in frame 2, and additional 2 points for Frame 1
    expect(sut.score(), 5 + 5 + 2 + 2);
  });

  test('Test adding strike bonus', () {
    final sut = Game();
    //1 Frame:
    sut.roll(10);
    //Strike - should add both rolls from nextFrame
    //2 frame:
    sut.roll(3);
    sut.roll(4);
    expect(sut.score(), 10 + 2 * 3 + 2 * 4);
  });

  test('Test final frame normal', () {
    final sut = Game();
    //1 Frame:
    sut.roll(3);
    sut.roll(4);
    //2 frame:
    sut.roll(3);
    sut.roll(4);
    //3 frame:
    sut.roll(3);
    sut.roll(4);
    //4 frame:
    sut.roll(3);
    sut.roll(4);
    //5 frame:
    sut.roll(3);
    sut.roll(4);
    //6 Frame:
    sut.roll(3);
    sut.roll(4);
    //7 frame:
    sut.roll(3);
    sut.roll(4);
    //8 frame:
    sut.roll(3);
    sut.roll(4);
    //9 frame:
    sut.roll(3);
    sut.roll(4);
    final scoreBeforeFinalFrame = sut.score();

    //FINAL FRAME
    sut.roll(1);
    sut.roll(2);

    expect(sut.score(), scoreBeforeFinalFrame + 1 + 2);
  });
}

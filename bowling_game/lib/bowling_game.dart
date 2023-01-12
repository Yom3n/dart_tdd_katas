const int maxFrameNumber = 10;
const int numAllPins = 10;

class BowlingGame {
  int numFrame = 1;

  int points = 0;

  int currentFramePins = numAllPins;

  bool isFirstRollInFrame = true;

  int numRollsWithBonus = 0;

  void roll(int numPinsKnocked) {
    print("KNOCKED $numPinsKnocked");
    if (isGameEnded()) {
      print("GAME ENDED");
      return;
    }
    if (numRollsWithBonus > 0) {
      points += 2 * numPinsKnocked;
      numRollsWithBonus--;
    } else {
      points += numPinsKnocked;
    }
    currentFramePins -= numPinsKnocked;
    assert(currentFramePins >= 0);

    if (_isStrike(numPinsKnocked)) {
      numRollsWithBonus = 2;
      _goToNextFrame();
      return;
    }

    if (_isSecondRollInFrame()) {
      if (_isSpare()) {
        numRollsWithBonus = 1;
      }
      _goToNextFrame();
      return;
    } else {
      isFirstRollInFrame = false;
    }
  }

  bool isGameEnded() => numFrame > maxFrameNumber && numRollsWithBonus == 0;

  void _goToNextFrame() {
    currentFramePins = numAllPins;
    numFrame++;
    isFirstRollInFrame = true;
  }

  bool _isStrike(int numPinsKnocked) =>
      isFirstRollInFrame && numPinsKnocked == numAllPins;

  bool _isSpare() => currentFramePins == 0;

  bool _isSecondRollInFrame() => !isFirstRollInFrame;

  int score() {
    return points;
  }
}

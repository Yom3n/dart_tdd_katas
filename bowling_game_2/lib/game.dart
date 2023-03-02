class Game {
  late List<Frame> frames;
  late Frame _currentFrame;

  Game() {
    _generateFrames();
    _currentFrame = frames.first;
  }

  void _generateFrames() {
    frames = [FinalFrame()];
    for (int i = 1; i <= 10; i++) {
      frames.add(Frame(frameNumber: 10 - i, nextFrame: frames[i - 1]));
    }
    frames = frames.reversed.toList();
  }

  void roll(int pins) {
    assert(pins > 0 && pins <= 10);
    _currentFrame.addRoll(pins);
    if (_currentFrame.isFinished()) {
      _startNextFrame();
    }
  }

  int score() {
    int score = 0;
    frames.forEach((frame) {
      score += frame.score();
    });
    return score;
  }

  Frame currentFrame() {
    return _currentFrame;
  }

  void _startNextFrame() {
    final indexOfNextFrame = _getCurrentFrameIndex() + 1;
    _currentFrame = frames[indexOfNextFrame];
  }

  int _getCurrentFrameIndex() {
    return frames.indexOf(_currentFrame);
  }
}

class Frame {
  final Frame? nextFrame;
  final int frameNumber;

  List<Roll> rolls = [];

  Frame({
    required this.frameNumber,
    required this.nextFrame,
  });

  int score() {
    if (rolls.isEmpty) {
      return 0;
    }
    int score = 0;
    rolls.forEach((roll) {
      score += roll.pins;
    });
    if (isSpare() && nextFrame?.rolls != null && nextFrame!.rolls.isNotEmpty) {
      score +=
          nextFrame!.rolls.first.pins; //todo getFirstRollPins getSecondRollPins
    }

    if (isStrike() && nextFrame != null && nextFrame!.isFinished()) {
      score += nextFrame!.rolls.first.pins + nextFrame!.rolls.last.pins;
    }
    return score;
  }

  void addRoll(int pins) {
    assert(pins > 0 && pins <= 10);
    assert(rolls.length < 2, 'Cant add more than 2 rolls in frame!');
    rolls.add(Roll(pins));
  }

  bool isFinished() => rolls.length == 2 || isStrike();

  bool isStrike() => rolls.isNotEmpty && rolls.first.pins == 10;

  bool isSpare() =>
      rolls.length == 2 && rolls.first.pins + rolls.last.pins == 10;

  @override
  String toString() {
    return '$frameNumber frame';
  }
}

class FinalFrame extends Frame {
  FinalFrame({super.frameNumber = 10, super.nextFrame = null});
}

class Roll {
  final int pins;

  Roll(this.pins) : assert(pins > 0 && pins <= 10);
}

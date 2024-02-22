import 'dart:math';
import 'dart:io';

void main() {
  // Create two arrays: one for the words and one for the clues
  List<String> words = ["apple", "banana", "cherry", "orange", "pear"];
  List<String> clues = [
    "A fruit that is often red or green",
    "A fruit that is long and curved",
    "A fruit that is small and red",
    "A fruit that is orange (the color and the fruit)",
    "A fruit that is shaped like a pear"
  ];

  // Make sure the arrays are the same length
  if (words.length != clues.length) {
    print("The arrays must be the same length");
    return;
  }

  // Create a random drum with the same length as the words array
  List<int> drum = List<int>.generate(words.length, (index) => index);
  Random random = Random();

  // Play the game
  while (true) {
    // Shuffle the drum
    drum.shuffle(random);

    // Get a random index for the word and clue
    int index = random.nextInt(words.length);

    // Print the clue and ask the user to guess the word
    print("Clue: ${clues[index]}");
    print("Guess the word:");
    String? guess = stdin.readLineSync();

    // Check if the guess is correct
    if (guess != null && guess.toLowerCase() == words[index]) {
      print("Correct! The word was ${words[index]}");
    } else {
      print("Sorry, that's not correct. The word was ${words[index]}");
    }

    // Ask the user if they want to play again
    print("Do you want to play again? (yes/no)");
    String? response = stdin.readLineSync();

    // If the user doesn't want to play again, exit the game
    if (response != null && response.toLowerCase() != "yes") {
      print("Thanks for playing!");
      break;
    }
  }
}

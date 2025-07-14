//Contains the data for the rules page

const List classicTTT = [
  "The game is played on a grid that's 3 squares by 3 squares.",
  "You are X , your friend is O . Players take turns putting their marks in empty squares.",
  "The first player to get 3 of their marks in a row (up, down, across, or diagonally) is the winner.",
  "When all 9 squares are full, the game is over. If no player has 3 marks in a row, the game ends in a tie.",
];

const List tttLock = [
  "The game is played on a grid that's 3 squares by 3 squares.",
  "You are X, your friend is O. Players take turns putting their marks in empty squares.",
  "Each player can have only 3 marks on the board at a time. After placing the fourth mark, the oldest mark is removed automatically.",
  "The tile where the oldest mark was removed becomes locked for the rest of the player's turn and cannot be used again immediately.",
  "The first player to get 3 of her marks in a row (up, down, across, or diagonally) is the winner.",
];

const List anti = [
  "The game is played on a grid that's 3 squares by 3 squares.",
  "You are X, your friend is O. Players take turns putting their marks in empty squares.",
  "The goal is not to get 3 of your marks in a row (up, down, across, or diagonally).",
  "If you make 3 in a row, you lose the game.",
  "The game continues until all 9 squares are filled.",
  "If neither player forms 3 in a row, the game ends in a draw.",
];

const List gobbletgobblerTTT = [
  "The game is played on a grid that's 3 squares by 3 squares.",
  "You are X, your friend is O. Players take turns placing their gobblers on the board.",
  "Each player has 6 gobblers in 3 sizes: small, medium, and large.",
  "On your turn, you can place a new gobbler from your reserve or move one already on the board.",
  "Larger gobblers can be placed over smaller ones, even over your opponent’s pieces.",
  "You cannot move a gobbler that is covered by another gobbler.",
  "The first player to get 3 of their visible gobblers in a row (across, down, or diagonally) wins the game.",
  "If no more moves are possible and no one has 3 in a row, the game ends in a tie.",
];

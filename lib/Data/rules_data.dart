//Contains the data for the rules page

const List classicTTT = [
  "The game is played on a grid that's 3 squares by 3 squares.",
  "You are X , your friend is O . Players take turns putting their marks in empty squares.",
  "The first player to get 3 of her marks in a row (up, down, across, or diagonally) is the winner.",
  "When all 9 squares are full, the game is over. If no player has 3 marks in a row, the game ends in a tie.",
];

const List tttLock = [
  "The game is played on a grid that's 3 squares by 3 squares.",
  "You are X, your friend is O. Players take turns placing their marks in empty squares.",
  "Each player has only 3 marks. After all 3 are placed, placing a new mark will remove the oldest one.",
  "The tile where the oldest mark was removed becomes inactive (greyed out) and can no longer be used.",
  "The first player to get 3 of their marks in a row (across, down, or diagonally) wins the game.",
  "If all remaining tiles are inactive and no one has 3 in a row, the game ends in a tie.",
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

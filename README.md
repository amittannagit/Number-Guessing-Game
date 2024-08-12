# Number Guessing Game

## Description

The Number Guessing Game is a simple command-line game where users are asked to guess a randomly generated number between 1 and 1000. The game keeps track of each user's statistics, including the number of games played and the fewest number of guesses it took to win the game. If a user has played before, they will be greeted with their previous stats. The game is built using Bash and PostgreSQL.

## Features

- Randomly generates a secret number between 1 and 1000.
- Prompts the user to enter their username.
- Tracks the number of games played and the best game (fewest guesses).
- Provides feedback to the user if their guess is too high, too low, or not a valid integer.
- Allows users to quit the game at any time by entering `q` or `exit`.
- Saves user statistics in a PostgreSQL database.

## Usage

### Prerequisites

- Bash (Linux/MacOS/Windows Subsystem for Linux)
- PostgreSQL

### Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/number_guessing_game.git
   cd number_guessing_game
   ```

2. **Create the Database:**

   Connect to the PostgreSQL shell and create the `number_guess` database:

   ```bash
   psql --username=freecodecamp --dbname=postgres
   ```

   Then run the following SQL commands to create the required table:

   ```sql
   CREATE DATABASE number_guess;
   \c number_guess;
   CREATE TABLE users (
     username VARCHAR(22) PRIMARY KEY,
     games_played INT NOT NULL,
     best_game INT
   );
   ```

3. **Run the Game:**

   Make sure the script has executable permissions:

   ```bash
   chmod +x number_guess.sh
   ```

   Start the game by running:

   ```bash
   ./number_guess.sh
   ```

### Playing the Game

1. When you run the game, you will be prompted to enter your username.
2. If the username exists in the database, you will be welcomed back with your game statistics.
3. If it's your first time playing, you will be welcomed as a new user.
4. You will then be asked to guess a number between 1 and 1000.
5. The game will provide feedback if your guess is too high, too low, or not an integer.
6. Keep guessing until you correctly guess the secret number.
7. The game will then update your stats and display the number of guesses it took to find the correct number.
8. To quit the game at any time, enter `q` or `exit`.

### Example Output

```bash
Enter your username:
john
Welcome, john! It looks like this is your first time here.
Guess the secret number between 1 and 1000 (type 'q' to quit):
500
It's higher than that, guess again:
750
It's lower than that, guess again:
625
You guessed it in 3 tries. The secret number was 625. Nice job!
```

## Development

### Git Commit Messages

The project follows a simple commit message convention:

- Initial commit: `Initial commit`
- Subsequent commits should start with:
  - `fix:` for bug fixes
  - `feat:` for new features
  - `refactor:` for code restructuring
  - `chore:` for maintenance tasks
  - `test:` for adding or modifying tests

### Saving Progress

If you need to save the progress of your database:

```bash
pg_dump -cC --inserts -U freecodecamp number_guess > number_guess.sql
```

You can restore your database with:

```bash
psql -U postgres < number_guess.sql
```

## License

This project is open-source and available under the [MIT License](LICENSE).

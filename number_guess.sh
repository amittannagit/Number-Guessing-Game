#!/bin/bash

# Define a variable for the PSQL command with specific flags for output formatting.
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Generate a random number between 1 and 1000 (inclusive).
SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))

# Prompt the user to enter their username.
echo "Enter your username:"
read USERNAME

# Check if the user exists in the database.
USER_INFO=$($PSQL "SELECT games_played, best_game FROM users WHERE username='$USERNAME'")

if [[ -z $USER_INFO ]]
then
  # If user does not exist, this is their first time.
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  
  # Insert the new user's record into the database with default values.
  $PSQL "INSERT INTO users(username, games_played, best_game) VALUES('$USERNAME', 0, NULL)" > /dev/null
else
  # If user exists, display their stats.
  IFS='|' read -r GAMES_PLAYED BEST_GAME <<< "$USER_INFO"
  
  # Remove any extraneous spaces from the retrieved values.
  GAMES_PLAYED=$(echo $GAMES_PLAYED | tr -d ' ')
  BEST_GAME=$(echo $BEST_GAME | tr -d ' ')
  
  # If the user has no recorded best game, display a default message.
  if [[ -z $BEST_GAME ]]
  then
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took 0 guesses."
  else
    # Display the number of games played and the user's best game.
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  fi
fi

# Prompt the user to guess the secret number.
echo "Guess the secret number between 1 and 1000:"

# Initialize the guess count.
GUESS_COUNT=0

# Start the guessing loop.
while true; do
  read GUESS
  
  # Check if the entered guess is a valid integer.
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
  else
    # Increment the guess count.
    ((GUESS_COUNT++))
    
    # Check if the guess is correct.
    if [[ $GUESS -eq $SECRET_NUMBER ]]
    then
      # Notify the user of their success and the number of guesses taken.
      echo "You guessed it in $GUESS_COUNT tries. The secret number was $SECRET_NUMBER. Nice job!"
      
      # Update user stats in the database.
      if [[ -z $USER_INFO ]]
      then
        # For new users, set their games played to 1 and record their best game.
        $PSQL "UPDATE users SET games_played = 1, best_game = $GUESS_COUNT WHERE username='$USERNAME'" > /dev/null
      else
        # For existing users, increment games played and check if the current game is their best.
        $PSQL "UPDATE users SET games_played = games_played + 1 WHERE username='$USERNAME'" > /dev/null
        if [[ $GUESS_COUNT -lt $BEST_GAME || -z $BEST_GAME ]]
        then
          # Update the best game if the current game has fewer guesses.
          $PSQL "UPDATE users SET best_game = $GUESS_COUNT WHERE username='$USERNAME'" > /dev/null
        fi
      fi
      
      # Exit the loop once the guess is correct.
      break
    elif [[ $GUESS -lt $SECRET_NUMBER ]]
    then
      # Provide a hint if the guess is too low.
      echo "It's higher than that, guess again:"
    else
      # Provide a hint if the guess is too high.
      echo "It's lower than that, guess again:"
    fi
  fi
done

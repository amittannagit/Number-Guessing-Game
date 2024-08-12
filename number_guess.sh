#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Generate a random number between 1 and 1000
SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))

# Prompt for username
echo "Enter your username:"
read USERNAME

# Check if user exists
USER_INFO=$($PSQL "SELECT games_played, best_game FROM users WHERE username='$USERNAME'")

if [[ -z $USER_INFO ]]
then
  # User is new
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  $PSQL "INSERT INTO users(username, games_played, best_game) VALUES('$USERNAME', 0, NULL)" > /dev/null
else
  # User exists, display their stats
  IFS='|' read -r GAMES_PLAYED BEST_GAME <<< "$USER_INFO"
  GAMES_PLAYED=$(echo $GAMES_PLAYED | tr -d ' ')
  BEST_GAME=$(echo $BEST_GAME | tr -d ' ')
  if [[ -z $BEST_GAME ]]
  then
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took 0 guesses."
  else
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  fi
fi
echo "Guess the secret number between 1 and 1000:"

GUESS_COUNT=0

while true; do
  read GUESS
  
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
  else
    ((GUESS_COUNT++))
    
    if [[ $GUESS -eq $SECRET_NUMBER ]]
    then
      echo "You guessed it in $GUESS_COUNT tries. The secret number was $SECRET_NUMBER. Nice job!"
      
      # Update user stats
      if [[ -z $USER_INFO ]]
      then
        $PSQL "UPDATE users SET games_played = 1, best_game = $GUESS_COUNT WHERE username='$USERNAME'" > /dev/null
      else
        $PSQL "UPDATE users SET games_played = games_played + 1 WHERE username='$USERNAME'" > /dev/null
        if [[ $GUESS_COUNT -lt $BEST_GAME || -z $BEST_GAME ]]
        then
          $PSQL "UPDATE users SET best_game = $GUESS_COUNT WHERE username='$USERNAME'" > /dev/null
        fi
      fi
      
      break
    elif [[ $GUESS -lt $SECRET_NUMBER ]]
    then
      echo "It's higher than that, guess again:"
    else
      echo "It's lower than that, guess again:"
    fi
  fi
done
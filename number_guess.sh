#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=number_guessing_game --tuples-only -c"

echo "Enter your username:"
read USERNAME
WELCOME_MAIN() {
  VALID_USERNAME=$($PSQL "SELECT username FROM players WHERE username='$USERNAME'") #récupère le username dans la DB s'il existe 
  if [[ -z $VALID_USERNAME ]] #si le username n'existe pas
  then
    #enregistrer le USERNAME dans la base de données s'il n'existe pas
    REGISTRER_USERNAME=$($PSQL "INSERT INTO players(username, games_played, best_game) VALUES('$USERNAME', 0, 0)")
    $REGISTER_USERNAME
    echo "Welcome, $USERNAME! It looks like this is your first time here." # lui afficher une phrase de premier accueil
  else #donc si le username existe
    # récupérer ses statistiques dans le format d'écriture sans espace
    GAMES_PLAYED=$(echo $($PSQL "SELECT games_played FROM players WHERE username='$USERNAME'")| sed -r 's/ //g')
    BEST_GAME=$(echo $($PSQL "SELECT best_game FROM players WHERE username='$USERNAME'")| sed -r 's/ //g')
    # et lui afficher une phrase d'accueil avec ses statistiques 
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses." 
  fi
}

COUNTER=0
GUESSING_NUMBER=$((1+ $RANDOM % 1000)) #générer un nombre secret à deviner
GAME() {
  #echo $GUESSING_NUMBER #A ENLEVER POUR DEBUG
  #Afficher la phrase d'acceuil de jeu
  echo "Guess the secret number between 1 and 1000:"
  #lire l'entrée du joueur
  read GUESS
  #si l'entrée du joueur n'est pas un nombre INT
  if [[ ! $GUESS =~ ^[0-9]+$ ]] #si notre GUESS est le contraire d'être égal à commencer par un nombre ou plus puis finir
  then
    echo "That is not an integer, guess again:"
  fi
  #tant que l'essai GUESS n'est pas égal au numbre à deviner GUESSING_NUMBER
  while [[ $GUESS != $GUESSING_NUMBER ]]
  do
    if [[ $GUESS > $GUESSING_NUMBER ]] #si l'essai est plus haut afficher telle phrase et incrémenter le nombre d'essai
    then
      echo "It's lower than that, guess again:"
      COUNTER=$((COUNTER + 1))
      read GUESS
    fi
    if [[ $GUESS < $GUESSING_NUMBER ]]   #si l'essai est plus bas afficher telle autre phrase et incrémenter le nombre d'essai
    then
      echo "It's higher than that, guess again:"
      COUNTER=$((COUNTER + 1))
      read GUESS
    fi
  done
  if [[ $GUESS == $GUESSING_NUMBER ]] #si le nombre est trouvé
  then
    COUNTER=$((COUNTER + 1)) #incrémenter ce dernier essai
    echo "You guessed it in $COUNTER tries. The secret number was $GUESSING_NUMBER. Nice job!"  #afficher phrase de félicitation
    #echo $COUNTER #TOREMOVE DEBUG
  fi
  #incrémenter la BDD de la partie jouée (games_played)

  #mettre dans une variable le nombre qui s'y trouve
  GAMES_PLAYED=$($PSQL "SELECT games_played FROM players WHERE username='$USERNAME'")
  GAMES_PLAYED=$((GAMES_PLAYED + 1)) #incrémenter cette partie
  REGISTRER_GAMES_PLAYED=$($PSQL "UPDATE players SET games_played=$GAMES_PLAYED WHERE username='$USERNAME'") #envoyer le nouveau nombre dans la BDD
  #modifier la valeur de best_game si celle ci est plus faible (nombre d'esais)
  #récupérer la valeur de best_game
  BEST_GAME=$($PSQL "SELECT best_game FROM players WHERE username='$USERNAME'")
  if [[ $COUNTER < $BEST_GAME ]] || [ $BEST_GAME == 0 ] #si le combre d'essai de cette partie est plus petit que le dernier enregistré ou que c'est le premier (valeur 0)
  then
    REGISTRER_BEST_GAME=$($PSQL "UPDATE players SET best_game=$COUNTER WHERE username='$USERNAME'") #alors remplacer par COUNTER  
  fi   
}

WELCOME_MAIN
GAME

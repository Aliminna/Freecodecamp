#! /bin/bash 

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

MAIN_MENU() {
  VALID_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM properties WHERE atomic_number=$1")
  VALID_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol='$1'")
  VALID_NAME=$($PSQL "SELECT symbol FROM elements WHERE name='$1'")
  if [[ -n $VALID_ATOMIC_NUMBER ]] || [[ -n $VALID_SYMBOL ]] || [[ -n $VALID_NAME ]] #si un argument est une des trois valeurs valides (que l'une des trois n'est pas vide)
  then
    if [[ -n $VALID_SYMBOL ]] || [[ -n $VALID_NAME ]] #si c'est symbol ou nom
    then
      ATOMIC_NUMBER=$(echo $($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1' OR name='$1'")| sed -r 's/ //g') #on récupère l'atomic number correspondant
      #echo $ATOMIC_NUMBER
      #echo "autre cas"
    else #si c'est l'atomic number
      ATOMIC_NUMBER=$(echo $VALID_ATOMIC_NUMBER | sed -r 's/ //g') #on lui assigne directement sa valeur dans la variable
    fi
    NAME=$(echo $($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")| sed -r 's/ //g')
    SYMBOL=$(echo $($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER")| sed -r 's/ //g')
    TYPE=$(echo $($PSQL "SELECT type FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER;") | sed -r 's/ //g')
    ATOMIC_MASS=$(echo $($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")| sed -r 's/ //g')
    MELTING_POINT_CELSIUS=$(echo $($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")| sed -r 's/ //g')
    BOILING_POINT_CELSIUS=$(echo $($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")| sed -r 's/ //g')
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
    exit
  else #donc si aucun des argument n'est valide
    echo -e "I could not find that element in the database."
  fi
}


DELETE_FUNCTION() {
  DELETE_AN_1000_PROPERTIES=$($PSQL "DELETE FROM properties WHERE atomic_number=1000")
  $DELETE_AN_1000_PROPERTIES 
  DELETE_AN_1000_ELEMENTS=$($PSQL "DELETE FROM elements WHERE atomic_number=1000")
  $DELETE_AN_1000_ELEMENTS
  DELETE_TYPE_COLUMN=$($PSQL "ALTER TABLE properties DROP COLUMN type")
  $DELETE_TYPE_COLUMN
}

if [[ -z $1 ]] #si pas d'argument 
then
  echo -e "Please provide an element as an argument." 
  exit #quit le programme
else
  MAIN_MENU $1 #envoyer dans la fonction MAIN en lui transférant l'argument 
fi


DELETE_FUNCTION



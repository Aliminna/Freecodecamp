#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ CUTCUT SALON ~~~~~\n"
echo "Welcome to CUTCUT, how may I help you?"

MAIN_MENU() {
  SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id") 
  echo -e "$SERVICES" | while read SERVICE_ID BAR NAME
  do
    echo "$SERVICE_ID) $NAME"
  done
  # demander au client un service, un numéro de téléphone et son nom dans le cas où le numéro de téléphone est inconnu, et une heure.
  echo -e "\nQuelle prestation désirez vous aujourd'hui ?"
  read SERVICE_ID_SELECTED
  VALID_SERVICE_ID_SELECTED=$($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE_ID_SELECTED") 

#si le service n'existe pas renvoyer au menu principal
  if [[ -z $VALID_SERVICE_ID_SELECTED ]]
  then
    MAIN_MENU "Pick a valid ID please"
  fi

}

GET_INFORMATIONS() {
    #demande de coordonnées téléphoniques 
    echo -e "\nTrès bien, quel est votre numéro de téléphone SVP ?"
    read CUSTOMER_PHONE
    KNOWN_CUSTOMER_PHONE=$($PSQL "SELECT phone FROM customers WHERE phone='$CUSTOMER_PHONE'")
    #si téléphone inconnu, demande du nom + enregistrement infos bdd
    if [[ -z $KNOWN_CUSTOMER_PHONE ]]
    then
      echo -e "\nNous sommes ravis que vous choisissiez nos services pour la première fois, pouvons-nous enregister votre nom ?"
      read CUSTOMER_NAME
      #enregistrer phone + nom dans bdd
      INSERT_CUSTOMER_INFOS=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
    fi
    echo -e "\nMerci pour ces informations, quelle est l'heure de rendez vous désirée ?"
    read SERVICE_TIME
    #inserer le rendez vous (service_id+customer_id) dans table rdv bdd
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
    #echo -e "\nYour ID is $CUSTOMER_ID"
    INSERT_APPOINTMENT_INFOS=$($PSQL "INSERT INTO appointments(service_id, customer_id, time) VALUES('$SERVICE_ID_SELECTED','$CUSTOMER_ID','$SERVICE_TIME')")

    #display a formatted message : I have put you down for a <service> at <time>, <name>.
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
    echo -e "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME." 
  }

MAIN_MENU

GET_INFORMATIONS
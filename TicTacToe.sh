#!/bin/bash -x

echo "*************************Welcome to TICTACTOE WORLD****************************"

declare -a boardOfTicTacToe

PLAYER="X"
COMPUTER="O"

winCount=0;

function resetTheBoard()
{
 count=1;
 for (( i=1; i<=9; i++ ))
 do
   boardOfTicTacToe["$i"]="-";
   count=$(($count+1))
 done
 displayBoard
}

#echo ${boardOfTicTacToe[@]}

function whoPlayFirst()
{
 resultOfToss=$((RANDOM%2))
 if [ $resultOfToss -eq 0 ]
 then
     echo "Player play First....."
     resetTheBoard
     play
 else
     echo "Computer play First..."
 fi
}

function play()
{
 local turn=1;
 while [ $winCount != 1 ]
 do
   read -p "Enter the Position to Insert the "X" : " position
   boardOfTicTacToe["$position"]="X"
   displayBoard
   winInRows
 done
}

function winInRows()
{
   for (( i=1; i<=9; i++ ))
   do
     if [[ ${boardOfTicTacToe["$i"]} == ${boardOfTicTacToe["$i+1"]} ]] && [[ ${boardOfTicTacToe["$i"]} == ${boardOfTicTacToe["$i+2"]} ]]
     then
         echo "you win "
         winCount=1;
     elif [[ ${boardOfTicTacToe["$i+2"]} == ${boardOfTicTacToe["$i+3"]} ]] && [[ ${boardOfTicTacToe["$i+2"]} == ${boardOfTicTacToe["$i+4"]} ]]
     then
         echo "you win "
         winCount=1;
     elif [[ ${boardOfTicTacToe["$i+4"]} == ${boardOfTicTacToe["$i+5"]} ]] && [[ ${boardOfTicTacToe["$i+4"]} == ${boardOfTicTacToe["$i+6"]} ]]
     then
         echo "you win "
         winCount=1;
     fi
   done
}
function displayBoard()
{
   echo "    |---|---|---|"
   echo "    | "${boardOfTicTacToe[1]}" | "${boardOfTicTacToe[2]}" | "${boardOfTicTacToe[3]}" |"
   echo "    |---|---|---|"
   echo "    | "${boardOfTicTacToe[4]}" | "${boardOfTicTacToe[5]}" | "${boardOfTicTacToe[6]}" |"
   echo "    |---|---|---|"
   echo "    | "${boardOfTicTacToe[7]}" | "${boardOfTicTacToe[8]}" | "${boardOfTicTacToe[9]}" |"
   echo "    |---|---|---|"

}

whoPlayFirst
winInRows

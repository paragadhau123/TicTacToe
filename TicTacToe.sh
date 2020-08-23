#!/bin/bash -x

echo "*************************Welcome to TICTACTOE WORLD****************************"

declare -a boardOfTicTacToe

PLAYER="X"
COMPUTER="O"

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
 read -p "Enter the Position to Insert the "X" : " position
 boardOfTicTacToe["$position"]="X"
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
resetTheBoard
whoPlayFirst
displayBoard

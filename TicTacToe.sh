#!/bin/bash -x

echo "*************************Welcome to TICTACTOE WORLD****************************"

declare -a boardOfTicTacToe

function resetTheBoard()
{
 for (( i=1; i<=9; i++ ))
 do
   boardOfTicTacToe["$i"]="-";
 done
}

resetTheBoard

echo ${boardOfTicTacToe[@]}

function whoPlayFirst()
{
 resultOfToss=$((RANDOM%2))
 if [ $resultOfToss -eq 0 ]
 then
     echo "Player play First....."
 else
     echo "Computer play First..."
 fi
}
whoPlayFirst
